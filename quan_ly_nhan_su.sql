-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2022 at 03:08 PM
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
-- Table structure for table `qlnv_luong`
--

CREATE TABLE `qlnv_luong` (
  `BacLuong` double NOT NULL,
  `LuongCoBan` double NOT NULL,
  `HeSoLuong` double NOT NULL,
  `HeSoPhuCap` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_nhanvien`
--

CREATE TABLE `qlnv_nhanvien` (
  `MaNhanVien` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `MaChucVu` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `MaPhongBan` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `BacLuong` double NOT NULL,
  `GioiTinh` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `MaHD` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `TenNV` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `NgaySinh` date NOT NULL,
  `SoCMT` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `DienThoai` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `DiaChi` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `TTHonNhan` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `DanToc` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MATDHV` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NgayCMND` date DEFAULT NULL,
  `NoiCMND` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `qlnv_nhanvien`
--

INSERT INTO `qlnv_nhanvien` (`MaNhanVien`, `MaChucVu`, `MaPhongBan`, `BacLuong`, `GioiTinh`, `MaHD`, `TenNV`, `NgaySinh`, `SoCMT`, `DienThoai`, `DiaChi`, `Email`, `TTHonNhan`, `DanToc`, `MATDHV`, `NgayCMND`, `NoiCMND`) VALUES
('MNV01', 'TTS', 'MPB01', 0.25, 'Nam', 'MHD01', 'Duong Van Nam', '2002-01-01', '123456789', '0877625245', 'Bac Giang', 'namdv@gmail.com', 'Độc thân', 'Kinh', 'SV001', NULL, NULL),
('MNV02', 'TTS', 'MPB01', 0.25, 'Nam', 'MHD02', 'La Duc Nam', '2002-03-01', '123456789', '0833625245', 'Ha Noi', 'namld@gmail.com', 'Độc thân', 'Kinh', 'SV001', NULL, NULL),
('MNV03', 'TTS', 'MPB01', 0.25, 'Nam', 'MHD03', 'Pham Hong Nghia', '2002-04-04', '123456789', '0822655245', 'Ha Noi', 'nghiaph@gmail.com', 'Đã kết hôn', 'Kinh', 'SV001', NULL, NULL),
('MNV04', 'GD', 'MPB01', 0, 'Nam', 'MHD04', 'Pham Nhat Vuong', '2002-07-07', '123456789', '0877865245', 'Ha Noi', 'vuongpn@gmail.com', 'Đã kết hôn', 'Kinh', 'TS001', NULL, NULL),
('MNV05', 'TTS', 'MPB02', 0.3, 'Nam', 'MHD05', 'Nguyen Khac Huy', '2002-10-01', '123456789', '0877265456', 'Ha Noi', 'huynk@gmail.com', 'Độc thân', 'Kinh', 'SV001', NULL, NULL),
('MNV06', 'NV', 'MPB03', 0.2, 'Nam', 'MHD06', 'Pham Nhu Khoa', '2002-05-05', '123456789', '0556276648', 'Ha Noi', 'khoapn@gmail.com', 'Độc thân', 'Kinh', 'SV001', NULL, NULL),
('MNV07', 'NV', 'MPB03', 0.15, 'Nữ', 'MHD07', 'Vu Mai Anh', '2002-08-05', '123456789', '0655745341', 'Ha Noi', 'anhvm@gmail.com', 'Độc thân', 'Kinh', 'SV002', NULL, NULL),
('MNV08', 'NV', 'MPB02', 0.1, 'Nữ', 'MHD07', 'Nguyen Cam Tien', '2002-09-09', '123456789', '0877567893', 'Ha Noi', 'tiennc@gmail.com', 'Độc thân', 'Kinh', 'SV002', NULL, NULL);

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
  `NgayNhanChuc` date NOT NULL,
  `NgayKetThuc` date DEFAULT NULL,
  `DuongNhiem` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_thoigiancongtac`
--

INSERT INTO `qlnv_thoigiancongtac` (`MaNV`, `MaCV`, `NgayNhanChuc`, `NgayKetThuc`, `DuongNhiem`) VALUES
('MNV01', 'TTS', '2022-10-01', NULL, 1),
('MNV02', 'TTS', '2022-11-02', NULL, 1),
('MNV03', 'TTS', '2022-11-02', NULL, 1),
('MNV04', 'GD', '2022-12-01', NULL, 1),
('MNV05', 'TTS', '2022-12-01', NULL, 1),
('MNV06', 'NV', '2022-10-04', NULL, 1),
('MNV07', 'NV', '2022-10-04', NULL, 1),
('MNV08', 'NV', '2022-10-10', NULL, 1);

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
('TNKHMTTT', 'Tốt Nghiệp', 'Khoa học máy tính và thông tin'),
('TS001', 'Thạc Sĩ', 'Khoa học dữ liệu'),
('SV002', 'Chưa tốt nghiệp', 'Hóa Dược');

-- --------------------------------------------------------

--
-- Table structure for table `qlnv_user`
--

CREATE TABLE `qlnv_user` (
  `Id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `tennguoidung` varchar(50) NOT NULL,
  `MaNhanVien` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qlnv_user`
--

INSERT INTO `qlnv_user` (`Id_user`, `username`, `password`, `tennguoidung`, `MaNhanVien`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'ADMIN001');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `qlnv_chamcong`
--
ALTER TABLE `qlnv_chamcong`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qlnv_chucvu`
--
ALTER TABLE `qlnv_chucvu`
  ADD PRIMARY KEY (`MaCV`);

--
-- Indexes for table `qlnv_luong`
--
ALTER TABLE `qlnv_luong`
  ADD PRIMARY KEY (`BacLuong`);

--
-- Indexes for table `qlnv_nhanvien`
--
ALTER TABLE `qlnv_nhanvien`
  ADD PRIMARY KEY (`MaNhanVien`);

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
  MODIFY `Id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
