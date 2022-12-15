import hashlib
from flask import Flask, render_template, request, redirect, url_for, session, json, jsonify, send_file
from flask_mysqldb import MySQL
from werkzeug.utils import secure_filename
import os
import MySQLdb.cursors
import pandas as pd
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
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM qlnv_congty")
    congty = cur.fetchall()[0]
    
    if 'congty' not in session.keys():
        session['congty'] = congty
    
    if request.method == 'POST':
        details = request.form
        user_name = details['username'].strip()
        password = hashlib.md5(details['current-password'].encode()).hexdigest()
        
        cur.execute("""SELECT us.*, img.PathToImage
                FROM qlnv_user us
                JOIN qlnv_nhanvien nv ON us.MaNhanVien = nv.MaNhanVien
                JOIN qlnv_imagedata img ON nv.ID_profile_image = img.ID_image
                WHERE username=%s""",(user_name,))
        user_data = cur.fetchall()
        
        if len(user_data)==0:
            return render_template('/general/login.html',
                                   congty = session['congty'],
                                   user_exits='False',
                                   pass_check='False')
        
        if password != user_data[0][2]:
            return render_template('/general/login.html', 
                                   congty = session['congty'],
                                   user_exits='True', 
                                   pass_check='False')
        
        my_user = user_data[0]
        session['username'] = my_user
        cur.close()
        return redirect(url_for("home"))
    return render_template('/general/login.html',
                           congty = session['congty'])


@app.route("/home")
def home():
    if 'username' in session.keys():
        return render_template('/index.html',
                               congty = session['congty'],
                               my_user = session['username'])
    return redirect(url_for("login"))

# Error Handler
# @app.errorhandler(404)
# def page_not_found(error):
#     return render_template('page_not_found.html'), 404



@app.route("/forgot")
def forgot():
    return render_template('/general/forgot.html', 
                           congty = session['congty'])

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
        
        cur.execute("""SELECT MaNhanVien FROM qlnv_nhanvien WHERE MaNhanVien=%s""", (MNV, ))
        kiem_tra_ma_nhan_vien = cur.fetchall()
        
        if len(kiem_tra_ma_nhan_vien) != 0:
            return render_template('form_add_data_employees.html',
                        ma_err="True",
                        trinhdohocvan = trinhdohocvan, 
                        chucvu = chucvu,
                        phongban = phongban,
                        congty = session['congty'],
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
        
        cur.execute("""INSERT INTO qlnv_thoigiancongtac(MaNV, MaCV, NgayNhanChuc, NgayKetThuc, DuongNhiem)
                    VALUES (%s, %s, CURRENT_DATE(), NULL, '1')
                    """, (MNV, CV))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for("table_data_employees"))
    return render_template('form_add_data_employees.html',
                           trinhdohocvan = trinhdohocvan, 
                           chucvu = chucvu,
                           phongban = phongban,
                           congty = session['congty'],
                           my_user = session['username'])
    
@login_required
@app.route("/form_view_update_employees/<string:maNV>_<string:canEdit>", methods=['GET','POST'])
def form_view_update_employees(maNV, canEdit):
    # https://www.youtube.com/watch?v=rFPzo1VnPXU
    
    mode = "disabled"
    if (canEdit == "Y"):
        mode = "";
    
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT nv.MaNhanVien, nv.TenNV, nv.GioiTinh, nv.NgaySinh, nv.DanToc,
        nv.SoCMT, nv.NgayCMND, nv.NoiCMND, nv.DienThoai, nv.Email, nv.DiaChi,
        nv.NoiSinh, nv.BHYT, NV.BHXH, img.PathToImage, pb.TenPB, cv.TenCV,
        nv.MaHD, nv.Luong, nv.TTHonNhan, concat(hv.MATDHV, " - ", hv.TenTDHV," - " , hv.ChuyenNganh),
        nv.MaChucVu, nv.MaPhongBan, nv.MATDHV, img.ID_image
        FROM qlnv_nhanvien nv
        LEFT JOIN qlnv_imagedata img ON nv.ID_profile_image = img.ID_image
        LEFT JOIN qlnv_phongban pb ON nv.MaPhongBan = pb.MaPB
        LEFT JOIN qlnv_chucvu cv ON nv.MaChucVu = cv.MaCV
        LEFT JOIN qlnv_trinhdohocvan hv ON nv.MATDHV = hv.MATDHV
        WHERE nv.MaNhanVien = %s
                """, (maNV, ))
    data_default = cur.fetchall()
    
    if (len(data_default) != 1): # Need page error
        return "Error"
    data_default = data_default[0]
    
    cur.execute("""SELECT * FROM qlnv_chucvu WHERE MaCV != %s""", (data_default[21], ))
    chucvu = cur.fetchall()
    
    if data_default[23] != None:
        cur.execute("""SELECT * FROM qlnv_trinhdohocvan WHERE MATDHV != %s""", (data_default[23], ))
        trinhdohocvan = cur.fetchall()
    else:
        cur.execute("""SELECT * FROM qlnv_trinhdohocvan""")
        trinhdohocvan = cur.fetchall()
    
    cur.execute("""SELECT * FROM qlnv_phongban WHERE MaPB != %s""", (data_default[22], ))
    phongban = cur.fetchall()
    
    if request.method == 'POST':
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
        DANTOC = details['DANTOC'].strip()
        CV = details['CV'].strip()
        PB = details['MAPB'].strip()
        ID_image = data_default[24]
                
        if (CV != data_default[16]):
            for data in chucvu:
                if (CV in data):
                    CV = data[0]
                    break;
        else:
            CV = data_default[21]
        
        if (PB != data_default[15]):
            for data in phongban:
                if (PB in data):
                    PB = data[0]
                    break;
        else:
            PB = data_default[22]
        
        image_profile = request.files['ImageProfileUpload']
        
        if image_profile.filename != "":
            ID_image = "Image_Profile_" + MNV 
            filename = ID_image + "." + secure_filename(image_profile.filename).split(".")[1]
            pathToImage = app.config['UPLOAD_FOLDER_IMG'] + "/" + filename
            print("Done")
            # image_profile.save(pathToImage)
            # take_image_to_save(ID_image, pathToImage)
        
        cur.execute("""UPDATE qlnv_nhanvien
            SET MaChucVu = %s, MaPhongBan = %s,
            Luong= %s, GioiTinh= %s, MaHD= %s, TenNV= %s,
            NgaySinh= %s, NoiSinh= %s, SoCMT= %s, DienThoai= %s,
            DiaChi= %s, Email= %s, TTHonNhan= %s, DanToc= %s,
            MATDHV= %s, NgayCMND= %s, NoiCMND= %s, BHYT= %s,
            BHXH= %s, ID_profile_image= %s
            WHERE MaNhanVien = %s""",
            (CV, PB, LUONG, GIOITINH, MAHD,
            TENNV, NGAYSINH, NOISINH, CMND, SDT, DIACHI,
            MAIL, HONHAN, DANTOC, MATDHV, NGAYCMND, NOICMND, BHYT, BHXH, ID_image, MNV))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for("table_data_employees"))
    return render_template('form_view_update_employees.html',
                           mode=mode,
                           data_default = data_default,
                           trinhdohocvan = trinhdohocvan, 
                           chucvu = chucvu,
                           phongban = phongban,
                           congty = session['congty'],
                           my_user = session['username'])
    

@login_required
@app.route("/form_add_data_employees_upload_file", methods=['GET','POST'])
def form_add_data_employees_upload_file():
    if request.method == 'POST':
        data_file = request.files['FileDataUpload']
        if data_file.filename != '':
            if data_file.filename.split(".")[-1] not in ['txt', 'xlsx', 'csv', 'xls', 'xlsm']:
                return redirect(url_for("form_add_data_employees_upload_file"))
            filename = "TMP_" + data_file.filename 
            pathToFile = app.config['UPLOAD_FOLDER'] + "/" + filename
            data_file.save(pathToFile)
            return redirect(url_for("form_add_data_employees_upload_process", filename=filename))
        return redirect(url_for("form_add_data_employees_upload_file"))
    return render_template('form_add_data_employees_upload_file.html',
                           congty = session['congty'],
                           my_user = session['username'])

@login_required
@app.route("/form_add_data_employees_upload_process/<string:filename>", methods=['GET','POST'])
def form_add_data_employees_upload_process(filename):
    pathToFile = app.config['UPLOAD_FOLDER'] + "/" + filename
    
    default_tag_Column = ['MaNhanVien', 'MaChucVu', 'MaPhongBan',
                    'Luong', 'GioiTinh', 'MaHD', 'TenNV',
                    'NgaySinh', 'NoiSinh', 'SoCMT', 'DienThoai',
                    'DiaChi', 'Email', 'TTHonNhan', 'DanToc',
                    'MATDHV', 'NgayCMND', 'NoiCMND', 'BHYT', 'BHXH']
    
    default_name_Column = ['Mã nhân viên', 'Chức vụ', 'Phòng Ban', 'Lương', 'Giới tính',
                           'Mã Hợp đồng', 'Tên Nhân Viên', 'Ngày Sinh',  'Nơi sinh', 'Chứng minh thư (thẻ căn cước)',
                           'Số điện thoại', 'Địa Chỉ', 'Email', 'Tình trạng hôn nhân', 'Dân tộc',
                           'Trình Độ Học Vấn', 'Ngày cấp CMND', 'Nơi cấp CMND', 'Bảo hiểm y tế', 'Bảo hiểm xã hội']
    
    data_nv = pd.read_excel(pathToFile)
    data_column = list(data_nv.columns)
    
    if request.method == 'POST':
        cur = mysql.connection.cursor()
        details = request.form
        column_link = [details[col] for col in data_column]
        column_match = [default_name_Column.index(elm) for elm in column_link]
        
        if (len(set(column_match)) != len(column_link)):
            return "Error"
        
        if 0 not in column_match or 1 not in column_match or 2 not in column_match:
            return "Error"
    
        # convert Ten CV to ChucVu
        tmp = tuple(set(data_nv[data_column[column_match.index(1)]]))
        if len(tmp) == 1:
            cur.execute("SELECT MaCV FROM qlnv_chucvu WHERE TenCV = %s", tmp)
        else:
            new_tmp = ["\"" + text +"\"" for text in tmp]
            cur.execute("SELECT MaCV FROM qlnv_chucvu WHERE TenCV IN (" + ", ".join(new_tmp) + ")")
        data_tuple = cur.fetchall()
        data_tmp_take = []
        for elm in data_tuple:
            data_tmp_take.append(elm[0])
        if (len(data_tmp_take) != len(tmp)):
            return "Error"
        data_nv[data_column[column_match.index(1)]] = data_nv[data_column[column_match.index(1)]].replace(list(tmp), data_tmp_take)

        # convert Ten PB to PhongBan
        tmp = tuple(set(data_nv[data_column[column_match.index(2)]]))
        if len(tmp) == 1:
            cur.execute("SELECT MaPB FROM qlnv_phongban WHERE TenPB = %s", tmp)
        else:
            new_tmp = ["\"" + text +"\"" for text in tmp]
            cur.execute("SELECT MaPB FROM qlnv_phongban WHERE TenPB IN (" + ", ".join(new_tmp) + ")")
        data_tuple = cur.fetchall()
        data_tmp_take = []
        for elm in data_tuple:
            data_tmp_take.append(elm[0])
        if (len(data_tmp_take) != len(tmp)):
            return "Error"
        data_nv[data_column[column_match.index(2)]] = data_nv[data_column[column_match.index(2)]].replace(list(tmp), data_tmp_take)
        
        # Chuyển đổi trình độ học vấn
        if 15 in column_match:
            tdhv_cn = set(data_nv[data_column[column_match.index(15)]]) # Trình dộ học vấn - chuyên ngành
            tmp = []
            sql_find_tdhv = "SELECT td.MATDHV FROM qlnv_trinhdohocvan td WHERE "
            for elm in tdhv_cn:
                sql_find_tdhv += " ( td.TenTDHV = %s AND td.ChuyenNganh = %s ) OR"
                new_tmp = [text.strip() for text in elm.split("-")]
                tmp += new_tmp
            sql_find_tdhv = sql_find_tdhv[:-2:]
            cur.execute(sql_find_tdhv, tuple(tmp))
            data_tdhv = cur.fetchall()
            data_tdhv_lst = []
            for elm in data_tdhv:
                data_tdhv_lst.append(elm[0])
            if (len(tdhv_cn) != len(data_tdhv_lst)):
                return "Error"
            data_nv[data_column[column_match.index(15)]] = data_nv[data_column[column_match.index(15)]].replace(list(tdhv_cn), data_tdhv)
        
        sql = "INSERT INTO `qlnv_nhanvien` ("
        for index in column_match:
            sql += default_tag_Column[index] + ","
        sql = sql[:-1:]
        sql += ") VALUES "
        for index_row in range(data_nv.shape[0]):
            sql += "("
            for col in data_column:
                sql +=  "\"" + str(data_nv[col][index_row]) + "\"" + ","
            sql = sql[:-1:]
            sql += "),"
        sql = sql[:-1:]    
        
        cur.execute(sql)
        mysql.connection.commit()
        cur.close()
        os.remove(pathToFile)
        return redirect(url_for('table_data_employees'))
    
    return render_template("form_add_data_employees_upload_process.html",
                           filename = filename,
                           congty = session['congty'],
                           my_user = session['username'],
                           name_column = default_name_Column,
                           index_column = data_column)
    
@login_required
@app.route("/get_data_employees_excel", methods=['GET','POST'])
def get_data_employees_excel():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT nv.MaNhanVien, nv.TenNV, cv.TenCV, pb.TenPB, CONCAT(td.TenTDHV,"-",td.ChuyenNganh) AS "TrinhDoHocVan", nv.Luong, nv.DiaChi, nv.NoiSinh,
        DATE_FORMAT(nv.NgaySinh,"%d-%m-%Y"), nv.GioiTinh, nv.DienThoai, nv.SoCMT, DATE_FORMAT(nv.NgayCMND,"%d-%m-%Y"), nv.NoiCMND,
        nv.Email, nv.TTHonNhan, nv.BHYT, nv.BHXH
        FROM qlnv_nhanvien nv
        JOIN qlnv_chucvu cv ON nv.MaChucVu = cv.MaCV
        JOIN qlnv_phongban pb ON nv.MaPhongBan = pb.MaPB
        JOIN qlnv_trinhdohocvan td ON nv.MATDHV = td.MATDHV
        """)
    nhanvien = cur.fetchall()
    cur.close()
    columnName = ['MaNhanVien', 'TenNV', 'TenCV', 'TenPB', 'TrinhDoHocVan', 'Luong', 'DiaChi', 'NoiSinh',
        'NgaySinh', 'GioiTinh', 'DienThoai', 'SoCMT', 'NgayCMND', 'NoiCMND',
        'Email', 'TTHonNhan', 'BHYT', 'BHXH']
    data = pd.DataFrame.from_records(nhanvien, columns=columnName)
    data = data.set_index('MaNhanVien')
    pathFile = app.config['UPLOAD_FOLDER'] + "/" + "Data_Nhan_Vien.xlsx"
    data.to_excel(pathFile)
    return send_file(pathFile, as_attachment=True)

@login_required
@app.route("/get_print_data_employees")
def get_print_data_employees():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT nv.MaNhanVien, nv.TenNV, img.PathToImage, nv.DiaChi,DATE_FORMAT(nv.NgaySinh,"%d-%m-%Y"), nv.GioiTinh, nv.DienThoai, cv.TenCV
        FROM qlnv_nhanvien nv
        JOIN qlnv_chucvu cv ON nv.MaChucVu = cv.MaCV
        JOIN qlnv_imagedata img ON nv.ID_profile_image = img.ID_image""")
    nhanvien = cur.fetchall()
    cur.close()
    return render_template("table_print_employees.html", nhanvien = nhanvien)

@login_required
@app.route("/delete_nhan_vien/<string:maNV>")
def delete_nhan_vien(maNV):
    cur = mysql.connection.cursor()
    cur.execute("SELECT ID_profile_image FROM qlnv_nhanvien WHERE MaNhanVien=%s", (maNV, ))
    id_image = cur.fetchall()[0][0]
    
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
                return render_template("form_add_chuc_vu.html", 
                                       congty = session['congty'],
                                       ma_err = "True",
                                       my_user = session['username'])
        
        cur.execute("INSERT INTO qlnv_chucvu(MaCV, TenCV) VALUES (%s, %s)",(MaCV, TenCV))
        mysql.connection.commit()
        cur.close()
        
        return redirect(url_for("table_chuc_vu"))
    return render_template("form_add_chuc_vu.html",
                           congty=session['congty'],
                           my_user = session['username'])

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
                return render_template("form_add_trinhdohocvan.html", 
                                       ma_err = "True", 
                                       congty = session['congty'],
                                       my_user = session['username'])
        
        cur.execute("INSERT INTO qlnv_trinhdohocvan(MATDHV, TenTDHV, ChuyenNganh) VALUES (%s, %s, %s)",(MATDHV, TenTDHV, ChuyenNganh))
        mysql.connection.commit()
        cur.close()
        
        return redirect(url_for("table_data_employees"))
    return render_template("form_add_trinhdohocvan.html", 
                           congty = session['congty'],
                           my_user = session['username'])

@login_required
@app.route("/table_chuc_vu")
def table_chuc_vu():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT cv.MaCV, cv.TenCV, COUNT(*) 
        FROM qlnv_chucvu cv
        JOIN qlnv_nhanvien nv ON cv.MaCV = nv.MaChucVu
        JOIN qlnv_thoigiancongtac tg ON tg.MaNV = nv.MaNhanVien 
        GROUP BY cv.MaCV""")
    chucvu = cur.fetchall()
    cur.close()
    return render_template("table_chuc_vu.html",
                           chucvu = chucvu,
                           congty = session['congty'],
                           my_user = session['username'])

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
        SELECT nv.MaNhanVien, nv.TenNV,DATE_FORMAT(nv.NgaySinh,"%d-%m-%Y"), nv.DienThoai, cv.TenCV, DATE_FORMAT(tg.NgayNhanChuc,"%d-%m-%Y")
        FROM qlnv_chucvu cv
        JOIN qlnv_thoigiancongtac tg ON tg.MaCV = cv.MaCV
        JOIN qlnv_nhanvien nv ON tg.MaNV = nv.MaNhanVien
        WHERE cv.MaCV = '""" + str(maCV) + """' AND tg.DuongNhiem = 1 """)
    nv_chuc_vu = cur.fetchall()
    
    cur.close()
    
    return render_template("table_chuc_vu_nhan_vien.html",
                           tenCV = tenCV,
                           nv_chuc_vu=nv_chuc_vu,
                           congty = session['congty'],
                           my_user = session['username'])
    

@login_required
@app.route("/table_data_employees")
def table_data_employees():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT nv.MaNhanVien, nv.TenNV, img.PathToImage, nv.DiaChi, DATE_FORMAT(nv.NgaySinh,"%d-%m-%Y"), nv.GioiTinh, nv.DienThoai, cv.TenCV
        FROM qlnv_nhanvien nv
        JOIN qlnv_chucvu cv ON nv.MaChucVu = cv.MaCV
        JOIN qlnv_imagedata img ON nv.ID_profile_image = img.ID_image""")
    nhanvien = cur.fetchall()
    cur.close()
    return render_template('table_data_employees.html',
                           nhanvien = nhanvien,
                           congty = session['congty'],
                           my_user = session['username'])

@login_required
@app.route("/table_data_money")
def table_data_money():
    return render_template('table_data_money.html',
                           congty = session['congty'],
                           my_user = session['username'])

@login_required
@app.route("/danh_sach_cham_cong")
def danh_sach_cham_cong():
    return render_template('danh_sach_cham_cong.html', 
                           congty = session['congty'],
                           my_user = session['username'])

@login_required
@app.route("/index")
def index():
    return render_template('index.html', 
                           congty = session['congty'],
                           my_user = session['username'])

@login_required
@app.route("/page_calendar")
def page_calendar():
    return render_template('page_calendar.html', 
                           congty = session['congty'],
                           my_user = session['username'])

@login_required
@app.route("/danh_sach_hop_dong")
def danh_sach_hop_dong():
    return render_template('danh_sach_hop_dong.html', 
                           congty = session['congty'],
                           my_user = session['username'])


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
    