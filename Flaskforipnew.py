from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_cors import CORS
import uuid

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/course_feedback_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
CORS(app)

# Models
class User(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    username = db.Column(db.String(50), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)
    role = db.Column(db.Enum('student', 'instructor'), default='student', nullable=False)

class Course(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    name = db.Column(db.String(100), nullable=False)
    instructor = db.Column(db.String(100), nullable=False)

class Feedback(db.Model):
    id = db.Column(db.String(36), primary_key=True, default=lambda: str(uuid.uuid4()))
    course_id = db.Column(db.String(36), db.ForeignKey('course.id'), nullable=False)
    user_id = db.Column(db.String(36), db.ForeignKey('user.id'), nullable=True)
    difficulty = db.Column(db.Integer, nullable=False)
    learning_experience = db.Column(db.Integer, nullable=False)
    comment = db.Column(db.Text, nullable=True)
    instructor_response = db.Column(db.Text, nullable=True)
    anonymous = db.Column(db.Boolean, default=True)
    username = db.Column(db.String(50), nullable=True)

# Routes
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    if not data or 'username' not in data or 'password' not in data or 'role' not in data:
        return jsonify({'message': 'Missing username, password, or role'}), 400
    if data['role'] not in ['student', 'instructor']:
        return jsonify({'message': 'Invalid role'}), 400
    if User.query.filter_by(username=data['username']).first():
        return jsonify({'message': 'Username already exists'}), 409
    hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')
    user = User(username=data['username'], password=hashed_password, role=data['role'])
    db.session.add(user)
    db.session.commit()
    return jsonify({'message': 'User registered successfully'}), 201

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if not data or 'username' not in data or 'password' not in data:
        return jsonify({'message': 'Missing username or password'}), 400
    user = User.query.filter_by(username=data['username']).first()
    if user and bcrypt.check_password_hash(user.password, data['password']):
        return jsonify({'user_id': user.id, 'message': 'Login successful', 'role': user.role, 'username': user.username}), 200
    return jsonify({'message': 'Invalid credentials'}), 401

@app.route('/instructors', methods=['GET'])
def get_instructors():
    instructors = User.query.filter_by(role='instructor').all()
    return jsonify([{'username': i.username} for i in instructors])

@app.route('/courses', methods=['GET'])
def get_courses():
    instructor_name = request.args.get('instructor_name')
    if instructor_name:
        courses = Course.query.filter_by(instructor=instructor_name).all()
    else:
        courses = Course.query.all()
    return jsonify([{'id': c.id, 'name': c.name, 'instructor': c.instructor} for c in courses])

@app.route('/add-course', methods=['POST'])
def add_course():
    data = request.get_json()
    if not data or 'name' not in data or 'instructor' not in data:
        return jsonify({'message': 'Missing course name or instructor'}), 400
    if not User.query.filter_by(username=data['instructor'], role='instructor').first():
        return jsonify({'message': 'Invalid instructor'}), 400
    new_course = Course(name=data['name'], instructor=data['instructor'])
    db.session.add(new_course)
    db.session.commit()
    return jsonify({'message': 'Course added successfully'}), 201

@app.route('/feedback', methods=['POST'])
def submit_feedback():
    data = request.get_json()
    required_fields = ['course_id', 'difficulty', 'learning_experience']
    if not all(k in data for k in required_fields):
        return jsonify({'message': 'Missing feedback fields'}), 400
    feedback = Feedback(
        course_id=data['course_id'],
        user_id=data.get('user_id') if data.get('anonymous', True) is False else None,
        difficulty=int(data['difficulty']),
        learning_experience=int(data['learning_experience']),
        comment=data.get('comment'),
        anonymous=data.get('anonymous', True),
        username=data.get('username') if data.get('anonymous', True) is False else None
    )
    db.session.add(feedback)
    db.session.commit()
    return jsonify({'message': 'Feedback submitted successfully'}), 201

@app.route('/feedback/<course_id>', methods=['GET'])
def get_feedback(course_id):
    feedbacks = Feedback.query.filter_by(course_id=course_id).all()
    return jsonify([{
        'id': f.id,
        'difficulty': f.difficulty,
        'learning_experience': f.learning_experience,
        'comment': f.comment,
        'instructor_response': f.instructor_response,
        'anonymous': f.anonymous,
        'username': f.username
    } for f in feedbacks])

@app.route('/feedback/user/<user_id>', methods=['GET'])
def get_user_feedback(user_id):
    feedbacks = Feedback.query.filter_by(user_id=user_id).all()
    return jsonify([{
        'id': f.id,
        'course_id': f.course_id,
        'difficulty': f.difficulty,
        'learning_experience': f.learning_experience,
        'comment': f.comment,
        'instructor_response': f.instructor_response,
        'anonymous': f.anonymous,
        'username': f.username
    } for f in feedbacks])

@app.route('/feedback/instructor/<instructor_name>', methods=['GET'])
def get_feedback_by_instructor(instructor_name):
    courses = Course.query.filter_by(instructor=instructor_name).all()
    course_ids = [course.id for course in courses]
    if not course_ids:
        return jsonify([])
    feedbacks = Feedback.query.filter(Feedback.course_id.in_(course_ids)).all()
    return jsonify([{
        'id': f.id,
        'course_id': f.course_id,
        'difficulty': f.difficulty,
        'learning_experience': f.learning_experience,
        'comment': f.comment,
        'instructor_response': f.instructor_response,
        'anonymous': f.anonymous,
        'username': f.username
    } for f in feedbacks])

@app.route('/feedback/response-by-instructor', methods=['POST'])
def add_response_by_instructor():
    data = request.get_json()
    instructor_name = data.get('instructor_name')
    course_name = data.get('course_name')
    response_text = data.get('response')
    if not instructor_name or not course_name or not response_text:
        return jsonify({'message': 'Missing fields'}), 400
    course = Course.query.filter_by(name=course_name, instructor=instructor_name).first()
    if not course:
        return jsonify({'message': 'Course not found'}), 404
    feedbacks = Feedback.query.filter_by(course_id=course.id).all()
    if not feedbacks:
        return jsonify({'message': 'No feedback found for this course'}), 404
    for fb in feedbacks:
        fb.instructor_response = response_text
    db.session.commit()
    return jsonify({'message': 'Responses added successfully'})

@app.route('/feedback/<feedback_id>/response', methods=['POST'])
def add_instructor_response(feedback_id):
    data = request.get_json()
    if 'response' not in data:
        return jsonify({'message': 'Missing response text'}), 400
    feedback = Feedback.query.get(feedback_id)
    if feedback:
        feedback.instructor_response = data['response']
        db.session.commit()
        return jsonify({'message': 'Response added successfully'}), 200
    else:
        return jsonify({'message': 'Feedback not found'}), 404

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True, host='0.0.0.0', port=5000)