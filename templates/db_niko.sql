-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 27, 2026 at 01:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_niko`
--

-- --------------------------------------------------------

--
-- Table structure for table `kamar_niko`
--

CREATE TABLE `kamar_niko` (
  `id_kamar_niko` int(11) NOT NULL,
  `no_kamar_niko` varchar(10) NOT NULL,
  `kelas_niko` varchar(20) NOT NULL,
  `status_kamar_niko` enum('tersedia','terisi') NOT NULL DEFAULT 'tersedia',
  `harga_niko` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kamar_niko`
--

INSERT INTO `kamar_niko` (`id_kamar_niko`, `no_kamar_niko`, `kelas_niko`, `status_kamar_niko`, `harga_niko`) VALUES
(1, 'A01', 'VIP', 'terisi', 1500000.00),
(2, 'A02', 'VIP', 'tersedia', 1500000.00),
(3, 'B01', 'Kelas 1', 'tersedia', 750000.00),
(4, 'B02', 'Kelas 1', 'tersedia', 750000.00),
(5, 'C01', 'Kelas 2', 'tersedia', 400000.00);

-- --------------------------------------------------------

--
-- Table structure for table `pasien_niko`
--

CREATE TABLE `pasien_niko` (
  `id_pasien_niko` int(11) NOT NULL,
  `nama_niko` varchar(100) NOT NULL,
  `alamat_niko` text DEFAULT NULL,
  `kontak_niko` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien_niko`
--

INSERT INTO `pasien_niko` (`id_pasien_niko`, `nama_niko`, `alamat_niko`, `kontak_niko`) VALUES
(1, 'Ahmad Fauzi', 'Jl. Merdeka No. 12 Bandung', '081234567111'),
(2, 'Siti Aisyah', 'Jl. Anggrek No. 7 Cimahi', '081234567222'),
(3, 'Budi Santoso', 'Jl. Sudirman No. 20 Jakarta', '081234567333');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_niko`
--

CREATE TABLE `transaksi_niko` (
  `id_transaksi_niko` int(11) NOT NULL,
  `id_pasien_niko` int(11) NOT NULL,
  `id_kamar_niko` int(11) NOT NULL,
  `total_biaya_niko` decimal(12,2) NOT NULL,
  `status_pembayaran_niko` enum('belum_lunas','lunas') NOT NULL DEFAULT 'belum_lunas',
  `tgl_niko` date NOT NULL,
  `tgl_keluar_niko` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi_niko`
--

INSERT INTO `transaksi_niko` (`id_transaksi_niko`, `id_pasien_niko`, `id_kamar_niko`, `total_biaya_niko`, `status_pembayaran_niko`, `tgl_niko`, `tgl_keluar_niko`) VALUES
(1, 1, 1, 7500000.00, 'lunas', '2026-01-10', '2026-01-15'),
(2, 2, 3, 1500000.00, 'belum_lunas', '2026-01-12', NULL),
(3, 3, 2, 3000000.00, 'belum_lunas', '2026-01-14', '2026-01-18');

-- --------------------------------------------------------

--
-- Table structure for table `user_niko`
--

CREATE TABLE `user_niko` (
  `id_user_niko` int(11) NOT NULL,
  `username_niko` varchar(50) NOT NULL,
  `password_niko` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_niko`
--

INSERT INTO `user_niko` (`id_user_niko`, `username_niko`, `password_niko`) VALUES
(1, 'admin', 'admin123'),
(2, 'petugas', 'petugas123'),
(3, 'niko', 'niko2026');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kamar_niko`
--
ALTER TABLE `kamar_niko`
  ADD PRIMARY KEY (`id_kamar_niko`),
  ADD UNIQUE KEY `no_kamar_niko` (`no_kamar_niko`);

--
-- Indexes for table `pasien_niko`
--
ALTER TABLE `pasien_niko`
  ADD PRIMARY KEY (`id_pasien_niko`);

--
-- Indexes for table `transaksi_niko`
--
ALTER TABLE `transaksi_niko`
  ADD PRIMARY KEY (`id_transaksi_niko`),
  ADD KEY `fk_transaksi_pasien` (`id_pasien_niko`),
  ADD KEY `fk_transaksi_kamar` (`id_kamar_niko`);

--
-- Indexes for table `user_niko`
--
ALTER TABLE `user_niko`
  ADD PRIMARY KEY (`id_user_niko`),
  ADD UNIQUE KEY `username_niko` (`username_niko`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kamar_niko`
--
ALTER TABLE `kamar_niko`
  MODIFY `id_kamar_niko` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pasien_niko`
--
ALTER TABLE `pasien_niko`
  MODIFY `id_pasien_niko` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transaksi_niko`
--
ALTER TABLE `transaksi_niko`
  MODIFY `id_transaksi_niko` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_niko`
--
ALTER TABLE `user_niko`
  MODIFY `id_user_niko` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaksi_niko`
--
ALTER TABLE `transaksi_niko`
  ADD CONSTRAINT `fk_transaksi_kamar` FOREIGN KEY (`id_kamar_niko`) REFERENCES `kamar_niko` (`id_kamar_niko`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaksi_pasien` FOREIGN KEY (`id_pasien_niko`) REFERENCES `pasien_niko` (`id_pasien_niko`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
