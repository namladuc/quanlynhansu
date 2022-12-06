import hashlib
from flask import Flask, render_template, request, redirect, url_for, session, json, jsonify
from flask_mysqldb import MySQL
import MySQLdb.cursors
import functools
import re

app = Flask(__name__)
app.secret_key = 'la nam'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'quan_ly_nhan_su'

mysql = MySQL(app)

# def home_login():
#     return render_template('login.html')

def login_required(func): # need for some router
    @functools.wraps(func)
    def secure_function(*args, **kwargs):
        if "username" not in session:
            return redirect(url_for("login", next=request.url))
        return func(*args, **kwargs)

    return secure_function

@app.route("/home")
def home():
    if 'username' in session.keys():
        return render_template('/index.html', my_user = session['username'])
    return redirect(url_for("login"))
    
@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))

@app.route("/")
@app.route("/login", methods=['GET','POST'])
def login():
    if 'username' in session.keys():
        return redirect(url_for("home"))
    
    if request.method == 'POST':
        details = request.form
        user_name = details['username'].strip()
        password = hashlib.md5(details['current-password'].encode()).hexdigest()
        if 'username' in session.keys():
            return render_template('/index.html', my_user = session['username'])
        
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM qlnv_user WHERE username=%s",(user_name,))
        user_data = cur.fetchall()
        
        if len(user_data)==0:
            return render_template('/general/login.html', user_exits='False', pass_check='False')
        
        if password != user_data[0][2]:
            return render_template('/general/login.html', user_exits='True', pass_check='False')
        
        my_user_data = user_data[0]
        session['username'] = my_user_data
        cur.close()
        return redirect(url_for("home"))
    return render_template('/general/login.html')


# Error Handler
# @app.errorhandler(404)
# def page_not_found(error):
#     return render_template('page_not_found.html'), 404



@app.route("/forgot")
def forgot():
    return render_template('/general/forgot.html')

@login_required
@app.route("/form_add_data_employees", methods=['GET','POST'])
def form_add_data_employees():
    # https://www.youtube.com/watch?v=rFPzo1VnPXU
    cur = mysql.connection.cursor()
    cur.execute("""SELECT * FROM qlnv_chucvu""")
    chucvu = cur.fetchall()
    
    if request.method == 'POST':
        details = request.form
        MNV = details['MNV'].strip()
        TENNV = details['TENNV'].strip()
        MAIL = details['MAIL'].strip()
        DIACHI = details['DIACHI'].strip()
        SDT = details['SDT'].strip()
        NGAYSINH = details['NGAYSINH'].strip()
        NOISINH = details['NOISINH'].strip()
        CMND = details['CMND'].strip()
        NGAYCMND = details['NGAYCMND'].strip()
        NOICMND = details['NOICMND'].strip()
        GIOITINH = details['GIOITINH'].strip()
        CV = details['CV'].strip()
        BANGCAP = details['BANGCAP'].strip()
        HONHAN = details['HONHAN'].strip()
        
        print(MNV, TENNV, MAIL, DIACHI, SDT, NGAYSINH, NOISINH, CMND, NGAYCMND, NOICMND, GIOITINH, CV, BANGCAP, HONHAN)
        
        
        

        
    return render_template('form_add_data_employees.html', chucvu = chucvu, my_user = session['username'])


@app.route("/form_add_data_money")
def form_add_data_money():
    return render_template('form_add_data_money.html')


# @app.route("/")
@app.route("/table_data_employees")
def table_data_employees():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT nv.MaNhanVien, nv.TenNV, nv.DiaChi, nv.NgaySinh, nv.GioiTinh, nv.DienThoai, cv.TenCV
        FROM qlnv_nhanvien nv
        JOIN qlnv_chucvu cv ON nv.MaChucVu = cv.MaCV""")
    nhanvien = cur.fetchall()
    cur.close()
    return render_template('table_data_employees.html', nhanvien = nhanvien, my_user = session['username'])


@app.route("/table_data_money")
def table_data_money():
    return render_template('table_data_money.html', my_user = session['username'])


@app.route("/danh_sach_cham_cong")
def danh_sach_cham_cong():
    return render_template('danh_sach_cham_cong.html', my_user = session['username'])


@app.route("/index")
def index():
    return render_template('index.html', my_user = session['username'])


@app.route("/page_calendar")
def page_calendar():
    return render_template('page_calendar.html', my_user = session['username'])


@app.route("/danh_sach_hop_dong")
def danh_sach_hop_dong():
    return render_template('danh_sach_hop_dong.html', my_user = session['username'])


