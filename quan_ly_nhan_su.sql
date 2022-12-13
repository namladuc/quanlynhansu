-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 13, 2022 at 04:32 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quan_ly_nhan_su`
--

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chamcong`
--

CREATE TABLE `qlnv_chamcong` (
  `id` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Ngay` date NOT NULL,
  `GioVao` time NOT NULL,
  `GioRa` time NOT NULL,
  `ThoiGianLamViec` double NOT NULL,
  `ThoiGianTangCa` double NOT NULL,
  `OT` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chamcongngay`
--

CREATE TABLE `qlnv_chamcongngay` (
  `MaChamCong` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Thang` int(11) NOT NULL,
  `SoNgayThang` int(11) NOT NULL,
  `Ngay1` varchar(15) NOT NULL,
  `Ngay2` varchar(15) NOT NULL,
  `Ngay3` varchar(15) NOT NULL,
  `Ngay4` varchar(15) NOT NULL,
  `Ngay5` varchar(15) NOT NULL,
  `Ngay6` varchar(15) NOT NULL,
  `Ngay7` varchar(15) NOT NULL,
  `Ngay8` varchar(15) NOT NULL,
  `Ngay9` varchar(15) NOT NULL,
  `Ngay10` varchar(15) NOT NULL,
  `Ngay11` varchar(15) NOT NULL,
  `Ngay12` varchar(15) NOT NULL,
  `Ngay13` varchar(15) NOT NULL,
  `Ngay14` varchar(15) NOT NULL,
  `Ngay15` varchar(15) NOT NULL,
  `Ngay16` varchar(15) NOT NULL,
  `Ngay17` varchar(15) NOT NULL,
  `Ngay18` varchar(15) NOT NULL,
  `Ngay19` varchar(15) NOT NULL,
  `Ngay20` varchar(15) NOT NULL,
  `Ngay21` varchar(15) NOT NULL,
  `Ngay22` varchar(15) NOT NULL,
  `Ngay23` varchar(15) NOT NULL,
  `Ngay24` varchar(15) NOT NULL,
  `Ngay25` varchar(15) NOT NULL,
  `Ngay26` varchar(15) NOT NULL,
  `Ngay27` varchar(15) NOT NULL,
  `Ngay28` varchar(15) NOT NULL,
  `Ngay29` varchar(15) NOT NULL,
  `Ngay30` varchar(15) NOT NULL,
  `Ngay31` varchar(15) NOT NULL,
  `SoNgayDiLam` int(11) NOT NULL,
  `SoNgayDiVang` int(11) NOT NULL,
  `SoNgayTangCa` int(11) NOT NULL,
  `TongSoNgay` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chucvu`
--

CREATE TABLE `qlnv_chucvu` (
  `MaCV` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `TenCV` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `qlnv_chucvu`
--

INSERT INTO `qlnv_chucvu` (`MaCV`, `TenCV`) VALUES
('GD', 'Giám đốc'),
('NV', 'Nhân viên'),
('TTS', 'Thực tập sinh');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_congty`
--

CREATE TABLE `qlnv_congty` (
  `TenCongTy` varchar(100) NOT NULL,
  `DiaChi` varchar(100) NOT NULL,
  `LogoPath` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_congty`
--

INSERT INTO `qlnv_congty` (`TenCongTy`, `DiaChi`, `LogoPath`) VALUES
('Công ty Mòe', '334 Đ. Nguyễn Trãi, Thanh Xuân Trung, Thanh Xuân, Hà Nội', 'web/img/favicon.png');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_imagedata`
--

CREATE TABLE `qlnv_imagedata` (
  `ID_image` varchar(40) NOT NULL,
  `PathToImage` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_imagedata`
--

INSERT INTO `qlnv_imagedata` (`ID_image`, `PathToImage`) VALUES
('Image_Profile_MNV02', 'web/img/Image_Profile_MNV02.gif'),
('logo_web', 'web/img/favicon.png'),
('none_image_profile', 'web/img/No_Image.png');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_nhanvien`
--

CREATE TABLE `qlnv_nhanvien` (
  `MaNhanVien` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `MaChucVu` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `MaPhongBan` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `Luong` double NOT NULL,
  `GioiTinh` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Nam',
  `MaHD` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `TenNV` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `NgaySinh` date NOT NULL,
  `NoiSinh` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `SoCMT` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `DienThoai` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `DiaChi` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `TTHonNhan` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Độc thân',
  `DanToc` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'Kinh',
  `MATDHV` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NgayCMND` date DEFAULT NULL,
  `NoiCMND` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BHYT` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `BHXH` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `ID_profile_image` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'none_image_profile'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `qlnv_nhanvien`
--

INSERT INTO `qlnv_nhanvien` (`MaNhanVien`, `MaChucVu`, `MaPhongBan`, `Luong`, `GioiTinh`, `MaHD`, `TenNV`, `NgaySinh`, `NoiSinh`, `SoCMT`, `DienThoai`, `DiaChi`, `Email`, `TTHonNhan`, `DanToc`, `MATDHV`, `NgayCMND`, `NoiCMND`, `BHYT`, `BHXH`, `ID_profile_image`) VALUES
('MNN01', 'NV', 'MPB05', 1300000, 'Nam', 'MHDMN11', 'Nguyễn Quang Minh', '2002-12-12', 'Thanh Vân - Hiệp Hòa - Bắc Giang', '001205068139', '0965513786', 'Làng sinh viên Hacinco - Nhân Chính - Thanh Xuân - Hà Nội - Việt Nam', 'nguyenquangminh@gmail.com', 'Độc thân', 'Kinh', 'SV002', '2019-03-10', 'Hiệp Hòa', 'SV40101206185', '0118059003', 'none_image_profile'),
('MNV01', 'TTS', 'MPB01', 1000000, 'Nam', 'MHD01', 'Dương Văn Nam', '2002-01-07', 'Hiệp Hòa - Bắc Giang', '001215387168', '0877625245', 'Hiệp Hòa - Bắc Giang', 'namdv@gmail.com', 'Độc thân', 'Kinh', 'SV001', '2019-11-30', 'Hiệp Hòa - Bắc Giang', 'SV40101238294', '0118128311', 'none_image_profile'),
('MNV02', 'TTS', 'MPB02', 1000000, 'Nam', 'MHD02', 'Lã Đức Nam', '2002-11-28', 'Hà Tây', '001202035197', '0945549876', 'Làng sinh viên Hacinco - Nhân Chính - Thanh Xuân - Hà Nội - Việt Nam', 'namld@gmail.com', 'Độc thân', 'Kinh', 'SV001', '2020-08-03', 'Hà Nội', 'SV401985718', '0118157171', 'Image_Profile_MNV02'),
('MNV03', 'TTS', 'MPB01', 0.25, 'Nam', 'MHD03', 'Pham Hong Nghia', '2002-04-04', '', '123456789', '0822655245', 'Ha Noi', 'nghiaph@gmail.com', 'Đã kết hôn', 'Kinh', 'SV001', NULL, NULL, '', '', 'none_image_profile'),
('MNV04', 'GD', 'MPB01', 0, 'Nam', 'MHD04', 'Pham Nhat Vuong', '2002-07-07', '', '123456789', '0877865245', 'Ha Noi', 'vuongpn@gmail.com', 'Đã kết hôn', 'Kinh', 'TS001', NULL, NULL, '', '', 'none_image_profile'),
('MNV05', 'TTS', 'MPB02', 0.3, 'Nam', 'MHD05', 'Nguyen Khac Huy', '2002-10-01', '', '123456789', '0877265456', 'Ha Noi', 'huynk@gmail.com', 'Độc thân', 'Kinh', 'SV001', NULL, NULL, '', '', 'none_image_profile'),
('MNV06', 'NV', 'MPB03', 0.2, 'Nam', 'MHD06', 'Pham Nhu Khoa', '2002-05-05', '', '123456789', '0556276648', 'Ha Noi', 'khoapn@gmail.com', 'Độc thân', 'Kinh', 'SV001', NULL, NULL, '', '', 'none_image_profile'),
('MNV07', 'NV', 'MPB03', 0.15, 'Nữ', 'MHD07', 'Vu Mai Anh', '2002-08-05', '', '123456789', '0655745341', 'Ha Noi', 'anhvm@gmail.com', 'Độc thân', 'Kinh', 'SV002', NULL, NULL, '', '', 'none_image_profile'),
('MNV08', 'NV', 'MPB02', 700000, 'Nữ', 'MHD07', 'Nguyễn Thị Cẩm Tiên', '2002-09-09', '', '123456789', '0877567893', 'Hà Nội', 'tiennc@gmail.com', 'Độc thân', 'Kinh', 'SV002', '2019-05-03', 'Bắc Giang', '', '', 'none_image_profile'),
('MNV10', 'NV', 'MPB01', 20000000, 'Nam', 'HDMNV10', 'Lê Tài Linh', '2002-12-12', 'Thôn Xuân Tân - Xuân Hưng - Thọ Xuân - Thanh Hoá  - Việt Nam', '001206064297', '0916578134', 'Làng sinh viên Hacinco - Nhân Chính - Thanh Xuân - Hà Nội - Việt Nam', 'linhle@gmail.com', 'Độc thân', 'Kinh', 'SV002', '2020-03-18', 'Thọ Xuân', 'SV40101208765', '0118000001', 'none_image_profile'),
('MNV12', 'TTS', 'MPB02', 1000000, 'Nam', 'HDMNV12', 'Trần Hoàng Anh', '2002-02-14', 'Đồng Họa - Xã Vạn Hòa - Huyện Nông Cống - Thanh Hóa', '001234957163', '0945875315', 'Làng sinh viên Hacinco - Nhân Chính - Thanh Xuân - Hà Nội - Việt Nam', 'tranhaicau@gmail.com', 'Độc thân', 'Kinh', 'SV001', '2019-04-05', 'Thanh Hóa', 'SV401975831', '0118648251', 'none_image_profile');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_phanquyenuser`
--

CREATE TABLE `qlnv_phanquyenuser` (
  `id_user` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_phongban`
--

CREATE TABLE `qlnv_phongban` (
  `MaPB` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `TenPB` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `diachi` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sodt` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `qlnv_phongban`
--

INSERT INTO `qlnv_phongban` (`MaPB`, `TenPB`, `diachi`, `sodt`) VALUES
('MPB01', 'Marketing', 'Hà Nội', '096358469'),
('MPB02', 'Công nghệ thông tin', 'HCM', '096358465'),
('MPB03', 'Kế toán', 'Hà Nội', '096358461'),
('MPB04', 'Kiểm toán', 'Hà Nội', '096358467'),
('MPB05', 'Hành chính', 'Hà Nội', '096358468');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_suckhoenv`
--

CREATE TABLE `qlnv_suckhoenv` (
  `MaNV` varchar(8) NOT NULL,
  `TrangThai` varchar(30) NOT NULL,
  `ChuThich` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_thoigiancongtac`
--

CREATE TABLE `qlnv_thoigiancongtac` (
  `MaNV` varchar(8) NOT NULL,
  `MaCV` varchar(8) NOT NULL,
  `NgayNhanChuc` date NOT NULL DEFAULT current_timestamp(),
  `NgayKetThuc` date DEFAULT NULL,
  `DuongNhiem` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_thoigiancongtac`
--

INSERT INTO `qlnv_thoigiancongtac` (`MaNV`, `MaCV`, `NgayNhanChuc`, `NgayKetThuc`, `DuongNhiem`) VALUES
('MNN01', 'NV', '2022-12-13', NULL, 1),
('MNV01', 'TTS', '2022-10-01', NULL, 1),
('MNV02', 'TTS', '2022-11-02', NULL, 1),
('MNV03', 'TTS', '2022-11-02', NULL, 1),
('MNV04', 'GD', '2022-12-01', NULL, 1),
('MNV05', 'TTS', '2022-12-01', NULL, 1),
('MNV06', 'NV', '2022-10-04', NULL, 1),
('MNV07', 'NV', '2022-10-04', NULL, 1),
('MNV08', 'NV', '2022-10-10', NULL, 1),
('MNV10', 'NV', '2022-12-13', NULL, 1),
('MNV12', 'TTS', '2022-12-13', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_thuongphat`
--

CREATE TABLE `qlnv_thuongphat` (
  `id` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Loai` varchar(7) NOT NULL,
  `LyDo` varchar(100) NOT NULL,
  `Tien` double NOT NULL,
  `Ngay` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_trinhdohocvan`
--

CREATE TABLE `qlnv_trinhdohocvan` (
  `MATDHV` varchar(8) NOT NULL,
  `TenTDHV` varchar(50) NOT NULL,
  `ChuyenNganh` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_trinhdohocvan`
--

INSERT INTO `qlnv_trinhdohocvan` (`MATDHV`, `TenTDHV`, `ChuyenNganh`) VALUES
('SV001', 'Chưa tốt nghiệp', 'Khoa học dữ liệu'),
('SV002', 'Chưa tốt nghiệp', 'Hóa Dược'),
('TNKHMTTT', 'Tốt Nghiệp', 'Khoa học máy tính và thông tin'),
('TS001', 'Thạc Sĩ', 'Khoa học dữ liệu');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_user`
--

CREATE TABLE `qlnv_user` (
  `Id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `tennguoidung` varchar(50) NOT NULL,
  `MaNhanVien` varchar(8) NOT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `register` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_user`
--

INSERT INTO `qlnv_user` (`Id_user`, `username`, `password`, `tennguoidung`, `MaNhanVien`, `LastLogin`, `register`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'MNV02', '2022-12-01 14:57:12', '2022-12-01 14:57:45'),
(2, 'namsiunhon', '827ccb0eea8a706c4c34a16891f84e7b', 'Lã Đức Nam', 'MNV02', '2022-12-01 00:00:00', '2022-12-01 14:57:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `qlnv_chamcong`
--
ALTER TABLE `qlnv_chamcong`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_chamcongngay`
--
ALTER TABLE `qlnv_chamcongngay`
  ADD PRIMARY KEY (`MaChamCong`);

--
-- Indexes for table `qlnv_chucvu`
--
ALTER TABLE `qlnv_chucvu`
  ADD PRIMARY KEY (`MaCV`);

--
-- Indexes for table `qlnv_imagedata`
--
ALTER TABLE `qlnv_imagedata`
  ADD PRIMARY KEY (`ID_image`);

--
-- Indexes for table `qlnv_nhanvien`
--
ALTER TABLE `qlnv_nhanvien`
  ADD PRIMARY KEY (`MaNhanVien`);

--
-- Indexes for table `qlnv_phanquyenuser`
--
ALTER TABLE `qlnv_phanquyenuser`
  ADD PRIMARY KEY (`id_user`,`role_id`);

--
-- Indexes for table `qlnv_phongban`
--
ALTER TABLE `qlnv_phongban`
  ADD PRIMARY KEY (`MaPB`);

--
-- Indexes for table `qlnv_thoigiancongtac`
--
ALTER TABLE `qlnv_thoigiancongtac`
  ADD PRIMARY KEY (`MaNV`,`MaCV`);

--
-- Indexes for table `qlnv_thuongphat`
--
ALTER TABLE `qlnv_thuongphat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_trinhdohocvan`
--
ALTER TABLE `qlnv_trinhdohocvan`
  ADD PRIMARY KEY (`MATDHV`);

--
-- Indexes for table `qlnv_user`
--
ALTER TABLE `qlnv_user`
  ADD PRIMARY KEY (`Id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `qlnv_chamcong`
--
ALTER TABLE `qlnv_chamcong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qlnv_thuongphat`
--
ALTER TABLE `qlnv_thuongphat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qlnv_user`
--
ALTER TABLE `qlnv_user`
  MODIFY `Id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
