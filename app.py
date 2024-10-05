# -*- coding: utf-8 -*-

from flask import Flask, request, jsonify, render_template, url_for
from flask_sqlalchemy import SQLAlchemy
# import matplotlib.pyplot as plt
from werkzeug.utils import secure_filename
from datetime import datetime, time, date
import os

from openai_demo import Generate_Evaluation_Report_By_AI

app = Flask(__name__)

# 配置数据库连接
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:sprine@localhost:3306/spms?charset=utf8mb4'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# 定义路由
@app.route('/')
def index():
    return render_template('index.html')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                     用户登录模块                    """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
class Accounts(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    userid = db.Column(db.Integer, unique=True, nullable=True)
    username = db.Column(db.String(255), unique=True, nullable=True)
    account = db.Column(db.String(255), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)
    rights = db.Column(db.String(255))

    def __repr__(self):
        return '<Accounts {account}>'.format(account=self.account)


@app.route('/login', methods=['POST'])
def check_login():
    data = request.get_json() 
    account = data.get('account')
    password = data.get('password')

    if not account or not password:
        return jsonify({'success': False, 'error': 'Missing accountor password'}), 400
    
    accounts = Accounts.query.filter_by(account=account).first()        

    if accounts and accounts.password == password and accounts.rights == 'normal':
        teacher = Employees.query.filter_by(id=accounts.userid).first()
        return jsonify({'success': True, 
                        'message': 'Login successful',
                        'userid': accounts.userid,
                        'rights': accounts.rights,
                        'username': accounts.username,
                        'faculty': teacher.faculties,
                        'title': teacher.title,
                        'teaching_years': teacher.teaching_years,
                        'phone': teacher.phone,
                        'email': teacher.email,
                        'photoUrl': teacher.photo_url if teacher.photo_url else None  # 处理可能为空的照片 URL
                        }), 200
    elif accounts and accounts.password == password and accounts.rights == 'admin':
        return jsonify({'success': True, 
                        'message': 'Login successful',
                        'userid': accounts.userid,
                        'rights': accounts.rights,
                        'username': accounts.username,
                        }), 200
    else:
        return jsonify({'success': False, 'error': 'Invalid account or password'}), 401

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                     员工管理模块                    """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
class Employees(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    sex = db.Column(db.String(100))
    title = db.Column(db.String(100))
    faculties = db.Column(db.String(100))
    teaching_years = db.Column(db.String(100))
    phone = db.Column(db.String(255))
    email = db.Column(db.String(255))
    photo_url = db.Column(db.String(255))
    photo_filename = db.Column(db.String(255))

# 添加员工
@app.route('/employees', methods=['POST'])
def create_employee():
    data = request.get_json()

    new_employee = Employees(
        name=data['name'],
        sex=data['sex'],
        title=data['title'],
        faculties=data['faculties'],
        phone=data['phone'],  
    )
    db.session.add(new_employee)
    db.session.commit()

    return jsonify({'message': 'Employee created successfully', 'id': new_employee.id}), 201


# 获取所有员工信息
@app.route('/employees', methods=['GET'])
def get_employees():
    try:
        employees = Employees.query.all()

        # 构建包含所有字段的员工信息列表
        result = [{
            'id': emp.id,
            'name': emp.name,
            'sex': emp.sex,
            'title': emp.title,
            'faculties': emp.faculties,
            'teaching_years': emp.teaching_years,
            'phone': emp.phone,
            'email': emp.email,
            'photoUrl': emp.photo_url if emp.photo_url else None  # 处理可能为空的照片 URL
        } for emp in employees]

        return jsonify(result), 200
    except Exception as e:
        return jsonify({'message': 'Failed to retrieve employees', 'error': str(e)}), 500


# 编辑员工信息
@app.route('/employees/<int:employee_id>', methods=['PUT'])
def edit_employee(employee_id):
    employee = Employees.query.get(employee_id)
    if not employee:
        return jsonify({'message': 'Employee not found'}), 404

    data = request.get_json()
    if data.get('name') != '':
        employee.name = data['name']
    if data.get('title') != '':
        employee.title = data['title']
    if data.get('faculties') != '':
        employee.faculties = data['faculties']
    if data.get('phone') != '':
        employee.phone = data['phone']
    if data.get('sex') != '':
        employee.sex = data['sex']
    if data.get('name') == '' and data.get('title') == '' and data.get('faculties') == '' and data.get('phone') == '' and data.get('sex') == '':
        return jsonify({'message': 'No data to update'}), 400
    
    db.session.commit()
    return jsonify({'message': 'Employee updated successfully'}), 200

# 删除员工
@app.route('/employees/<int:employee_id>', methods=['DELETE'])
def delete_employee(employee_id):
    employee = Employees.query.get(employee_id)
    
    if not employee:
        print('Employee not found')
        return jsonify({'message': 'Employee not found'}), 404
    
    salary_data = Salary.query.get(employee_id)
    attendance_data = Attendance.query.filter_by(employee_id=employee_id).first()
    welfare_data = Welfare.query.get(employee_id)
    jx_thev_data = TeacherEvaluation.query.filter_by(teacher_id=employee_id).first()
    jx_perm_data = PerformanceTarget.query.filter_by(teacher_id=employee_id).first()
    jx_stuf_data = StudentFeedback.query.filter_by(teacher_id=employee_id).first()
    jx_colf_data = ColleagueFeedback.query.filter_by(teacher_id=employee_id).first()
    jx_leaf_data = HeadTeacherFeedback.query.filter_by(teacher_id=employee_id).first()
    jx_terv_data = TeacherReview.query.filter_by(teacher_id=employee_id).first()
    jx_tescore_data = TeacherScore.query.get(employee_id)
    
    if salary_data:
        db.session.delete(salary_data)
    if attendance_data:
        db.session.delete(attendance_data)
    if welfare_data:
        db.session.delete(welfare_data)
    if jx_thev_data:
        db.session.delete(jx_thev_data)
    if jx_perm_data:
        db.session.delete(jx_perm_data)
    if jx_stuf_data:
        db.session.delete(jx_stuf_data)
    if jx_colf_data:
        db.session.delete(jx_colf_data)
    if jx_leaf_data:
        db.session.delete(jx_leaf_data)
    if jx_terv_data:
        db.session.delete(jx_terv_data)
    if jx_tescore_data:
        db.session.delete(jx_tescore_data)
    db.session.commit()

    db.session.delete(employee)
    db.session.commit()
    return jsonify({'message': 'Employee deleted successfully'}), 200

# 上传员工照片
@app.route('/employees/<int:employeeId>/upload-photo', methods=['POST'])
def upload_photo(employeeId):
    if 'photo' not in request.files:
        return jsonify({'message': 'No photo file part'}), 400
    file = request.files['photo']
    if file.filename == '':
        return jsonify({'message': 'No selected file'}), 400
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        save_path = os.path.join('./static/uploads/photos', filename)
        file.save(save_path)

        employee = Employees.query.get(employeeId)
        if employee:
            employee.photo_filename = filename
            employee.photo_url = url_for(
                'static', filename='uploads/photos/{}'.format(filename), _external=True)
            db.session.commit()
            return jsonify({'message': 'Photo uploaded successfully'}), 200
        else:
            return jsonify({'message': 'Employee not found'}), 404
    else:
        return jsonify({'message': 'File type not allowed'}), 400
    
# 路由处理删除图片的请求
@app.route('/employees/<int:employee_id>/delete-photo', methods=['DELETE'])
def delete_photo(employee_id):
    # 根据 employee_id 查询员工信息
    employee = Employees.query.get(employee_id)
    if not employee:
        return jsonify({'message': 'Employee not found'}), 404

    # 获取员工的照片文件名
    photo_filename = employee.photo_filename
    if not photo_filename:
        return jsonify({'message': 'Employee has no photo'}), 400

    # 构建照片文件路径
    photo_path = os.path.join('./static/uploads/photos', photo_filename)

    try:
        # 删除照片文件
        os.remove(photo_path)
        # 更新数据库中的员工信息，清空照片相关字段
        employee.photo_filename = None
        employee.photo_url = None
        db.session.commit()
        return jsonify({'message': 'Photo deleted successfully'}), 200
    except Exception as e:
        return jsonify({'message': str(e)}), 500
    
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in {'png', 'jpg', 'jpeg', 'gif'}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                     考勤管理模块                      """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# 定义考勤记录模型类
class Attendance(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    employee_id = db.Column(db.Integer, db.ForeignKey(
        'employees.id'), nullable=False)
    name = db.Column(db.String(100), nullable=False)
    check_in = db.Column(db.String(50))
    check_out = db.Column(db.String(50))
    status = db.Column(db.String(50))  

@app.route('/attendances', methods=['POST'])
def add_attendance():
    data = request.get_json()

    # 获取请求参数
    employee_id = data.get('employeeId')
    start_time = data.get('startTime')
    end_time = data.get('endTime')

    # 检查必要参数是否存在
    if not employee_id or not start_time or not end_time:
        return jsonify({'message': 'Employee ID are required'}), 400

    # 检查员工是否存在
    employee = db.session.get(Employees, employee_id)
    if not employee:
        return jsonify({'message': 'Employee not found'}), 404

    # 获取员工姓名
    employee_name = employee.name

    # 获取当前时间
    timestamp = datetime.now()
    # 将时间格式化为指定格式的字符串
    timestamp = timestamp.strftime('%Y-%m-%d %H:%M:%S')

    # 检查员工是否已有签到记录
    existing_attendance = Attendance.query.filter_by(
        employee_id=employee_id).first()
    if existing_attendance:
        existing_attendance.check_out = timestamp
        existing_attendance.status = calculate_status(start_time, end_time,
                                                      existing_attendance.check_in, timestamp)
    else:
        # 创建新的考勤记录
        new_attendance = Attendance(
            employee_id=employee_id,
            name=employee_name,
            check_in=timestamp,
            status=calculate_status(start_time, end_time, timestamp, 'null')
        )
        db.session.add(new_attendance)

    # 提交数据库事务
    db.session.commit()

    # 返回成功响应
    return jsonify({'message': 'Attendance record added successfully'}), 201


# 将时间字符串（仅包含小时和分钟）转换为 datetime.time 对象
def parse_time_only(time_str):
    # 如果 time_str 已经是 datetime.datetime 类型，则直接获取其时间部分
    if isinstance(time_str, datetime):
        return time_str.time()  # 返回 datetime 对象的时间部分
    else:
        # 否则，尝试解析 time_str 字符串为 datetime 对象
        parsed_time = datetime.strptime(time_str, '%Y-%m-%d %H:%M:%S').time()
        
        # 从解析后的 datetime 对象中提取小时和分钟
        hour = parsed_time.hour
        minute = parsed_time.minute
        
        # 构造新的 time 对象
        extracted_time = time(hour=hour, minute=minute)
        
        return extracted_time

# 计算考勤状态（仅比较小时和分钟部分）
def calculate_status(start_time_str, end_time_str, check_in_str, check_out_str):
    start_time = datetime.strptime(start_time_str, '%H:%M').time()
    end_time = datetime.strptime(end_time_str, '%H:%M').time()
    check_in = parse_time_only(check_in_str)
    if check_out_str != 'null':
        check_out = parse_time_only(check_out_str)
    else:
        check_out = 'null'
    
    if check_out != 'null' and check_in > start_time and check_out < end_time:
        return '迟到,早退'
    elif check_in > start_time:
        return '迟到'
    elif check_out < end_time:
        return '早退'
    else:
        return '正常'

# 获取所有考勤记录
@app.route('/attendances', methods=['GET'])
def get_attendances():
    attendances = Attendance.query.all()

    result = [{
        'id': att.id,
        'employee_id': att.employee_id,
        'employee_name': att.name,
        'check_in': att.check_in,
        'check_out': att.check_out,
        'status': att.status
    } for att in attendances]

    return jsonify(result), 200

# 编辑考勤记录
@app.route('/attendances/<int:attendance_id>', methods=['PUT'])
def edit_attendance(attendance_id):
    data = request.get_json()
    new_check_in = data.get('check_in')
    new_check_out = data.get('check_out')
    start_time = data.get('startTime')
    end_time = data.get('endTime')

    attendance = Attendance.query.get(attendance_id)
    if not attendance:
        return jsonify({'message': 'Attendance record not found'}), 404

    if new_check_in:
        attendance.check_in = new_check_in
    if new_check_out:
        attendance.check_out = new_check_out
    attendance.status = calculate_status(
        start_time, end_time, new_check_in, new_check_out)
    
    db.session.commit()
    return jsonify({'message': 'Attendance record updated successfully'}), 200

# 删除考勤记录
@app.route('/attendances/<int:attendance_id>', methods=['DELETE'])
def delete_attendance(attendance_id):
    attendance = Attendance.query.get(attendance_id)
    if not attendance:
        return jsonify({'message': 'Attendance record not found'}), 404

    db.session.delete(attendance)
    db.session.commit()
    return jsonify({'message': 'Attendance record deleted successfully'}), 200

# 路由：获取当天考勤数据
@app.route('/get_attendance_data')
def get_attendance_data():
    # # 获取当天日期
    # today = date.today()

    # # 查询当天的考勤数据
    # attendance_data = Attendance.query.filter(
    #     db.func.date(Attendance.check_in) == today
    # ).all()
    
    # 查询所有考勤数据
    attendance_data = Attendance.query.all()

    # 构造 JSON 响应数据
    response_data = []
    for att in attendance_data:
        att_dict = {
            'employee_id': att.employee_id,
            'name': att.name,
            'check_in': att.check_in,
            'check_out': att.check_out,
            'status': att.status
        }
        response_data.append(att_dict)

    # 返回 JSON 格式数据
    return jsonify(response_data)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                     薪资管理模块                    """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
class Salary(db.Model):
    __tablename__ = 'salaries'

    employee_id = db.Column(db.Integer, db.ForeignKey('employees.id'), primary_key=True)  
    name = db.Column(db.String(100), nullable=False)
    basic_salary = db.Column(db.Float, nullable=False)
    performance_bonus = db.Column(db.Float)

@app.route('/salaries', methods=['POST'])
def add_salary():
    data = request.get_json()

    new_salary = Salary(
        employee_id=data['employeeId'],
        name=data['name'],
        basic_salary=data['basicSalary'],
        performance_bonus=data.get('performanceBonus', 0.0)
    )
    db.session.add(new_salary)
    db.session.commit()

    return jsonify({'message': 'Salary information added successfully', 'id': new_salary.id}), 201


@app.route('/salaries', methods=['GET'])
def get_salaries():
    salaries_list = Salary.query.all()
    salaries = [
        {
            'employeeId': salary.employee_id, 
            'name': salary.name,
            'basicSalary': salary.basic_salary, 
            'performanceBonus': salary.performance_bonus}
        for salary in salaries_list
    ]

    return jsonify(salaries), 200

# 编辑薪资
@app.route('/salaries/<int:employeeId>', methods=['PUT'])
def edit_salary(employeeId):
    data = request.get_json()
    base = data.get('base')
    bonus = data.get('bonus')

    employee_sal = Salary.query.get(employeeId)
    if not employee_sal:
        return jsonify({'message': 'salary record not found'}), 404

    if base:
        employee_sal.basic_salary = base
    if bonus:
        employee_sal.performance_bonus = bonus
    
    db.session.commit()
    return jsonify({'message': 'salary record updated successfully'}), 200

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                     招聘录用                    """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
class JobInfo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    job = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(200))
    requirement = db.Column(db.String(200))
    email = db.Column(db.String(200))

# 获取所有招聘信息
@app.route('/jobs', methods=['GET'])
def get_all_job_info():
    jobs = JobInfo.query.all()
    job_list = [{'id': job.id, 'job': job.job, 'description': job.description, 'requirement': job.requirement, 'email': job.email} for job in jobs]
    return jsonify(job_list)
# 添加招聘信息
@app.route('/addjob', methods=['POST'])
def create_job():
    data = request.get_json()

    new_job = JobInfo(
        job=data['job'],
        description=data['description'],
        requirement=data.get('requirement', ''),
        email=data.get('email', ''),
    )
    db.session.add(new_job)
    db.session.commit()

    return jsonify({'message': 'Employee created successfully', 'id': new_job.id}), 201

class ApplicantInfo(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    applicantName = db.Column(db.String(100), nullable=False)
    position = db.Column(db.String(200))
    contactWay = db.Column(db.String(200))
    introduce = db.Column(db.String(200))
    
# 获取所有应聘信息
@app.route('/applicants', methods=['GET'])
def get_all_applicant_info():
    applicants = ApplicantInfo.query.all()
    applicant_list = [{'id': applicant.id, 'applicantName': applicant.applicantName, 'position': applicant.position,
                       'contactWay': applicant.contactWay, 'introduce': applicant.introduce} for applicant in applicants]
    return jsonify(applicant_list)

# 添加应聘信息
@app.route('/addapplicant', methods=['POST'])
def create_applicant():
    data = request.get_json()

    new_applicant = ApplicantInfo(
        introduce=data['introduce'],
        applicantName=data['applicantName'],
        position=data.get('position', ''),
        contactWay=data.get('contactWay', ''),
    )
    db.session.add(new_applicant)
    db.session.commit()

    return jsonify({'message': 'Employee created successfully', 'id': new_applicant.position}), 201

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                        福利管理                      """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
class Welfare(db.Model):
    id = db.Column(db.Integer, db.ForeignKey('employees.id'), primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    health_insurance = db.Column(db.Integer)
    retirement_plans = db.Column(db.Integer)
    vacation_policies = db.Column(db.Integer)
    sick_leave = db.Column(db.Integer)
    holiday_bonuses = db.Column(db.Integer)

# 获取所有员工福利信息
@app.route('/welfare', methods=['GET'])
def get_all_welfareInfo():
    employees = Welfare.query.all()
    employee_list = []
    for employee in employees:
        employee_data = {
            'id': employee.id,
            'name': employee.name,
            'health_insurance': employee.health_insurance,
            'retirement_plans': employee.retirement_plans,
            'vacation_policies': employee.vacation_policies,
            'sick_leave': employee.sick_leave,
            'holiday_bonuses': employee.holiday_bonuses
        }
        employee_list.append(employee_data)
    return jsonify({'employees': employee_list}), 200

# 编辑员工福利信息
@app.route('/welfare/<int:employee_id>', methods=['PUT'])
def update_welfare(employee_id):
    data = request.get_json()
    employee = Welfare.query.get(employee_id)
    if not employee:
        return jsonify({'message': 'Employee not found'}), 404

    employee.health_insurance = data.get('health_insurance', employee.health_insurance)
    employee.retirement_plans = data.get('retirement_plans', employee.retirement_plans)
    employee.vacation_policies = data.get('vacation_policies', employee.vacation_policies)
    employee.sick_leave = data.get('sick_leave', employee.sick_leave)
    employee.holiday_bonuses = data.get('holiday_bonuses', employee.holiday_bonuses)

    db.session.commit()

    return jsonify({'message': 'Employee updated successfully'}), 200

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                      绩效评估模块                     """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# 定义绩效评估-任课成绩模型类:包含教师id, 任教科目, 平均成绩, 及格率
class TeacherEvaluation(db.Model):
    __tablename__ = 'jx_achievement'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    teacher_id = db.Column(db.Integer, db.ForeignKey('employees.id'))
    subject = db.Column(db.String(50))
    average_score = db.Column(db.Float)
    passing_rate = db.Column(db.Float)

@app.route('/submit-achievement', methods=['POST'])
def add_teacher_evaluation():
    # 从请求中获取表单数据
    subject = request.form.get('subject')
    averageScore = request.form.get('average')
    passingRate = request.form.get('highest')
    teacherID = request.form.get('teacher_id')

    # 处理这些数据, 平均成绩总10分, 及格率总15分
    averageScoreScore = float(averageScore) * 0.1
    passingRateScore = float(passingRate) * 0.15
    
    # 查找表单中是否存在该teacher_id的数据,若存在则更新,若不存在则新增
    evaluation = TeacherEvaluation.query.filter_by(teacher_id=teacherID).first()
    if evaluation:
        evaluation.subject = subject
        evaluation.average_score = averageScoreScore
        evaluation.passing_rate = passingRateScore
        db.session.commit()
    else:
        new_evaluation = TeacherEvaluation(
            teacher_id=teacherID,
            subject=subject,
            average_score=averageScoreScore,
            passing_rate=passingRateScore,
        )
        db.session.add(new_evaluation)
        db.session.commit()

    # 返回一个简单的响应
    return jsonify({"message": "评估提交成功"})

# 定义绩效评估-绩效目标模型类:包含教师id, 学期开始时间, 学期结束时间, 绩效目标
class PerformanceTarget(db.Model):
    __tablename__ = 'jx_performance_target'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    teacher_id = db.Column(db.Integer, db.ForeignKey('employees.id'))
    start_time = db.Column(db.DateTime)
    end_time = db.Column(db.DateTime)
    target = db.Column(db.Text)

@app.route('/submit-performance', methods=['POST'])
def add_performance_target():
    # 从请求中获取表单数据
    start_time = request.form.get('semester-start')
    end_time = request.form.get('semester-end')
    target = request.form.get('performanceTarget')
    teacherID = request.form.get('teacher_id')
    
    # 查找表单中是否存在该teacher_id的数据,若存在则更新,若不存在则新增
    per_target = PerformanceTarget.query.filter_by(teacher_id=teacherID).first()
    if per_target:
        per_target.start_time = start_time
        per_target.end_time = end_time
        per_target.target = target
        db.session.commit()
    else:
        new_target = PerformanceTarget(
            teacher_id=teacherID,
            start_time=start_time,
            end_time=end_time,
            target=target,
        )
        db.session.add(new_target)
        db.session.commit()

    # 返回一个简单的响应
    return jsonify({"message": "绩效目标设置成功"})

# 定义绩效评估-学生反馈模型类:包含教师id, 教学方法分数, 课堂参与分数, 课程内容分数, 教学态度分数, 其他意见
class StudentFeedback(db.Model):
    __tablename__ ='jx_student_feedbacks'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    teacher_id = db.Column(db.Integer, db.ForeignKey('employees.id'))
    teaching_method = db.Column(db.Float)
    class_participation = db.Column(db.Float)
    course_content = db.Column(db.Float)
    assessment_feedback = db.Column(db.Float)
    teacher_attitude = db.Column(db.Float)
    additional_comments = db.Column(db.Text)
    total_score = db.Column(db.Float)

    
@app.route('/submit-feedback', methods=['POST'])
def submit_feedback():
    # 从请求中获取表单数据
    teachingMethod = request.form.get('teachingMethod')
    classParticipation = request.form.get('classParticipation')
    courseContent = request.form.get('courseContent')
    assessmentFeedback = request.form.get('assessmentFeedback')
    teacherAttitude = request.form.get('teacherAttitude')
    additionalComments = request.form.get('additionalComments')
    teacherID = request.form.get('teacher_id')

    # 处理这些数据,每个问题总分3分,得分等于opetio value * 0.6
    teachingMethodScore = float(teachingMethod) * 0.6
    classParticipationScore = float(classParticipation) * 0.6
    courseContentScore = float(courseContent) * 0.6
    assessmentFeedbackScore = float(assessmentFeedback) * 0.6
    teacherAttitudeScore = float(teacherAttitude) * 0.6

    # 计算总分
    totalScore = teachingMethodScore + classParticipationScore + courseContentScore + assessmentFeedbackScore + teacherAttitudeScore
    
    # 查找表单中是否存在该teacher_id的数据,若存在则更新,若不存在则新增
    feedback = StudentFeedback.query.filter_by(teacher_id=teacherID).first()
    if feedback:
        feedback.teaching_method = teachingMethodScore
        feedback.class_participation = classParticipationScore
        feedback.course_content = courseContentScore
        feedback.assessment_feedback = assessmentFeedbackScore
        feedback.teacher_attitude = teacherAttitudeScore
        feedback.additional_comments = additionalComments
        feedback.total_score = totalScore
        db.session.commit()
    else:
        new_feedback = StudentFeedback(
            teacher_id=teacherID,
            teaching_method=teachingMethodScore,
            class_participation=classParticipationScore,
            course_content=courseContentScore,
            assessment_feedback=assessmentFeedbackScore,
            teacher_attitude=teacherAttitudeScore,
            additional_comments=additionalComments,
            total_score=totalScore
        )
        db.session.add(new_feedback)
        db.session.commit()

    # 返回一个简单的响应
    return jsonify({"message": "反馈提交成功"})

# 定义绩效评估-同事反馈和评价模型类:包含教师id, 同事id, 问题一得分, 问题二得分, 问题三得分, 问题四得分, 问题五得分, 问题六得分, 问题七得分, 综合评价(文字), 总分
class ColleagueFeedback(db.Model):
    __tablename__ = 'jx_colleague_feedbacks'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    teacher_id = db.Column(db.Integer, db.ForeignKey('employees.id'))
    question1_score = db.Column(db.Float)
    question2_score = db.Column(db.Float)
    question3_score = db.Column(db.Float)
    question4_score = db.Column(db.Float)
    question5_score = db.Column(db.Float)
    question6_score = db.Column(db.Float)
    question7_score = db.Column(db.Float)
    overall_evaluation = db.Column(db.Text)
    total_score = db.Column(db.Float)


@app.route('/submit-colleague-feedback', methods=['POST'])
def add_colleague_feedback():
    # 从请求中获取表单数据
    question1Score = request.form.get('professionalExcellence1')
    question2Score = request.form.get('theoryToPractice1')
    question3Score = request.form.get('professionalExcellence2')
    question4Score = request.form.get('theoryToPractice2')
    question5Score = request.form.get('professionalExcellence3')
    question6Score = request.form.get('professionalExcellence4')
    question7Score = request.form.get('theoryToPractice3')
    overallEvaluation = request.form.get('colleague-feedback')
    teacherID = request.form.get('teacher_id')

    # 处理这些数据,每个问题总分3分,得分等于opetio value * 0.6
    question1ScoreScore = float(question1Score) * 0.2
    question2ScoreScore = float(question2Score) * 0.2
    question3ScoreScore = float(question3Score) * 0.2
    question4ScoreScore = float(question4Score) * 0.2
    question5ScoreScore = float(question5Score) * 0.2
    question6ScoreScore = float(question6Score) * 0.2
    question7ScoreScore = float(question7Score) * 0.2

    # 计算总分    
    totalScore = question1ScoreScore + question2ScoreScore + question3ScoreScore + question4ScoreScore + question5ScoreScore + question6ScoreScore + question7ScoreScore
    
    # 查找表单中是否存在该teacher_id的数据,若存在则更新,若不存在则新增
    feedback = ColleagueFeedback.query.filter_by(teacher_id=teacherID).first()
    if feedback:
        feedback.question1_score = question1ScoreScore
        feedback.question2_score = question2ScoreScore
        feedback.question3_score = question3ScoreScore
        feedback.question4_score = question4ScoreScore
        feedback.question5_score = question5ScoreScore
        feedback.question6_score = question6ScoreScore
        feedback.question7_score = question7ScoreScore
        feedback.overall_evaluation = overallEvaluation
        feedback.total_score = totalScore
        db.session.commit()
    else:
        new_feedback = ColleagueFeedback(
            teacher_id=teacherID,
            question1_score=question1ScoreScore,
            question2_score=question2ScoreScore,
            question3_score=question3ScoreScore,
            question4_score=question4ScoreScore,
            question5_score=question5ScoreScore,
            question6_score=question6ScoreScore,
            question7_score=question7ScoreScore,
            overall_evaluation=overallEvaluation,
            total_score=totalScore
        )
        db.session.add(new_feedback)
        db.session.commit()

    # 返回一个简单的响应
    return jsonify({"message": "反馈提交成功"})

# 定义绩效评估-教研组组长反馈和评价模型类:包含教师id, 问题一得分, 问题二得分, 问题三得分, 问题四得分, 问题五得分, 绩效目标完成情况得分, 综合评价(文字), 总分
class HeadTeacherFeedback(db.Model):
    __tablename__ = 'jx_leader_feedbacks'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    teacher_id = db.Column(db.Integer, db.ForeignKey('employees.id'))
    question1_score = db.Column(db.Float)
    question2_score = db.Column(db.Float)
    question3_score = db.Column(db.Float)
    question4_score = db.Column(db.Float)
    question5_score = db.Column(db.Float)
    target_completion_score = db.Column(db.Float)
    overall_evaluation = db.Column(db.Text)
    total_score = db.Column(db.Float)
    

@app.route('/submit-leader-evaluation', methods=['POST'])
def add_head_teacher_feedback():
    # 从请求中获取表单数据
    question1Score = request.form.get('question1')
    question2Score = request.form.get('question2')
    question3Score = request.form.get('question3')
    question4Score = request.form.get('question4')
    question5Score = request.form.get('question5')
    targetCompletionScore = request.form.get('target-completion')
    overallEvaluation = request.form.get('leader-evaluation')
    teacherID = request.form.get('teacher_id')

    # 处理这些数据,每个问题总分3分,得分等于opetio value * 0.6
    question1ScoreScore = float(question1Score) * 1.0
    question2ScoreScore = float(question2Score) * 1.0
    question3ScoreScore = float(question3Score) * 1.0
    question4ScoreScore = float(question4Score) * 1.0
    question5ScoreScore = float(question5Score) * 1.0
    targetCompletionScoreScore = float(targetCompletionScore) * 1.0

    # 计算总分    
    totalScore = question1ScoreScore + question2ScoreScore + question3ScoreScore + question4ScoreScore + question5ScoreScore + targetCompletionScoreScore
    
    # 查找表单中是否存在该teacher_id的数据,若存在则更新,若不存在则新增
    feedback = HeadTeacherFeedback.query.filter_by(teacher_id=teacherID).first()
    if feedback:
        feedback.question1_score = question1ScoreScore
        feedback.question2_score = question2ScoreScore
        feedback.question3_score = question3ScoreScore
        feedback.question4_score = question4ScoreScore
        feedback.question5_score = question5ScoreScore
        feedback.target_completion_score = targetCompletionScoreScore
        feedback.overall_evaluation = overallEvaluation
        feedback.total_score = totalScore
        db.session.commit()
    else:
        new_feedback = HeadTeacherFeedback(
            teacher_id=teacherID,
            question1_score=question1ScoreScore,
            question2_score=question2ScoreScore,
            question3_score=question3ScoreScore,
            question4_score=question4ScoreScore,
            question5_score=question5ScoreScore,
            target_completion_score=targetCompletionScoreScore,
            overall_evaluation=overallEvaluation,
            total_score=totalScore
        )
        db.session.add(new_feedback)
        db.session.commit()

    # 返回一个简单的响应
    return jsonify({"message": "反馈提交成功"})

# 定义绩效评估-教师本人回顾总结模型类:包含教师id, 科研成果数量, 科研成果列举(文字), 回顾总结(列举), 总分
class TeacherReview(db.Model):
    __tablename__ = 'jx_self_reviews'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    teacher_id = db.Column(db.Integer, db.ForeignKey('employees.id'))
    session_count = db.Column(db.Integer)
    session_list = db.Column(db.Text)
    research_result_count = db.Column(db.Integer)
    research_result_list = db.Column(db.Text)
    review_summary = db.Column(db.Text)
    total_score = db.Column(db.Float)


@app.route('/submit-self-summary', methods=['POST'])
def add_teacher_review():
    # 从请求中获取表单数据
    sessionCount = request.form.get('session-count')
    sessionList = request.form.get('sessionList')
    researchResultCount = request.form.get('research-count')
    researchResultList = request.form.get('researchResults')
    reviewSummary = request.form.get('selfSummary')
    teacherID = request.form.get('teacher_id')

    # 处理这些数据,每个问题总分3分,得分等于opetio value * 0.6
    researchResultCountScore = float(researchResultCount) * 0.6

    # 计算总分    
    totalScore = researchResultCountScore

    # 查找表单中是否存在该teacher_id的数据,若存在则更新,若不存在则新增
    review = TeacherReview.query.filter_by(teacher_id=teacherID).first()
    if review:
        review.session_count = sessionCount
        review.session_list = sessionList
        review.research_result_count = researchResultCount
        review.research_result_list = researchResultList
        review.review_summary = reviewSummary
        review.total_score = totalScore
        db.session.commit()
    else:
        new_review = TeacherReview(
            teacher_id=teacherID,
            session_count=sessionCount,
            session_list=sessionList,
            research_result_count=researchResultCountScore,
            research_result_list=researchResultList,
            review_summary=reviewSummary,
            total_score=totalScore
        )
        db.session.add(new_review)
        db.session.commit()

    # 返回一个简单的响应
    return jsonify({"message": "反馈提交成功"})

# 定义绩效评估-教师绩效得分表模型类:包含教师id, 姓名, 职称, 院系, 分数
class TeacherScore(db.Model):
    __tablename__ = 'jx_teacher_scores'
    
    teacher_id = db.Column(db.Integer, db.ForeignKey('employees.id'), primary_key=True)
    name = db.Column(db.String(100))
    title = db.Column(db.String(50))
    department = db.Column(db.String(50))
    score = db.Column(db.Float)
    
@app.route('/evaluations-scoretable', methods=['GET'])
def get_eva_scores():
    try:
        eva_scores = TeacherScore.query.all()
        result = [{
            'teacher_id': acc.teacher_id,
            'name': acc.name,
            'title': acc.title,
            'department': acc.department,
            'score': acc.score
        } for acc in eva_scores]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({'message': 'Failed to get evaluations score table.', 'error': str(e)}), 500
    
    
@app.route('/generate-teacher-report/<int:teacherId>', methods=['GET'])
def generate_evaluater_report(teacherId):
    # 找到该教师的绩效评估数据
    teacher_info = Employees.query.filter_by(id=teacherId).first()
    achi_score = TeacherEvaluation.query.filter_by(teacher_id=teacherId).first()
    per_target = PerformanceTarget.query.filter_by(teacher_id=teacherId).first()
    stu_feedback = StudentFeedback.query.filter_by(teacher_id=teacherId).first()
    col_feedback = ColleagueFeedback.query.filter_by(teacher_id=teacherId).first()
    leader_feedback = HeadTeacherFeedback.query.filter_by(teacher_id=teacherId).first()
    teacher_review = TeacherReview.query.filter_by(teacher_id=teacherId).first()
    
    teacher_score = TeacherScore.query.filter_by(teacher_id=teacherId).first()
    
    # 检查上述数据是否均存在
    if not achi_score or not per_target or not stu_feedback or not col_feedback or not leader_feedback or not teacher_review:
        return jsonify({'message': '请先提交教师相关绩效表单。'}), 200
    
    # 课堂教学能力得分 Classromm teaching ability score
    cts = leader_feedback.question1_score + leader_feedback.question2_score + leader_feedback.question3_score
    # 课程设计与规划得分 Course design and planning score
    cdp = leader_feedback.question4_score + leader_feedback.question5_score
    # 学生评价得分 Student evaluation score
    se = stu_feedback.total_score
    # 平均成绩得分 Average score
    avg = achi_score.average_score
    # 及格率得分 Pass rate score
    pr = achi_score.passing_rate
    # 持续教育得分 Continuous education score
    if teacher_review.session_count <= 5:
        ce = teacher_review.session_count * 2
    else:
        ce = 10
    # 研究与创新得分 Research and innovation score
    if teacher_review.research_result_count <= 4:
        ri = teacher_review.research_result_count * 2.5
    else:
        ri = 10
    # 同事评价得分 Colleague evaluation score
    coe = col_feedback.total_score + 3.0
    # 教师绩效目标完成情况得分 Teacher performance target score
    tpt = leader_feedback.target_completion_score
    # 总分
    total_score = cts + cdp + se + avg + pr + ce + ri + coe + tpt
    
    if teacher_score:
        teacher_score.score = total_score
        db.session.commit()
    else:
        new_score = TeacherScore(
            teacher_id=teacherId,
            name=teacher_info.name,
            title=teacher_info.title,
            department=teacher_info.faculties,
            score=total_score
        )
        db.session.add(new_score)
        db.session.commit()
    
    # Overview_text = f"教师绩效目标:{per_target.target};学生反馈与评价:{stu_feedback.additional_comments};同事评价:{col_feedback.overall_evaluation};教研组长评价:{leader_feedback.overall_evaluation};教师本人回顾总结:{teacher_review.review_summary};绩效目标完成情况(5分制):{tpt};该教师绩效评估总分:{total_score}.请根据上述内容给出针对该教师的综合评价并且以'{teacher_info.name}教师'作为开头(200字以内)"
    
    Overview_text = "教师绩效目标:{target};学生反馈与评价:{stu_feedback};同事评价:{col_feedback};教研组长评价:{leader_feedback};教师本人回顾总结:{teacher_review};绩效目标完成情况(5分制):{tpt};该教师绩效评估总分:{total_score}.请根据上述内容给出针对该教师的综合评价并且以'{name}教师'作为开头(200字以内)".format(
        target=per_target.target,
        stu_feedback=stu_feedback.additional_comments,
        col_feedback=col_feedback.overall_evaluation,
        leader_feedback=leader_feedback.overall_evaluation,
        teacher_review=teacher_review.review_summary,
        tpt=tpt,
        total_score=total_score,
        name=teacher_info.name
    )
    
    # Development_text = f"教师绩效目标:{per_target.target};学生反馈与评价:{stu_feedback.additional_comments};同事评价:{col_feedback.overall_evaluation};教研组长评价:{leader_feedback.overall_evaluation};教师本人回顾总结:{teacher_review.review_summary};绩效目标完成情况(5分制):{tpt};该教师绩效评估总分:{total_score}.请根据上述内容给出针对该教师的发展建议,要求列举给出并且以'{teacher_info.name}教师'作为开头(200字以内)"
    
    Development_text = "教师绩效目标:{target};学生反馈与评价:{stu_feedback};同事评价:{col_feedback};教研组长评价:{leader_feedback};教师本人回顾总结:{teacher_review};绩效目标完成情况(5分制):{tpt};该教师绩效评估总分:{total_score}.请根据上述内容给出针对该教师的发展建议,要求列举给出并且以'{name}教师'作为开头(200字以内)".format(
        target=per_target.target,
        stu_feedback=stu_feedback.additional_comments,
        col_feedback=col_feedback.overall_evaluation,
        leader_feedback=leader_feedback.overall_evaluation,
        teacher_review=teacher_review.review_summary,
        tpt=tpt,
        total_score=total_score,
        name=teacher_info.name
    )
    
    ai_answer_1 = Generate_Evaluation_Report_By_AI(Overview_text)
    ai_answer_2 = Generate_Evaluation_Report_By_AI(Development_text)
    
    data = {
        'average_score': achi_score.average_score if achi_score else 0,
        'pass_rate': achi_score.passing_rate if achi_score else 0,
        'per_target': per_target.target if per_target else '无',
        'stu_feedback': stu_feedback.additional_comments if stu_feedback else '无',
        'col_feedback': col_feedback.overall_evaluation if col_feedback else '无',
        'leader_eval': leader_feedback.overall_evaluation if leader_feedback else '无',
        'self_review': teacher_review.review_summary if teacher_review else '无',
        'cts': cts,
        'cdp': cdp,
        'se': se,
        'avg': avg,
        'pr': pr,
        'ce': ce,
        'ri': ri,
        'coe': coe,
        'tpt': tpt,
        'total_score': total_score,
        'ai_answer_1': ai_answer_1,
        'ai_answer_2': ai_answer_2
    }

    return jsonify(data), 200
    
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                      员工反馈模块                     """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
class Feedback(db.Model):
    __tablename__ = 'feedbacks'
    number = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100))  
    feedback_type = db.Column(db.String(50))  
    comments = db.Column(db.Text)  
    date = db.Column(db.DateTime, default=datetime.now) 
    
@app.route('/feedbacks', methods=['GET'])
def get_feedbacks():
    try:
        feedbacks = Feedback.query.all()
        result = [{
            'name': fb.name,
            'feedback_type': fb.feedback_type,
            'comments': fb.comments,
            'date': fb.date
        } for fb in feedbacks]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({'message': 'Failed', 'error': str(e)}), 500

# 添加账号
@app.route('/feedbacks', methods=['POST'])
def add_feedback():
    data = request.get_json()

    new_feedback = Feedback(
        name=data['name'],
        feedback_type=data['feedback_type'],
        comments=data['comments'],
        date=datetime.now(),
    )
    db.session.add(new_feedback)
    db.session.commit()

    return jsonify({'message': 'add feedback successfully'}), 201


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                      账号管理模块                     """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
@app.route('/accounts', methods=['GET'])
def get_accounts():
    try:
        accounts = Accounts.query.all()
        result = [{
            'id': acc.id,
            'userid': acc.userid,
            'username': acc.username,
            'account': acc.account,
            'rights': acc.rights
        } for acc in accounts]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({'message': 'Failed to retrieve accounts', 'error': str(e)}), 500
    
# 添加账号
@app.route('/accounts', methods=['POST'])
def add_account():
    data = request.get_json()

    new_account = Accounts(
        account=data['account'],
        password=data['password'],  
        rights=data['rights'],  
    )
    db.session.add(new_account)
    db.session.commit()

    return jsonify({'message': 'add successfully'}), 201
    
# 修改密码
@app.route('/accounts/<int:account_id>', methods=['PUT'])
def edit_account_password(account_id):
    new_password = request.get_json()['password']

    account = Accounts.query.get(account_id)
    if not account:
        return jsonify({'message': 'Account not found'}), 404

    account.password = new_password
    db.session.commit()
    return jsonify({'message': 'Account password updated successfully'}), 200

@app.route('/accounts/edit_rights/<int:account_id>', methods=['PUT'])
def edit_account_rights(account_id):
    rights = request.get_json()['rights']

    account = Accounts.query.get(account_id)
    if not account:
        return jsonify({'message': 'Account not found'}), 404

    account.rights = rights
    db.session.commit()
    return jsonify({'message': 'Account rights updated successfully'}), 200

# 注销账号
@app.route('/accounts/<int:account_id>', methods=['DELETE'])
def delete_account(account_id):
    account = Accounts.query.get(account_id)
    if not account:
        return jsonify({'message': 'Account not found'}), 404

    db.session.delete(account)
    db.session.commit()
    return jsonify({'message': 'Account deleted successfully'}), 200


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                          MAIN                        """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if __name__ == '__main__':
    with app.app_context():
        db.create_all()  # 创建所有未存在的表
    app.run(debug=True)
