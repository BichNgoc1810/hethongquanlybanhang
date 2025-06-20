USE [master]
GO
/****** Object:  Database [Quan_ly_ban_hang]    Script Date: 4/22/2023 8:56:03 AM ******/
CREATE DATABASE [Quan_ly_ban_hang]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Quan_ly_ban_hang', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.BICHNGOC\MSSQL\DATA\Quan_ly_ban_hang.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Quan_ly_ban_hang_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.BICHNGOC\MSSQL\DATA\Quan_ly_ban_hang_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Quan_ly_ban_hang] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Quan_ly_ban_hang].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Quan_ly_ban_hang] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET ARITHABORT OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET RECOVERY FULL 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET  MULTI_USER 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Quan_ly_ban_hang] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Quan_ly_ban_hang] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Quan_ly_ban_hang', N'ON'
GO
ALTER DATABASE [Quan_ly_ban_hang] SET QUERY_STORE = OFF
GO
USE [Quan_ly_ban_hang]
GO
/****** Object:  User [QuanLy]    Script Date: 4/22/2023 8:56:04 AM ******/
CREATE USER [QuanLy] FOR LOGIN [QuanLy] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NhanVien]    Script Date: 4/22/2023 8:56:04 AM ******/
CREATE USER [NhanVien] FOR LOGIN [NhanVien] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[F_SOLUONGDONDATHANG]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[F_SOLUONGDONDATHANG]
(@masp nchar(6))
returns int
as
begin
declare @soluong int
	select @soluong=count(MaPhieuDat)
	from CTPhieuDat 
	where MaSP=@masp 
	group by MaSP
	return @soluong	
end
GO
/****** Object:  UserDefinedFunction [dbo].[F_TANGLUONGNHANVIEN]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[F_TANGLUONGNHANVIEN](@manv nchar(6))
returns int
as
begin
declare @luong float
    select @luong =(Luong *0.05)+Luong
	from Nhanvien
	where @manv=MaNV
	return @luong
end
GO
/****** Object:  Table [dbo].[Sanpham]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sanpham](
	[MaSP] [nchar](6) NOT NULL,
	[MaloaiSP] [nchar](6) NOT NULL,
	[TenSP] [nvarchar](150) NOT NULL,
	[Dvitinh] [nvarchar](15) NULL,
	[Giaban] [float] NULL,
	[Slton] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTPhieuBan]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTPhieuBan](
	[MaPhieuBan] [nchar](6) NOT NULL,
	[MaSP] [nchar](6) NOT NULL,
	[Soluong] [int] NULL,
	[PTTT] [nvarchar](30) NULL,
	[Giaban] [float] NULL,
 CONSTRAINT [PK_CTPhieuBan] PRIMARY KEY CLUSTERED 
(
	[MaPhieuBan] ASC,
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[F_TINHTONGTRIGIATUNGMATHANG]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[F_TINHTONGTRIGIATUNGMATHANG]()
returns table
as
return (select ctpb.MaSP,TenSP, sum(Soluong*ctpb.Giaban) as Tongtrigia from Sanpham sp join CTPhieuBan ctpb on sp.MaSP=ctpb.MaSP group by ctpb.MaSP,TenSP)
GO
/****** Object:  Table [dbo].[PhieuDH]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDH](
	[MaPhieuDat] [nchar](6) NOT NULL,
	[ngayDH] [datetime] NULL,
	[MaKH] [nchar](6) NULL,
	[MaNV] [nchar](6) NULL,
	[Ghichu] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuDat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khachhang]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khachhang](
	[MaKH] [nchar](6) NOT NULL,
	[HotenKH] [nvarchar](100) NOT NULL,
	[Diachi] [nvarchar](150) NULL,
	[SDT] [nchar](10) NULL,
	[Email] [nvarchar](50) NULL,
	[Ghichu] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_KHACHHANGCOMAPHIEUDH_BB0001]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[V_KHACHHANGCOMAPHIEUDH_BB0001] 
as
select MaKH,HotenKH
from Khachhang
where MaKH = (select MaKH
			from PhieuDH 
			where MaPhieuDat like '%BB0001%')
GO
/****** Object:  View [dbo].[V_DSSanPham]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Tạo view Danh sách sản phẩm, thông tin cần hiển thị bao gồm: mã sản phẩm, tên sản phẩm, đơn vị tính, số lượng tồn
CREATE VIEW [dbo].[V_DSSanPham] 
AS
SELECT MaSP, TenSP, Dvitinh, Giaban, Slton
FROM SanPham
GO
/****** Object:  Table [dbo].[PhieuBH]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuBH](
	[MaPhieuBan] [nchar](6) NOT NULL,
	[ngayBH] [datetime] NULL,
	[MaKH] [nchar](6) NULL,
	[MaNV] [nchar](6) NULL,
	[Ghichu] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuBan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nhanvien]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nhanvien](
	[MaNV] [nchar](6) NOT NULL,
	[HotenNV] [nvarchar](100) NOT NULL,
	[NgSinh] [datetime] NULL,
	[Gioitinh] [nchar](4) NULL,
	[DiachiNV] [nvarchar](150) NULL,
	[Dienthoai] [nchar](10) NULL,
	[Email] [nvarchar](50) NULL,
	[Luong] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_DSNhanVienChuaLapPhieuBH]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_DSNhanVienChuaLapPhieuBH]
AS
SELECT MaNV, HotenNV
FROM NHANVIEN
WHERE NOT EXISTS (SELECT *
					FROM PhieuBH
					WHERE PhieuBH.MaNV = Nhanvien.MaNV)
GO
/****** Object:  View [dbo].[V_ThongKeSoLuong_SP_BanTheoNgay]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ThongKeSoLuong_SP_BanTheoNgay] 
AS
SELECT pb.ngayBH AS NgayBan, SUM(ctpb.Soluong) AS SoLuongBan
FROM PhieuBH pb
INNER JOIN CTPhieuBan ctpb ON pb.MaPhieuBan = ctpb.MaPhieuBan
GROUP BY pb.ngayBH
GO
/****** Object:  Table [dbo].[Loaisanpham]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Loaisanpham](
	[MaloaiSP] [nchar](6) NOT NULL,
	[TenloaiSP] [nvarchar](100) NOT NULL,
	[Ghichu] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaloaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_TongSoLuongBanTheoLoaiSP]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_TongSoLuongBanTheoLoaiSP]
AS
SELECT lsp.TenloaiSP, SUM(ctpb.Soluong) AS TongSoLuongBan
FROM LoaiSanPham lsp
INNER JOIN SanPham sp ON lsp.MaloaiSP = sp.MaloaiSP
INNER JOIN CTPhieuBan ctpb ON sp.MaSP = ctpb.MaSP
GROUP BY lsp.TenloaiSP
GO
/****** Object:  Table [dbo].[CTPhieuDat]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTPhieuDat](
	[MaPhieuDat] [nchar](6) NOT NULL,
	[MaSP] [nchar](6) NOT NULL,
	[Soluong] [int] NULL,
	[PTTT] [nvarchar](30) NULL,
	[Giaban] [float] NULL,
 CONSTRAINT [PK_CTPhieuDat] PRIMARY KEY CLUSTERED 
(
	[MaPhieuDat] ASC,
	[MaSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Soluong_KH_dat_SP]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Soluong_KH_dat_SP](
	[Tgian] [nvarchar](4000) NULL,
	[SluongKH] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0001', N'BBL01 ', 98, N'Chuyển khoản', 30000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0002', N'BBL03 ', 100, NULL, 48300)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0003', N'BBL01 ', 100, NULL, 30000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0004', N'BNC01 ', 100, NULL, 60000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0005', N'BBL02 ', 100, NULL, 56000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0006', N'KD04  ', 100, NULL, 2000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0007', N'BBL04 ', 90, NULL, 28000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0008', N'KD01  ', 80, N'Ví Momo', 15000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0009', N'BBL05 ', 100, NULL, 35000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0010', N'KD02  ', 100, NULL, 25000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0011', N'BBL05 ', 100, NULL, 35000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0012', N'BBL06 ', 100, NULL, 21000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0014', N'KS03  ', 100, NULL, 15000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0015', N'BBL02 ', 100, NULL, 56000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0016', N'KS02  ', 100, N'Chuyển khoản', 37000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0017', N'BBL02 ', 200, N'Chuyển khoản', 56000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0018', N'BBL02 ', 100, N'Tiền mặt', 56000)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0019', N'KS01  ', 100, NULL, 52500)
INSERT [dbo].[CTPhieuBan] ([MaPhieuBan], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0020', N'BBL05 ', 100, NULL, 35000)
GO
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0001', N'BBL01 ', 98, N'Chuyển khoản', 30000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0002', N'BBL03 ', 100, NULL, 48300)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0003', N'BBL01 ', 100, NULL, 30000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0004', N'BNC01 ', 100, NULL, 60000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0005', N'BBL02 ', 100, NULL, 56000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0006', N'KD04  ', 100, NULL, 2000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0007', N'BBL04 ', 90, NULL, 28000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0008', N'KD01  ', 80, N'Ví Momo', 15000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0009', N'BBL05 ', 100, NULL, 35000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0010', N'KD02  ', 100, NULL, 25000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0011', N'BBL05 ', 100, NULL, 35000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0012', N'BBL06 ', 100, NULL, 21000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0013', N'BNC04 ', 100, NULL, 15000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0014', N'KS03  ', 100, NULL, 15000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0015', N'BBL02 ', 100, NULL, 56000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0016', N'KS02  ', 100, N'Chuyển khoản', 37000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0017', N'BBL02 ', 200, N'Chuyển khoản', 56000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0018', N'BBL02 ', 100, N'Tiền mặt', 56000)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0019', N'KS01  ', 100, NULL, 52500)
INSERT [dbo].[CTPhieuDat] ([MaPhieuDat], [MaSP], [Soluong], [PTTT], [Giaban]) VALUES (N'BB0020', N'BBL05 ', 100, NULL, 35000)
GO
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'120012', N'Nguyễn Thị Minh Ngọc', N'123/6 bis Lê Thánh Tôn, Q1,Tp.HCM', N'98123123  ', N'ngocntm@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'120013', N'Trần Anh Tuấn ', N'49/12B Nguyễn Thị Minh Khai, Q1,Tp.HCM', N'91321321  ', N'tuanta@yahoo.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'120014', N'Lê Nam Anh', N'Ngõ 6, phố Thanh Xuân, Hà Nội', N'90312312  ', N'anhln@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'120015', N'Nguyễn Quốc Khánh', N'67 bis Nguyễn Thượng Hiền, Q.Bình Thạnh,Tp.HCM', N'90812712  ', N'khanhnq@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'130012', N'Nguyễn Văn Thành', N'123 Nguyen Thượng Hiền, Hà Nội', N'90815812  ', N'thanhnv@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'130013', N'Đặng Thu Thảo', N'567 Phan Văn Trị, Q.Gò Vấp,Tp.HCM', N'908128149 ', N'thaodt@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'130014', N'Lê Thị Thu', N'98 Trường Chinh, Q.Tân Bình,Tp.HCM', N'909328123 ', N'thult@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'130015', N'Thái Hoàng Gia Hân', N'Ngõ 123,phố Phù Sa,Hà Nội', N'945665412 ', N'hanth@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'130016', N'Lê Thị Thu', N'98 Trường Chinh, Q.Tân Bình,Tp.HCM', N'909328123 ', N'thult@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'140016', N'Trần Đình Nam', N'130 Hà Huy Tập, Hà Nội', N'912345634 ', N'namtd@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'140017', N'Ngô Thị Thanh Vân', N'12 Nguyễn Văn Bảo, Q.Gò Vấp,Tp.HCM', N'96789453  ', N'vanngth@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'140018', N'Nguyễn Văn Sơn', N'Ngõ 26 Đường Trại, Hà Nội', N'91234567  ', N'sonnv@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'140019', N'Lê Trường Khánh', N'20 Đồng Nai, Q.10,Tp.HCM', N'93456123  ', N'khanhlt@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'150002', N'Nguyễn Thị Thu Thảo', N'36 Nguyễn Du, Q.5,Tp.HCM', N'942322469 ', N'thaont@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'150004', N'Phạm Thị Lan', N'123 Sư Vạn Hạnh, Q.10,Tp.HCM', N'975345893 ', N'lanpt@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'150005', N'Ngô Văn Đạt', N'123 Lê Văn Việt,Tp.Thủ Đức,Tp.HCM', N'97354632  ', N'datnv@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'150011', N'Lê Nam Đình', N'Ngõ 33,Đại Nghĩa, Hà Nội', N'97432567  ', N'dinhnl@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'150012', N'Nguyễn Thị Hồng Nhung', N'127 Phạm Huy Thông, Q.Gò Vấp,Tp.HCM', N'912345676 ', N'nhungn@gmail.com', NULL)
INSERT [dbo].[Khachhang] ([MaKH], [HotenKH], [Diachi], [SDT], [Email], [Ghichu]) VALUES (N'150013', N'Võ Huyền Bích Ngọc', N'Đường 21/8, Tp.PR-Tc,Ninh Thuận', N'972433893 ', N'ngocv@gmail.com', NULL)
GO
INSERT [dbo].[Loaisanpham] ([MaloaiSP], [TenloaiSP], [Ghichu]) VALUES (N'BBC   ', N'Bánh Biscuits & Cookies', NULL)
INSERT [dbo].[Loaisanpham] ([MaloaiSP], [TenloaiSP], [Ghichu]) VALUES (N'BBL   ', N'Bánh Bông Lan', NULL)
INSERT [dbo].[Loaisanpham] ([MaloaiSP], [TenloaiSP], [Ghichu]) VALUES (N'BNC   ', N'Bột Ngũ Cốc', NULL)
INSERT [dbo].[Loaisanpham] ([MaloaiSP], [TenloaiSP], [Ghichu]) VALUES (N'KD    ', N'Kẹo Dẻo', NULL)
INSERT [dbo].[Loaisanpham] ([MaloaiSP], [TenloaiSP], [Ghichu]) VALUES (N'KS    ', N'Kẹo Socola', NULL)
GO
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'120001', N'Nguyễn Văn Sơn', CAST(N'1989-02-05T00:00:00.000' AS DateTime), N'Nam ', N'138 Nguyễn Văn Nghi, Q.Gò Vấp, Tp.HCM', N'23456743  ', N'sonnv@gmail.com', 8000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'120002', N'Mai Tiến Thọ', CAST(N'1976-03-15T00:00:00.000' AS DateTime), N'Nam ', N'Hẻm 36 Bùi Thị Xuân, Q.Tân Bình,Tp.HCM', N'933545556 ', N'thomt@gmail.com', 10000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'120003', N'Lê Thị Thanh', CAST(N'1988-10-08T00:00:00.000' AS DateTime), N'Nữ  ', N'Phan Văn Trị, Q.5,Tp.HCM', N'38383832  ', N'thanhlt@gmail.com', 3500000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'120004', N'Đào Thanh Huệ', CAST(N'1993-11-12T00:00:00.000' AS DateTime), N'Nữ  ', N'Sư Vạn Hạnh, Q.10,Tp.HCM', N'119393934 ', N'huedt@gmail.com', 3500000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'130012', N'Đặng Thu Thảo ', CAST(N'1987-02-08T00:00:00.000' AS DateTime), N'Nữ  ', N'Hàm Nghi , Q.1 , Tp . HCM', N'233455678 ', N'sonnv@gmail.com', 8000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'130013', N'Nguyễn Thị Thu Giang', CAST(N'1990-02-28T00:00:00.000' AS DateTime), N'Nữ  ', N'Lê Văn Sỹ, Q. Phú Nhuận, Tp.HCM', N'2827474468', N'thugiang@gmail.com', 5000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'130014', N'Nguyễn Văn Thanh', CAST(N'1989-12-28T00:00:00.000' AS DateTime), N'Nam ', N'Phan Xích Long, Q.Phú Nhuận,Tp.HCM', N'8696695844', N'vanthanhg@gmail.com', 6000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'130015', N'Đỗ Duy Minh', CAST(N'1985-11-08T00:00:00.000' AS DateTime), N'Nam ', N'Ngõ 20 Bùi Xương Trạch, Hà Nội', N'934555331 ', N'duyminh@gmail.com', 5000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'130016', N'Lê Minh Huy', CAST(N'1977-01-28T00:00:00.000' AS DateTime), N'Nam ', N'Ngõ 72 Đường Trại,Hà Nội', N'6969677970', N'minhhuyg@gmail.com', 9000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'140009', N'Lê Thị Thu Hoài', CAST(N'2000-10-20T00:00:00.000' AS DateTime), N'Nữ  ', N'124 Đường Trần Lư, Hà Nội', N'823221134 ', N'thuhoai@gmail.com', 7000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'140010', N'Ngô Đình Duyên', CAST(N'1992-03-02T00:00:00.000' AS DateTime), N'Nữ  ', N'Ngõ 81 Phúc Yên, Hà Nội', N'883924691 ', N'duyendinh@gmail.com', 5500000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'140011', N'Lê Lý Lan Hương', CAST(N'1993-12-03T00:00:00.000' AS DateTime), N'Nữ  ', N'Ngõ 213 phố Ngô Xuân Quảng, Hà Nội', N'929334411 ', N'lanhuongg@gmail.com', 4500000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'140012', N'Nguyễn Đình Nam', CAST(N'1988-10-13T00:00:00.000' AS DateTime), N'Nam ', N'Ngõ 81 Lệ Mật', N'98994986  ', N'dinhnamk@gmail.com', 7000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'140013', N'Lý Hoàng Long', CAST(N'1993-03-03T00:00:00.000' AS DateTime), N'Nam ', N'Phan Huy Ích, Q.7, Tp.HCM', N'948585858 ', N'hoanglong@gmail.com', 5500000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'140014', N'Nguyễn Hữu Hoàng', CAST(N'1989-10-03T00:00:00.000' AS DateTime), N'Nam ', N'Lê Văn Việt,Q.9,Tp.HCM', N'93409403  ', N'huuhoang@gmail.com', 6500000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'150003', N'Lê Đức Anh', CAST(N'1988-03-04T00:00:00.000' AS DateTime), N'Nam ', N'567 Đào Duy Anh, Q. Phú Nhuận, Tp.HCM', N'93889248  ', N'ducanh@gmail.com', 6600000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'150004', N'Mai Quốc Việt', CAST(N'1990-12-13T00:00:00.000' AS DateTime), N'Nam ', N'Hẻm 34 Lê Lợi, Q.Gò Vấp, Tp.HCM', N'993920224 ', N'quocviet@gmail.com', 5500000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'160004', N'Dương Đình Huy', CAST(N'1983-11-30T00:00:00.000' AS DateTime), N'Nam ', N'334 Bùi Thị Xuân,Q.Tân Bình,Tp.HCM', N'948944959 ', N'dinhhuy@gmail.com', 9500000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'160005', N'Lê Như Hạ', CAST(N'2000-12-12T00:00:00.000' AS DateTime), N'Nữ  ', N'886 Nguyễn Thị Minh Khai,Q.3,Tp.HCM', N'934562345 ', N'nhuha@gmail.com', 4000000)
INSERT [dbo].[Nhanvien] ([MaNV], [HotenNV], [NgSinh], [Gioitinh], [DiachiNV], [Dienthoai], [Email], [Luong]) VALUES (N'160006', N'Nguyễn Thành Công', CAST(N'1987-01-03T00:00:00.000' AS DateTime), N'Nam ', N'Ngõ 222 Đường Lai Xá,Hà Nội', N'92929322  ', N'thanhcong@gmail.com', 7500000)
GO
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0001', CAST(N'2023-01-29T00:00:00.000' AS DateTime), N'120012', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0002', CAST(N'2023-01-23T00:00:00.000' AS DateTime), N'120015', N'120002', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0003', CAST(N'2023-01-31T00:00:00.000' AS DateTime), N'130014', N'120004', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0004', CAST(N'2023-02-15T00:00:00.000' AS DateTime), N'120014', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0005', CAST(N'2023-02-28T00:00:00.000' AS DateTime), N'150005', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0006', CAST(N'2023-02-28T00:00:00.000' AS DateTime), N'150012', N'120004', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0007', CAST(N'2023-03-02T00:00:00.000' AS DateTime), N'150005', N'130016', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0008', CAST(N'2023-03-23T00:00:00.000' AS DateTime), N'120014', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0009', CAST(N'2023-03-04T00:00:00.000' AS DateTime), N'150012', N'120004', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0010', CAST(N'2023-02-28T00:00:00.000' AS DateTime), N'150005', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0011', CAST(N'2023-03-30T00:00:00.000' AS DateTime), N'150012', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0012', CAST(N'2023-03-11T00:00:00.000' AS DateTime), N'120012', N'120004', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0014', CAST(N'2023-04-15T00:00:00.000' AS DateTime), N'130014', N'130016', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0015', CAST(N'2023-03-27T00:00:00.000' AS DateTime), N'120014', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0016', CAST(N'2023-03-25T00:00:00.000' AS DateTime), N'120014', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0017', CAST(N'2023-04-05T00:00:00.000' AS DateTime), N'120012', N'130016', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0018', CAST(N'2023-04-10T00:00:00.000' AS DateTime), N'130014', N'130013', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0019', CAST(N'2023-01-29T00:00:00.000' AS DateTime), N'120012', N'130016', NULL)
INSERT [dbo].[PhieuBH] ([MaPhieuBan], [ngayBH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0020', CAST(N'2023-04-17T00:00:00.000' AS DateTime), N'130014', N'130013', NULL)
GO
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0001', CAST(N'2023-01-01T00:00:00.000' AS DateTime), N'120012', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0002', CAST(N'2023-01-03T00:00:00.000' AS DateTime), N'120015', N'120002', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0003', CAST(N'2023-01-07T00:00:00.000' AS DateTime), N'130014', N'120004', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0004', CAST(N'2023-01-15T00:00:00.000' AS DateTime), N'120014', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0005', CAST(N'2023-02-01T00:00:00.000' AS DateTime), N'150005', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0006', CAST(N'2023-02-01T00:00:00.000' AS DateTime), N'150012', N'120004', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0007', CAST(N'2023-02-02T00:00:00.000' AS DateTime), N'150005', N'130016', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0008', CAST(N'2023-02-22T00:00:00.000' AS DateTime), N'120014', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0009', CAST(N'2023-02-05T00:00:00.000' AS DateTime), N'150012', N'120004', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0010', CAST(N'2023-01-31T00:00:00.000' AS DateTime), N'150005', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0011', CAST(N'2023-02-21T00:00:00.000' AS DateTime), N'150012', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0012', CAST(N'2023-02-11T00:00:00.000' AS DateTime), N'120012', N'120004', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0013', CAST(N'2023-01-29T00:00:00.000' AS DateTime), N'120012', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0014', CAST(N'2023-03-11T00:00:00.000' AS DateTime), N'130014', N'130016', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0015', CAST(N'2023-02-17T00:00:00.000' AS DateTime), N'120014', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0016', CAST(N'2023-03-01T00:00:00.000' AS DateTime), N'120014', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0017', CAST(N'2023-03-10T00:00:00.000' AS DateTime), N'120012', N'130016', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0018', CAST(N'2023-03-20T00:00:00.000' AS DateTime), N'130014', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0019', CAST(N'2023-01-05T00:00:00.000' AS DateTime), N'120012', N'130016', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0020', CAST(N'2023-03-20T00:00:00.000' AS DateTime), N'130014', N'130013', NULL)
INSERT [dbo].[PhieuDH] ([MaPhieuDat], [ngayDH], [MaKH], [MaNV], [Ghichu]) VALUES (N'BB0021', CAST(N'2023-04-11T10:30:00.000' AS DateTime), N'150012', N'120001', N'Đơn hàng mới')
GO
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BBL01 ', N'BBL   ', N'Bánh Bông Lan Cuộn', N'hộp', 30000, 324)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BBL02 ', N'BBL   ', N'Bánh Bông Lan Kem Deli', N'hộp', 56000, 550)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BBL03 ', N'BBL   ', N'Bánh Bông Lan Kem Dâu', N'hộp', 48300, 155)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BBL04 ', N'BBL   ', N'Bánh Bông Lan Kem Cốm', N'hộp', 28000, 235)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BBL05 ', N'BBL   ', N'Bánh Bông Lan Kem Nho', N'hộp', 35000, 400)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BBL06 ', N'BBL   ', N'Bánh Bông Lan Kem Cam', N'hộp', 21000, 210)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BNC01 ', N'BNC   ', N'Bột ngũ cốc vị socola', N'hộp', 60000, 754)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BNC02 ', N'BNC   ', N'Bột ngũ cốc dinh dưỡng VinaCafe', N'gói', 55000, 190)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BNC03 ', N'BNC   ', N'Yến mạch Quaker', N'gói', 75000, 350)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BNC04 ', N'BNC   ', N'Bánh ngũ cốc', N'gói', 15000, 240)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BNC05 ', N'BNC   ', N'Yến mạch nguyên chất Yumfood', N'gói', 69000, 270)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'BNC06 ', N'BNC   ', N'Ngũ cốc trái cây Calbee', N'gói', 195000, 500)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'KD01  ', N'KD    ', N'Kẹo dẻo Goldbears', N'gói', 15000, 200)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'KD02  ', N'KD    ', N'Kẹo dẻo trái cây', N'gói', 25000, 150)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'KD03  ', N'KD    ', N'Kẹo dẻo hữu cơ hình gấu', N'gói', 10000, 250)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'KD04  ', N'KD    ', N'Kẹo dẻo Jelly Chip', N'gói', 2000, 1000)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'KS01  ', N'KS    ', N'Sococla đen hạt phỉ', N'thanh', 52500, 100)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'KS02  ', N'KS    ', N'Socola sữa ', N'thanh', 37000, 200)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'KS03  ', N'KS    ', N'Socola kem sữa hạnh nhân', N'gói', 15000, 200)
INSERT [dbo].[Sanpham] ([MaSP], [MaloaiSP], [TenSP], [Dvitinh], [Giaban], [Slton]) VALUES (N'KS04  ', N'KS    ', N'Socola trà xanh Morinaga', N'gói', 35000, 450)
GO
INSERT [dbo].[Soluong_KH_dat_SP] ([Tgian], [SluongKH]) VALUES (N'2023-01', 5)
INSERT [dbo].[Soluong_KH_dat_SP] ([Tgian], [SluongKH]) VALUES (N'2023-02', 4)
INSERT [dbo].[Soluong_KH_dat_SP] ([Tgian], [SluongKH]) VALUES (N'2023-03', 3)
INSERT [dbo].[Soluong_KH_dat_SP] ([Tgian], [SluongKH]) VALUES (N'2023-04', 1)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Index_HotenNV]    Script Date: 4/22/2023 8:56:04 AM ******/
CREATE NONCLUSTERED INDEX [Index_HotenNV] ON [dbo].[Nhanvien]
(
	[HotenNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Index_TenSP]    Script Date: 4/22/2023 8:56:04 AM ******/
CREATE NONCLUSTERED INDEX [Index_TenSP] ON [dbo].[Sanpham]
(
	[TenSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CTPhieuBan]  WITH CHECK ADD  CONSTRAINT [Fk_CTPhieuBan_MaPhieuBan] FOREIGN KEY([MaPhieuBan])
REFERENCES [dbo].[PhieuBH] ([MaPhieuBan])
GO
ALTER TABLE [dbo].[CTPhieuBan] CHECK CONSTRAINT [Fk_CTPhieuBan_MaPhieuBan]
GO
ALTER TABLE [dbo].[CTPhieuBan]  WITH CHECK ADD  CONSTRAINT [Fk_CTPhieuBan_MaSP] FOREIGN KEY([MaSP])
REFERENCES [dbo].[Sanpham] ([MaSP])
GO
ALTER TABLE [dbo].[CTPhieuBan] CHECK CONSTRAINT [Fk_CTPhieuBan_MaSP]
GO
ALTER TABLE [dbo].[CTPhieuDat]  WITH CHECK ADD  CONSTRAINT [FK_CTPhieuDat_MaPhieuDat] FOREIGN KEY([MaPhieuDat])
REFERENCES [dbo].[PhieuDH] ([MaPhieuDat])
GO
ALTER TABLE [dbo].[CTPhieuDat] CHECK CONSTRAINT [FK_CTPhieuDat_MaPhieuDat]
GO
ALTER TABLE [dbo].[CTPhieuDat]  WITH CHECK ADD  CONSTRAINT [Fk_CTPhieuDat_MaSP] FOREIGN KEY([MaSP])
REFERENCES [dbo].[Sanpham] ([MaSP])
GO
ALTER TABLE [dbo].[CTPhieuDat] CHECK CONSTRAINT [Fk_CTPhieuDat_MaSP]
GO
ALTER TABLE [dbo].[PhieuBH]  WITH CHECK ADD  CONSTRAINT [Fk_PhieuBH_MaKH] FOREIGN KEY([MaKH])
REFERENCES [dbo].[Khachhang] ([MaKH])
GO
ALTER TABLE [dbo].[PhieuBH] CHECK CONSTRAINT [Fk_PhieuBH_MaKH]
GO
ALTER TABLE [dbo].[PhieuBH]  WITH CHECK ADD  CONSTRAINT [Fk_PhieuBH_MaNV] FOREIGN KEY([MaNV])
REFERENCES [dbo].[Nhanvien] ([MaNV])
GO
ALTER TABLE [dbo].[PhieuBH] CHECK CONSTRAINT [Fk_PhieuBH_MaNV]
GO
ALTER TABLE [dbo].[PhieuDH]  WITH CHECK ADD  CONSTRAINT [Fk_PhieuDH_MaKH] FOREIGN KEY([MaKH])
REFERENCES [dbo].[Khachhang] ([MaKH])
GO
ALTER TABLE [dbo].[PhieuDH] CHECK CONSTRAINT [Fk_PhieuDH_MaKH]
GO
ALTER TABLE [dbo].[PhieuDH]  WITH CHECK ADD  CONSTRAINT [Fk_PhieuDH_MaNV] FOREIGN KEY([MaNV])
REFERENCES [dbo].[Nhanvien] ([MaNV])
GO
ALTER TABLE [dbo].[PhieuDH] CHECK CONSTRAINT [Fk_PhieuDH_MaNV]
GO
ALTER TABLE [dbo].[Sanpham]  WITH CHECK ADD  CONSTRAINT [FK_Sanpham_MaloaiSP] FOREIGN KEY([MaloaiSP])
REFERENCES [dbo].[Loaisanpham] ([MaloaiSP])
GO
ALTER TABLE [dbo].[Sanpham] CHECK CONSTRAINT [FK_Sanpham_MaloaiSP]
GO
ALTER TABLE [dbo].[Nhanvien]  WITH CHECK ADD CHECK  (([Gioitinh]=N'Nữ' OR [Gioitinh]='Nam'))
GO
/****** Object:  StoredProcedure [dbo].[SP_CAPNHATDIACHIKHACHHANG]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_CAPNHATDIACHIKHACHHANG]
(@makh nchar(6),@diachi nvarchar(150))
as
begin
declare @Error int, @Rowcount int
begin tran
if exists (select * from Khachhang where @makh=MaKH)
	begin
	update Khachhang
	set Diachi=@diachi
	from Khachhang
	where @makh=MaKH	
	end
else 
	print N'Mã khách hàng không hợp lệ'
	select @Error=@@ERROR,@Rowcount=@@ROWCOUNT
	if @Error<>0 or @Rowcount<>1
	begin
	rollback tran
	return -999
	end
	else
	print N'Thực hiện thành công'
	commit;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_CAPNHATSOLUONGTON]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_CAPNHATSOLUONGTON]
(@masp nchar(6),@slton int)
as
begin
declare @Error int, @Rowcount int
begin tran
if exists (select * from Sanpham where @masp=MaSP)
	begin
	update Sanpham
	set Slton=@slton
	from Sanpham
	where @masp=MaSP
	end
else 
	print N'Mã sản phẩm không hợp lệ'
	select @Error=@@ERROR,@Rowcount=@@ROWCOUNT
	if @Error<>0 or @Rowcount<>1
	begin
	rollback tran
	return -999
	end
	else
	print N'Thực hiện thành công'
	commit;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DANHSACHTOP5PHIEUBANHANG]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_DANHSACHTOP5PHIEUBANHANG]
as
begin
select top 5 MaPhieuBan,ctpb.MaSP,TenSP,sum(Soluong*Giaban) as Tongtrigia
from Sanpham sp join CTPhieuBan ctpb on sp.MaSP=ctpb.MaSP
group by MaPhieuBan,ctpb.MaSP,TenSP
order by sum(Soluong*Giaban) DESC
end
GO
/****** Object:  StoredProcedure [dbo].[SP_SLTon]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SP_SLTon](@MaSP nchar(6))
as
begin
    if not exists (select * from SanPham where MaSP = @MaSP)
    begin
        Print N'Không có mã sản phẩm này!!!'
    end
    else
    begin
        declare @SoLuongTon int
        select @SoLuongTon = Slton from SanPham where MaSP = @MaSP
        if @SoLuongTon > 0
			Begin
				Print N'Còn hàng'
				print N'Số lượng hàng tồn là: '+ cast(@SoLuongTon as nvarchar(10))
			end
        else
            select N'Đã hết hàng'
    end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ThemPhieuDH]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_ThemPhieuDH]
    @MaPhieuDat nchar(6),
    @NgayDH datetime,
    @MaKH nchar(6),
    @MaNV nchar(6),
    @GhiChu nvarchar(50)
as
begin
    begin transaction
    begin try
        -- Thêm đơn đặt hàng mới vào bảng PhieuDH
        insert into PhieuDH(MaPhieuDat, NgayDH, MaKH, MaNV, Ghichu)
        values (@MaPhieuDat, @NgayDH, @MaKH, @MaNV, @GhiChu)

        -- Commit transaction khi không có lỗi xảy ra
        commit transaction
        print N'Thêm phiếu đặt hàng thành công'
    end try
    begin catch
        -- Rollback transaction khi có lỗi xảy ra
        rollback transaction
        print N'Thêm phiếu đặt hàng thất bại. Lỗi: ' + ERROR_MESSAGE() 
    end catch
end
GO
/****** Object:  StoredProcedure [dbo].[SP_Thongtin_KH]    Script Date: 4/22/2023 8:56:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SP_Thongtin_KH](@MaKH nvarchar(6))
As
Begin
	select *
	From KhachHang
	where MaKH=@MaKH
End
GO
USE [master]
GO
ALTER DATABASE [Quan_ly_ban_hang] SET  READ_WRITE 
GO
