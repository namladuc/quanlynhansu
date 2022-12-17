-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2022 at 05:22 PM
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
  `OT` tinyint(1) NOT NULL,
  `ThoiGianLamViec` time NOT NULL,
  `ThoiGian_thap_phan` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_chamcong`
--

INSERT INTO `qlnv_chamcong` (`id`, `MaNV`, `Ngay`, `GioVao`, `GioRa`, `OT`, `ThoiGianLamViec`, `ThoiGian_thap_phan`) VALUES
(17, 'MNV01', '2022-12-17', '13:00:00', '17:00:00', 0, '04:00:00', 4),
(25, 'MNV01', '2022-12-17', '07:30:00', '11:30:00', 0, '04:00:00', 4),
(26, 'MNV02', '2022-11-28', '07:30:00', '11:30:00', 0, '04:00:00', 4),
(27, 'MNV02', '2022-11-01', '07:30:00', '11:30:00', 0, '04:00:00', 4),
(28, 'MNV02', '2022-11-02', '07:30:00', '11:30:00', 0, '04:00:00', 4),
(29, 'MNV03', '2022-10-01', '07:30:00', '11:30:00', 0, '04:00:00', 4),
(30, 'MNV03', '2022-10-02', '13:00:00', '17:00:00', 0, '04:00:00', 4),
(31, 'MNV03', '2022-10-03', '13:00:00', '17:00:00', 0, '04:00:00', 4),
(32, 'MNV03', '2022-10-04', '13:00:00', '17:00:00', 0, '04:00:00', 4),
(33, 'MNV03', '2022-10-05', '13:00:00', '17:00:00', 0, '04:00:00', 4),
(34, 'MNV03', '2022-10-06', '13:00:00', '17:00:00', 0, '04:00:00', 4),
(35, 'MNV03', '2022-10-10', '13:00:00', '17:00:00', 0, '04:00:00', 4),
(43, 'MNV04', '2022-11-01', '07:30:00', '11:30:00', 0, '04:00:00', 4);

--
-- Triggers `qlnv_chamcong`
--
DELIMITER $$
CREATE TRIGGER `before_insert_to_cham_cong` BEFORE INSERT ON `qlnv_chamcong` FOR EACH ROW BEGIN
       		IF (NEW.GioRa > NEW.GioVao) THEN
           		SET NEW.ThoiGianLamViec = TIMEDIFF(NEW.GioRa,NEW.GioVao);
                SET NEW.ThoiGian_thap_phan =   ROUND(CAST(LEFT(NEW.ThoiGianLamViec, 2) AS int) +
    CAST(SUBSTRING(NEW.ThoiGianLamViec, 4, 2) AS int) / 60.0 +
    CAST(SUBSTRING(NEW.ThoiGianLamViec, 7, 2) AS int) / (60.0*60.0),1);
            ELSE
            	SET NEW.ThoiGianLamViec = 0;
                SET NEW.ThoiGian_thap_phan = 0;
            END IF;
       END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_to_cham_cong` BEFORE UPDATE ON `qlnv_chamcong` FOR EACH ROW BEGIN
       		IF (NEW.GioRa > NEW.GioVao) THEN
           		SET NEW.ThoiGianLamViec = TIMEDIFF(NEW.GioRa,NEW.GioVao);
                SET NEW.ThoiGian_thap_phan =   ROUND(CAST(LEFT(NEW.ThoiGianLamViec, 2) AS int) +
    CAST(SUBSTRING(NEW.ThoiGianLamViec, 4, 2) AS int) / 60.0 +
    CAST(SUBSTRING(NEW.ThoiGianLamViec, 7, 2) AS int) / (60.0*60.0),1);
            ELSE
            	SET NEW.ThoiGianLamViec = 0;
                SET NEW.ThoiGian_thap_phan = 0;
            END IF;
       END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chamcongngay`
--

CREATE TABLE `qlnv_chamcongngay` (
  `MaChamCong` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Nam` year(4) NOT NULL DEFAULT current_timestamp(),
  `Thang` int(11) NOT NULL,
  `SoNgayThang` int(11) NOT NULL,
  `Ngay1` float NOT NULL DEFAULT -1,
  `Ngay2` float NOT NULL DEFAULT -1,
  `Ngay3` float NOT NULL DEFAULT -1,
  `Ngay4` float NOT NULL DEFAULT -1,
  `Ngay5` float NOT NULL DEFAULT -1,
  `Ngay6` float NOT NULL DEFAULT -1,
  `Ngay7` float NOT NULL DEFAULT -1,
  `Ngay8` float NOT NULL DEFAULT -1,
  `Ngay9` float NOT NULL DEFAULT -1,
  `Ngay10` float NOT NULL DEFAULT -1,
  `Ngay11` float NOT NULL DEFAULT -1,
  `Ngay12` float NOT NULL DEFAULT -1,
  `Ngay13` float NOT NULL DEFAULT -1,
  `Ngay14` float NOT NULL DEFAULT -1,
  `Ngay15` float NOT NULL DEFAULT -1,
  `Ngay16` float NOT NULL DEFAULT -1,
  `Ngay17` float NOT NULL DEFAULT -1,
  `Ngay18` float NOT NULL DEFAULT -1,
  `Ngay19` float NOT NULL DEFAULT -1,
  `Ngay20` float NOT NULL DEFAULT -1,
  `Ngay21` float NOT NULL DEFAULT -1,
  `Ngay22` float NOT NULL DEFAULT -1,
  `Ngay23` float NOT NULL DEFAULT -1,
  `Ngay24` float NOT NULL DEFAULT -1,
  `Ngay25` float NOT NULL DEFAULT -1,
  `Ngay26` float NOT NULL DEFAULT -1,
  `Ngay27` float NOT NULL DEFAULT -1,
  `Ngay28` float NOT NULL DEFAULT -1,
  `Ngay29` float NOT NULL DEFAULT -1,
  `Ngay30` float NOT NULL DEFAULT -1,
  `Ngay31` float NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_chamcongngay`
--

INSERT INTO `qlnv_chamcongngay` (`MaChamCong`, `MaNV`, `Nam`, `Thang`, `SoNgayThang`, `Ngay1`, `Ngay2`, `Ngay3`, `Ngay4`, `Ngay5`, `Ngay6`, `Ngay7`, `Ngay8`, `Ngay9`, `Ngay10`, `Ngay11`, `Ngay12`, `Ngay13`, `Ngay14`, `Ngay15`, `Ngay16`, `Ngay17`, `Ngay18`, `Ngay19`, `Ngay20`, `Ngay21`, `Ngay22`, `Ngay23`, `Ngay24`, `Ngay25`, `Ngay26`, `Ngay27`, `Ngay28`, `Ngay29`, `Ngay30`, `Ngay31`) VALUES
(25, 'MNV01', 2022, 12, 31, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 8, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
(27, 'MNV02', 2022, 11, 30, 4, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 4, -1, -1, -1),
(28, 'MNV03', 2022, 10, 31, 4, 4, 4, 4, 4, 4, -1, -1, -1, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
(31, 'MNV04', 2022, 11, 30, 4, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chamcongthang`
--

CREATE TABLE `qlnv_chamcongthang` (
  `id` int(11) NOT NULL,
  `MaNV` varchar(8) NOT NULL,
  `Nam` year(4) NOT NULL DEFAULT current_timestamp(),
  `T1` float NOT NULL DEFAULT -1,
  `T2` float NOT NULL DEFAULT -1,
  `T3` float NOT NULL DEFAULT -1,
  `T4` float NOT NULL DEFAULT -1,
  `T5` float NOT NULL DEFAULT -1,
  `T6` float NOT NULL DEFAULT -1,
  `T7` float NOT NULL DEFAULT -1,
  `T8` float NOT NULL DEFAULT -1,
  `T9` float NOT NULL DEFAULT -1,
  `T10` float NOT NULL DEFAULT -1,
  `T11` float NOT NULL DEFAULT -1,
  `T12` float NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_chamcongthang`
--

INSERT INTO `qlnv_chamcongthang` (`id`, `MaNV`, `Nam`, `T1`, `T2`, `T3`, `T4`, `T5`, `T6`, `T7`, `T8`, `T9`, `T10`, `T11`, `T12`) VALUES
(5, 'MNV01', 2022, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 8),
(7, 'MNV02', 2022, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 12, -1),
(8, 'MNV03', 2022, -1, -1, -1, -1, -1, -1, -1, -1, -1, 28, -1, -1),
(11, 'MNV04', 2022, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 4, -1);

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_chamcongtongketthang`
--

CREATE TABLE `qlnv_chamcongtongketthang` (
  `Id` int(11) NOT NULL,
  `MaNhanVien` varchar(8) NOT NULL,
  `Nam` year(4) NOT NULL,
  `Thang` int(11) NOT NULL,
  `SoNgayDiLam` int(11) NOT NULL DEFAULT 0,
  `SoNgayDiVang` int(11) NOT NULL DEFAULT 0,
  `SoNgayTangCa` int(11) NOT NULL DEFAULT 0,
  `TongSoNgay` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_chamcongtongketthang`
--

INSERT INTO `qlnv_chamcongtongketthang` (`Id`, `MaNhanVien`, `Nam`, `Thang`, `SoNgayDiLam`, `SoNgayDiVang`, `SoNgayTangCa`, `TongSoNgay`) VALUES
(2, 'MNV01', 2022, 12, 1, 26, 0, 1),
(5, 'MNV02', 2022, 11, 3, 23, 0, 3),
(6, 'MNV03', 2022, 10, 7, 19, 0, 7),
(9, 'MNV04', 2022, 11, 1, 25, 0, 1);

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
('MNV12', 'TTS', 'MPB02', 1000000, 'Nam', 'HDMNV12', 'Trần Hoàng Anh', '2002-02-14', 'Đồng Họa - Xã Vạn Hòa - Huyện Nông Cống - Thanh Hóa', '001234957163', '0945875315', 'Làng sinh viên Hacinco - Nhân Chính - Thanh Xuân - Hà Nội - Việt Nam', 'tranhaicau@gmail.com', 'Độc thân', 'Kinh', 'SV001', '2019-04-05', 'Thanh Hóa', 'SV401975831', '0118648251', 'none_image_profile'),
('MNV24', 'NV', 'MPB01', 950000, 'Nam', 'HDMNV24', 'Phan Quốc Minh', '2002-07-07', 'Khánh Hòa', '1234965137', '856865245', 'Ha Noi', 'minhpq@gmail.com', 'Đã kết hôn', 'Kinh', 'SV003', '2020-07-07', 'Khánh Hòa', 'SV401658965', '118046701', 'none_image_profile'),
('MNV36', 'NV', 'MPB01', 900000, 'Nam', '', 'Nguyễn Quang Minh', '2002-11-30', 'Thái Bình', '1262596315', '558466648', 'Ha Noi', 'nqm@gmail.com', 'Độc thân', 'Kinh', NULL, '2020-07-07', 'Thái Bình', 'SV401658583', '118124001', 'none_image_profile');

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
('SV003', 'Chưa tốt nghiệp', 'Vật Lý'),
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
-- Indexes for table `qlnv_chamcongthang`
--
ALTER TABLE `qlnv_chamcongthang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_chamcongtongketthang`
--
ALTER TABLE `qlnv_chamcongtongketthang`
  ADD PRIMARY KEY (`Id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `qlnv_chamcongngay`
--
ALTER TABLE `qlnv_chamcongngay`
  MODIFY `MaChamCong` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `qlnv_chamcongthang`
--
ALTER TABLE `qlnv_chamcongthang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `qlnv_chamcongtongketthang`
--
ALTER TABLE `qlnv_chamcongtongketthang`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
