import hashlib
from flask import Flask, render_template, request, redirect, url_for, session, json, jsonify
from flask_mysqldb import MySQL
from werkzeug.utils import secure_filename
import os
import MySQLdb.cursors
import functools
import re

app = Flask(__name__)
app.secret_key = 'la nam'

UPLOAD_FOLDER = 'static/web'
UPLOAD_FOLDER_IMG = 'static/web/img'

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'quan_ly_nhan_su'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['UPLOAD_FOLDER_IMG'] = UPLOAD_FOLDER_IMG

mysql = MySQL(app)

def login_required(func): # need for some router
    @functools.wraps(func)
    def secure_function(*args, **kwargs):
        if "username" not in session:
            return redirect(url_for("login", next=request.url))
        return func(*args, **kwargs)

    return secure_function
    
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
        cur.execute("""SELECT us.*, img.PathToImage
                FROM qlnv_user us
                JOIN qlnv_nhanvien nv ON us.MaNhanVien = nv.MaNhanVien
                JOIN qlnv_imagedata img ON nv.ID_profile_image = img.ID_image
                WHERE username=%s""",(user_name,))
        user_data = cur.fetchall()
        
        if len(user_data)==0:
            return render_template('/general/login.html', user_exits='False', pass_check='False')
        
        if password != user_data[0][2]:
            return render_template('/general/login.html', user_exits='True', pass_check='False')
        
        cur.execute("SELECT * FROM qlnv_congty")
        congty = cur.fetchall()[0]
        
        my_user = tuple(list(user_data[0]) + list(congty))
        session['username'] = my_user
        cur.close()
        return redirect(url_for("home"))
    return render_template('/general/login.html')


@app.route("/home")
def home():
    if 'username' in session.keys():
        return render_template('/index.html', my_user = session['username'])
    return redirect(url_for("login"))

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
    
    cur.execute("""SELECT * FROM qlnv_trinhdohocvan""")
    trinhdohocvan = cur.fetchall()
    
    cur.execute("""SELECT * FROM qlnv_phongban""")
    phongban = cur.fetchall()
    
    if request.method == 'POST':
        cur.execute("""SELECT MaNhanVien FROM qlnv_nhanvien""")
        danh_sach_ma_nhan_vien = cur.fetchall()
        
        details = request.form
        MNV = details['MNV'].strip()
        TENNV = details['TENNV'].strip()
        MAIL = details['MAIL'].strip()
        DIACHI = details['DIACHI'].strip()
        SDT = details['SDT'].strip()
        BHYT = details['BHYT'].strip()
        BHXH = details['BHXH'].strip()
        NGAYSINH = details['NGAYSINH'].strip()
        NOISINH = details['NOISINH'].strip()
        CMND = details['CMND'].strip()
        NGAYCMND = details['NGAYCMND'].strip()
        NOICMND = details['NOICMND'].strip()
        GIOITINH = details['GIOITINH'].strip()
        MATDHV = details['MATDHV'].strip().split(" - ")[0]
        HONHAN = details['HONHAN'].strip()
        LUONG = details['LUONG'].strip()
        MAHD = details['MAHD'].strip()
        DANTOC = details['DANTOC']
        CV = details['CV'].strip()
        PB = details['MAPB'].strip()
        ID_image = "none_image_profile"
        
        for data in danh_sach_ma_nhan_vien:
            if MNV in data:
                return render_template('form_add_data_employees.html',
                            ma_err="True",
                            trinhdohocvan = trinhdohocvan, 
                            chucvu = chucvu,
                            phongban = phongban,
                            my_user = session['username'])
        
        for data in chucvu:
            if (CV in data):
                CV = data[0]
                break;
        
        for data in phongban:
            if (PB in data):
                PB = data[0]
                break;
        
        image_profile = request.files['ImageProfileUpload']
        
        if image_profile.filename != '':
            ID_image = "Image_Profile_" + MNV 
            filename = ID_image + "." + secure_filename(image_profile.filename).split(".")[1]
            pathToImage = app.config['UPLOAD_FOLDER_IMG'] + "/" + filename
            image_profile.save(pathToImage)
            take_image_to_save(ID_image, pathToImage)
        
        cur.execute("""INSERT INTO `qlnv_nhanvien` 
            (MaNhanVien, MaChucVu, MaPhongBan,
            Luong, GioiTinh, MaHD, TenNV,
            NgaySinh, NoiSinh, SoCMT, DienThoai,
            DiaChi, Email, TTHonNhan, DanToc,
            MATDHV, NgayCMND, NoiCMND, BHYT, BHXH, ID_profile_image)
            VALUES
            (%s, %s, %s, %s, %s, %s,
             %s, %s, %s, %s, %s, %s,
             %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
            (MNV, CV, PB, LUONG, GIOITINH, MAHD,
            TENNV, NGAYSINH, NOISINH, CMND, SDT, DIACHI,
            MAIL, HONHAN, DANTOC, MATDHV, NGAYCMND, NOICMND, BHYT, BHXH, ID_image))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for("table_data_employees"))
    return render_template('form_add_data_employees.html',
                           trinhdohocvan = trinhdohocvan, 
                           chucvu = chucvu,
                           phongban = phongban,
                           my_user = session['username'])


@login_required
@app.route("/delete_nhan_vien/<string:maNV>")
def delete_nhan_vien(maNV):
    cur = mysql.connection.cursor()
    cur.execute("SELECT ID_profile_image FROM qlnv_nhanvien WHERE MaNhanVien=%s", (maNV, ))
    id_image = cur.fetchall()
    
    if (id_image != "none_image_profile"):
        cur.execute("SELECT * FROM qlnv_imagedata WHERE ID_image=%s", (id_image, ))
        image_path = "static/" + cur.fetchall()[0][1]
        if os.path.exists(image_path):
            os.remove(image_path)
        cur.execute("DELETE FROM qlnv_imagedata WHERE ID_image=%s", (id_image, ))
    
    sql = "DELETE FROM qlnv_nhanvien WHERE MaNhanVien=%s"
    val = (maNV, )
    cur.execute(sql,val)
    mysql.connection.commit()
    cur.close()
    return redirect(url_for("table_data_employees"))
    
    
@login_required
@app.route("/form_add_data_money")
def form_add_data_money():
    return render_template('form_add_data_money.html')

@login_required
@app.route("/form_add_chuc_vu", methods=['GET','POST'])
def form_add_chuc_vu():
    cur = mysql.connection.cursor()
    cur.execute("""SELECT * FROM qlnv_chucvu""")
    chucvu = cur.fetchall()
    
    if request.method == 'POST':
        details = request.form
        MaCV = details['MaCV'].strip()
        TenCV = details["TenCV"].strip()
        for data in chucvu:
            if (MaCV in data):
                return render_template("form_add_chuc_vu.html", ma_err = "True", my_user = session['username'])
        
        cur.execute("INSERT INTO qlnv_chucvu(MaCV, TenCV) VALUES (%s, %s)",(MaCV, TenCV))
        mysql.connection.commit()
        cur.close()
        
        return redirect(url_for("table_chuc_vu"))
    return render_template("form_add_chuc_vu.html", my_user = session['username'])

@login_required
@app.route("/form_add_trinhdohocvan", methods=['GET','POST'])
def form_add_trinhdohocvan():
    cur = mysql.connection.cursor()
    cur.execute("""SELECT * FROM qlnv_trinhdohocvan""")
    trinhdohocvan = cur.fetchall()
    
    if request.method == 'POST':
        details = request.form
        MATDHV = details['MATDHV'].strip()
        TenTDHV = details["TenTDHV"].strip()
        ChuyenNganh = details['ChuyenNganh'].strip()
        for data in trinhdohocvan:
            if (MATDHV in data):
                return render_template("form_add_trinhdohocvan.html", ma_err = "True", my_user = session['username'])
        
        cur.execute("INSERT INTO qlnv_trinhdohocvan(MATDHV, TenTDHV, ChuyenNganh) VALUES (%s, %s, %s)",(MATDHV, TenTDHV, ChuyenNganh))
        mysql.connection.commit()
        cur.close()
        
        return redirect(url_for("table_data_employees"))
    return render_template("form_add_trinhdohocvan.html", my_user = session['username'])

@login_required
@app.route("/table_chuc_vu")
def table_chuc_vu():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT cv.MaCV, cv.TenCV, COUNT(*) 
        FROM qlnv_chucvu cv
        JOIN qlnv_nhanvien nv ON cv.MaCV = nv.MaChucVu
        GROUP BY cv.MaCV""")
    chucvu = cur.fetchall()
    cur.close()
    return render_template("table_chuc_vu.html", chucvu = chucvu, my_user = session['username'])

@login_required
@app.route("/table_chuc_vu/<string:maCV>")
def table_chuc_vu_nhan_vien(maCV):
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT TenCV
        FROM qlnv_chucvu 
        WHERE MaCV = %s """, (maCV, ))
    tenCV = cur.fetchall()
    
    cur.execute("""
        SELECT nv.MaNhanVien, nv.TenNV, nv.NgaySinh, nv.DienThoai, cv.TenCV, tg.NgayNhanChuc
        FROM qlnv_chucvu cv
        JOIN qlnv_thoigiancongtac tg ON tg.MaCV = cv.MaCV
        JOIN qlnv_nhanvien nv ON tg.MaNV = nv.MaNhanVien
        WHERE cv.MaCV = %s AND tg.DuongNhiem = 1 """, (maCV, ))
    nv_chuc_vu = cur.fetchall()
    
    cur.close()
    
    return render_template("table_chuc_vu_nhan_vien.html", tenCV = tenCV, nv_chuc_vu=nv_chuc_vu, my_user = session['username'])
    

@login_required
@app.route("/table_data_employees")
def table_data_employees():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT nv.MaNhanVien, nv.TenNV, img.PathToImage, nv.DiaChi, nv.NgaySinh, nv.GioiTinh, nv.DienThoai, cv.TenCV
        FROM qlnv_nhanvien nv
        JOIN qlnv_chucvu cv ON nv.MaChucVu = cv.MaCV
        JOIN qlnv_imagedata img ON nv.ID_profile_image = img.ID_image""")
    nhanvien = cur.fetchall()
    cur.close()
    return render_template('table_data_employees.html', nhanvien = nhanvien, my_user = session['username'])

@login_required
@app.route("/table_data_money")
def table_data_money():
    return render_template('table_data_money.html', my_user = session['username'])

@login_required
@app.route("/danh_sach_cham_cong")
def danh_sach_cham_cong():
    return render_template('danh_sach_cham_cong.html', my_user = session['username'])

@login_required
@app.route("/index")
def index():
    return render_template('index.html', my_user = session['username'])

@login_required
@app.route("/page_calendar")
def page_calendar():
    return render_template('page_calendar.html', my_user = session['username'])

@login_required
@app.route("/danh_sach_hop_dong")
def danh_sach_hop_dong():
    return render_template('danh_sach_hop_dong.html', my_user = session['username'])


def take_image_to_save(id_image, path_to_img):
    cur = mysql.connection.cursor()
    cur.execute("""SELECT * FROM qlnv_imagedata""")
    img_data = cur.fetchall()
    change_path = False
    
    path_to_img = "/".join(path_to_img.split("/")[1::])
    
    for data in img_data:
        if id_image in data:
            change_path = True
            if os.path.exists(data[1]):
                os.remove(data[1])
            break;
    
    if change_path:
        sql = """
            UPDATE qlnv_imagedata
            SET PathToImage = %s
            WHERE ID_image = %s"""
        val = (id_image, path_to_img)
        cur.execute(sql,val)
        mysql.connection.commit()
        return True
    
    sql = """
        INSERT INTO qlnv_imagedata (ID_image, PathToImage) 
        VALUES (%s, %s)"""
    val = (id_image, path_to_img)
    cur.execute(sql,val)
    mysql.connection.commit()
    return True;
    