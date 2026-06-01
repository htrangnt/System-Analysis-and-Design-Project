--Tao bang
CREATE TABLE Khachhang (
    MaKH NVARCHAR(12) PRIMARY KEY,
    TenKH NVARCHAR(25) NOT NULL,
    DiachiKH NVARCHAR(100),
    SDTKH NVARCHAR(11) NOT NULL,
    NgaysinhKH DATE,
    GioitinhKH NVARCHAR(3)
);


CREATE TABLE Nhanvien (
    MaNV NVARCHAR(12) PRIMARY KEY,
    TenNV NVARCHAR(25) NOT NULL,
    Gioitinh NVARCHAR(3) NOT NULL,
    Ngaysinh DATE NOT NULL,
    SDT NVARCHAR(11) NOT NULL,
    DiachiNV NVARCHAR(100),
    Chucvu NVARCHAR(20) NOT NULL
);


CREATE TABLE Taikhoan (
    Username NVARCHAR(30) PRIMARY KEY,
    Password NVARCHAR(30) NOT NULL,
    MaNV NVARCHAR(12),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);

CREATE TABLE Nhacungcap (
    MaNCC NVARCHAR(12) PRIMARY KEY,
    TenNCC NVARCHAR(50) NOT NULL,
    Diachi NVARCHAR(100) NOT NULL,
    Email NVARCHAR(25)
);


CREATE TABLE Hanghoa (
    MaH NVARCHAR(12) PRIMARY KEY,
    TenH NVARCHAR(30) NOT NULL,
    DongiaH DECIMAL(10,2) NOT NULL,
    Donvitinh NVARCHAR(5) NOT NULL,
    Hansudung DATE NOT NULL,
    NoiSX NVARCHAR(100),
    LoaiH NVARCHAR(20),
    Mota NTEXT
);


CREATE TABLE Hoadon (
    MaHD NVARCHAR(12) PRIMARY KEY,
    Ngayban DATE NOT NULL,
    Tongtien DECIMAL(13,2) NOT NULL,
    PTTT NVARCHAR(12) NOT NULL,
    MaKH NVARCHAR(12),
    MaNV NVARCHAR(12),
    FOREIGN KEY (MaKH) REFERENCES Khachhang(MaKH),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);


CREATE TABLE Chitiet_Hoadon (
    MaH NVARCHAR(12),
    MaHD NVARCHAR(12),
    SL_hangban INT,
    Dongia_ban DECIMAL(10,2),
    Magiamgia NVARCHAR(12),
    PRIMARY KEY (MaH, MaHD),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaHD) REFERENCES Hoadon(MaHD)
);


CREATE TABLE Phieu_yeucau_Xuatkho (
    MaYC NVARCHAR(12) PRIMARY KEY,
    Lydo NTEXT NOT NULL,
    MaNV NVARCHAR(12),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);


CREATE TABLE Chitiet_PYCXK (
    MaH NVARCHAR(12),
    MaYC NVARCHAR(12),
    SL_hangyeucau INT,
    PRIMARY KEY (MaH, MaYC),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaYC) REFERENCES Phieu_yeucau_Xuatkho(MaYC)
);


CREATE TABLE Phieukiemke (
    MaPKK NVARCHAR(12) PRIMARY KEY,
    NgayKK DATE NOT NULL,
    GhichuKK NTEXT,
    MaNV NVARCHAR(12),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);


CREATE TABLE Chitiet_PKK (
    MaH NVARCHAR(12),
    MaPKK NVARCHAR(12),
    SL_hangKK INT,
    PRIMARY KEY (MaH, MaPKK),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaPKK) REFERENCES Phieukiemke(MaPKK)
);


CREATE TABLE Phieuxuat (
    MaPX NVARCHAR(12) PRIMARY KEY,
    Ngayxuat DATE NOT NULL,
    GhichuPX NTEXT,
    MaNV NVARCHAR(12),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);


CREATE TABLE Chitiet_PX (
    MaH NVARCHAR(12),
    MaPX NVARCHAR(12),
    SL_hangxuat INT,
    Dongiaxuat DECIMAL(10,2),
    PRIMARY KEY (MaH, MaPX),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaPX) REFERENCES Phieuxuat(MaPX)
);


CREATE TABLE Phieunhap (
    MaPN NVARCHAR(12) PRIMARY KEY,
    Ngaynhap DATE NOT NULL,
    Tongtiennhap DECIMAL(14,2) NOT NULL,
    GhichuPN NTEXT,
    MaNCC NVARCHAR(12),
    MaNV NVARCHAR(12),
    FOREIGN KEY (MaNCC) REFERENCES Nhacungcap(MaNCC),
    FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV)
);


CREATE TABLE Chitiet_PN (
    MaH NVARCHAR(12),
    MaPN NVARCHAR(12),
    SL_hangnhap INT,
    Dongianhap DECIMAL(12,2),
    PRIMARY KEY (MaH, MaPN),
    FOREIGN KEY (MaH) REFERENCES Hanghoa(MaH),
    FOREIGN KEY (MaPN) REFERENCES Phieunhap(MaPN)
);


--RBTV
ALTER TABLE Khachhang
ADD CONSTRAINT CK_KhachHang_GioiTinh
CHECK (GioitinhKH IN (N'Nam', N'Nữ'));


ALTER TABLE Nhanvien
ADD CONSTRAINT CK_NhanVien_GioiTinh
CHECK (Gioitinh IN (N'Nam', N'Nữ'));


ALTER TABLE Hoadon
ADD CONSTRAINT CK_HoaDon_PTTT
CHECK (PTTT IN (N'Tiền mặt', N'Chuyển khoản'));


ALTER TABLE Chitiet_Hoadon
ADD CONSTRAINT CK_CTHD_SL
CHECK (SL_hangban > 0);


ALTER TABLE Chitiet_HoaDon
ADD CONSTRAINT CK_CTHD_DonGia
CHECK (Dongia_ban > 0);


ALTER TABLE Chitiet_PN
ADD CONSTRAINT CK_CTPN_SL
CHECK (SL_hangnhap > 0);


ALTER TABLE Chitiet_PN
ADD CONSTRAINT CK_CTPN_DonGia
CHECK (Dongianhap > 0);


ALTER TABLE Chitiet_PX
ADD CONSTRAINT CK_CTPX_SL
CHECK (SL_hangxuat > 0);


ALTER TABLE Chitiet_PKK
ADD CONSTRAINT CK_CTPKK_SL
CHECK (SL_hangKK >= 0);


ALTER TABLE Hoadon
ADD CONSTRAINT CK_HoaDon_Ngay
CHECK (Ngayban <= GETDATE());


ALTER TABLE Phieunhap
ADD CONSTRAINT CK_PhieuNhap_Ngay
CHECK (Ngaynhap <= GETDATE());


ALTER TABLE Phieuxuat
ADD CONSTRAINT CK_PhieuXuat_Ngay
CHECK (Ngayxuat <= GETDATE());


ALTER TABLE Phieukiemke
ADD CONSTRAINT CK_PhieuKK_Ngay
CHECK (NgayKK <= GETDATE());


ALTER TABLE Chitiet_PYCXK
ADD CONSTRAINT CK_SL_YeuCau_Positive
CHECK (SL_hangyeucau > 0);



--Them du lieu
INSERT INTO Nhanvien(MaNV, TenNV, Gioitinh, Ngaysinh, SDT, DiachiNV, Chucvu)
VALUES
('NV001',N'Nguyễn Văn An',N'Nam','1990-05-10','0912345678',N'Hà Nội',N'Admin'),
('NV002',N'Trần Thị Bình',N'Nữ','1992-08-15','0987654321',N'Hải Phòng',N'Bán hàng'),
('NV003',N'Lê Văn Cường',N'Nam','1988-11-20','0934567890',N'Đà Nẵng',N'Thủ kho'),
('NV004',N'Phạm Thị Dung',N'Nữ','1995-02-25','0976543210',N'TP.HCM',N'Admin'),
('NV005',N'Hoàng Văn Đông',N'Nam','1987-12-12','0901234567',N'Huế',N'Thủ kho'),
('NV006',N'Đỗ Thị Hạnh',N'Nữ','1994-06-01','0965432109',N'Quảng Ninh',N'Bán hàng'),
('NV007',N'Nguyễn Văn Giang',N'Nam','1989-04-14','0923456789',N'Nam Định',N'Thủ kho'),
('NV008',N'Trần Thị Hòa',N'Nữ','1991-09-23','0945678901',N'Thanh Hóa',N'Admin'),
('NV009',N'Lê Văn Hùng',N'Nam','1993-03-17','0932109876',N'Nghệ An',N'Bán hàng'),
('NV010',N'Lê Ngọc Lệ',N'Nữ','1996-10-05','0956789012',N'Hà Nam',N'Thủ kho'),
('NV011',N'Phan Tấn Huy',N'Nam','1990-01-01','0911222333',N'TP.HCM',N'Quản lý'),
('NV012',N'Trần Thảo Linh',N'Nữ','1992-02-02','0933444555',N'Hà Nội',N'Bán hàng'),
('NV013',N'Lê Nam',N'Nam','1994-03-03','0944555666',N'Hải Phòng',N'Admin'),
('NV014',N'Phan Ngọc Nhi',N'Nữ','1995-04-04','0955666777',N'Đà Nẵng',N'Admin'),
('NV015',N'Hoàng Văn Phúc',N'Nam','1988-05-05','0966777888',N'Huế',N'Admin'),
('NV016',N'Đỗ Thị Quỳnh',N'Nữ','1991-06-06','0977888999',N'Quảng Ninh',N'Bán hàng'),
('NV017',N'Hồ Xuân Triết',N'Nam','1989-07-07','0988999000',N'Nam Định',N'Thủ kho'),
('NV018',N'Trần Thị Sen',N'Nữ','1993-08-08','0999000111',N'Thanh Hóa',N'Admin'),
('NV019',N'Trần Văn Tùng',N'Nam','1996-09-09','0900111222',N'Nghệ An',N'Bán hàng'),
('NV020',N'Phạm Thị Uyên',N'Nữ','1990-10-10','0911222444',N'Hà Nam',N'Thủ kho');
select * from dbo.Nhanvien

INSERT INTO Khachhang(MaKH, TenKH, DiachiKH, SDTKH, NgaysinhKH, GioitinhKH)
VALUES
('KH001',N'Nguyễn Thị Ánh',N'Hà Nội','0939876543','1990-05-05',N'Nữ'),
('KH002',N'Trần Văn Bình',N'Hải Phòng','0948765432','1988-06-06',N'Nam'),
('KH003',N'Lê Thị Chi',N'Đà Nẵng','0957654321','1995-07-07',N'Nữ'),
('KH004',N'Phạm Văn Dũng',N'TP.HCM','0966543210','1992-08-08',N'Nam'),
('KH005',N'Hoàng Thị Em',N'Huế','0975432109','1993-09-09',N'Nữ'),
('KH006',N'Đỗ Văn Phúc',N'Quảng Ninh','0984321098','1989-10-10',N'Nam'),
('KH007',N'Nguyễn Thị Giang',N'Nam Định','0993210987','1994-11-11',N'Nữ'),
('KH008',N'Trần Văn Hải',N'Thanh Hóa','0902109876','1991-12-12',N'Nam'),
('KH009',N'Lê Thị Hạnh',N'Nghệ An','0911098765','1990-01-01',N'Nữ'),
('KH010',N'Phạm Văn Khải',N'Hà Nam','0920987654','1987-02-02',N'Nam'),
('KH011',N'Nguyễn Thị Lan',N'Hà Nội','0939876500','1996-03-03',N'Nữ'),
('KH012',N'Trần Văn Mạnh',N'Hải Phòng','0948765400','1988-04-04',N'Nam'),
('KH013',N'Lê Thị Nga',N'Đà Nẵng','0957654300','1995-05-05',N'Nữ'),
('KH014',N'Phạm Văn Nam',N'TP.HCM','0966543200','1992-06-06',N'Nam'),
('KH015',N'Hoàng Thị Oanh',N'Huế','0975432100','1993-07-07',N'Nữ'),
('KH016',N'Đỗ Văn Quang',N'Quảng Ninh','0984321000','1989-08-08',N'Nam'),
('KH017',N'Nguyễn Thị Phương',N'Nam Định','0993210000','1994-09-09',N'Nữ'),
('KH018',N'Trần Văn Sơn',N'Thanh Hóa','0902109000','1991-10-10',N'Nam'),
('KH019',N'Lê Thị Trang',N'Nghệ An','0911098000','1990-11-11',N'Nữ'),
('KH020',N'Phạm Văn Vinh',N'Hà Nam','0920987000','1987-12-12',N'Nam');
select * from dbo.Khachhang

INSERT INTO Hanghoa(MaH, TenH, DongiaH, Donvitinh, Hansudung, NoiSX, LoaiH, Mota)
VALUES
('HH001', N'Gạo ST25', 25000, N'Kg', '2026-12-31', N'Sóc Trăng', N'Thực phẩm', N'Gạo đặc sản ST25'),
('HH002', N'Nước mắm Nam Ngư', 15000, N'Chai', '2025-08-31', N'Phú Quốc', N'Thực phẩm', N'Nước mắm truyền thống'),
('HH003', N'Mì Hảo Hảo', 4000, N'Gói', '2025-06-15', N'Việt Nam', N'Thực phẩm', N'Mì gói vị tôm chua cay'),
('HH004', N'Đường trắng', 18000, N'Kg', '2026-03-20', N'Tiền Giang', N'Thực phẩm', N'Đường tinh luyện'),
('HH005', N'Dầu ăn Tường An', 45000, N'Chai', '2025-11-10', N'Bình Dương', N'Thực phẩm', N'Dầu ăn tinh luyện'),
('HH006', N'Bánh Oreo', 12000, N'Gói', '2025-04-05', N'Indonesia', N'Thực phẩm', N'Bánh quy kem socola'),
('HH007', N'Sữa tươi Vinamilk', 32000, N'Hộp', '2025-07-25', N'Việt Nam', N'Thực phẩm', N'Sữa tươi nguyên chất'),
('HH008', N'Cà phê Trung Nguyên', 65000, N'Gói', '2026-01-15', N'Đắk Lắk', N'Thực phẩm', N'Cà phê rang xay'),
('HH009', N'Nước suối Lavie', 5000, N'Chai', '2025-09-01', N'Long An', N'Thức uống', N'Nước khoáng thiên nhiên'),
('HH010', N'Coca-Cola', 10000, N'Lon', '2025-05-30', N'Việt Nam', N'Thức uống', N'Nước ngọt có gas'),
('HH011', N'Pepsi', 10000, N'Lon', '2025-06-18', N'Việt Nam', N'Thức uống', N'Nước ngọt có gas'),
('HH012', N'Trà xanh Không độ', 12000, N'Chai', '2025-07-12', N'Việt Nam', N'Thức uống', N'Trà xanh đóng chai'),
('HH013', N'Bia Heineken', 20000, N'Lon', '2025-10-20', N'Hà Lan', N'Thức uống', N'Bia lon cao cấp'),
('HH014', N'Bia Sài Gòn', 15000, N'Lon', '2025-08-08', N'Việt Nam', N'Thức uống', N'Bia lon truyền thống'),
('HH015', N'Nước tăng lực Red Bull', 15000, N'Lon', '2025-09-15', N'Thái Lan', N'Thức uống', N'Nước tăng lực'),
('HH016', N'Nước ép cam Twister', 18000, N'Chai', '2025-07-20', N'Việt Nam', N'Thức uống', N'Nước ép cam'),
('HH017', N'Trà sữa đóng chai', 25000, N'Chai', '2025-06-22', N'Việt Nam', N'Thức uống', N'Trà sữa hương trân châu'),
('HH018', N'Nước yến Khánh Hòa', 45000, N'Chai', '2025-12-25', N'Khánh Hòa', N'Thức uống', N'Nước yến sào'),
('HH019', N'Nước khoáng Vĩnh Hảo', 6000, N'Chai', '2025-09-30', N'Bình Thuận', N'Thức uống', N'Nước khoáng thiên nhiên'),
('HH020', N'Nước ép táo', 20000, N'Chai', '2025-08-14', N'Việt Nam', N'Thức uống', N'Nước ép táo nguyên chất');
select * from dbo.Hanghoa

INSERT INTO Taikhoan(Username, Password, MaNV)
VALUES
('user001','123','NV001'),
('user002','123','NV002'),
('user003','123','NV003'),
('user004','123','NV004'),
('user005','123','NV005'),
('user006','123','NV006'),
('user007','123','NV007'),
('user008','123','NV008'),
('user009','123','NV009'),
('user010','123','NV010'),
('user011','123','NV011'),
('user012','123','NV012'),
('user013','123','NV013'),
('user014','123','NV014'),
('user015','123','NV015'),
('user016','123','NV016'),
('user017','123','NV017'),
('user018','123','NV018'),
('user019','123','NV019'),
('user020','123','NV020');
select * from dbo.Taikhoan

INSERT INTO Nhacungcap(MaNCC, TenNCC, Diachi, Email)
VALUES
('NCC001', N'Công ty Gạo Việt', N'Sóc Trăng', N'gaoviet@gmail.com'),
('NCC002', N'Nước mắm Phú Quốc', N'Phú Quốc', N'nuocmamPQ@gmail.com'),
('NCC003', N'Vinamilk', N'TP.HCM', N'vinamilk@gmail.com'),
('NCC004', N'Acecook', N'Bình Dương', N'acecook@gmail.com'),
('NCC005', N'Tường An', N'TP.HCM', N'tuongan@gmail.com');
select * from dbo.Nhacungcap

INSERT INTO Hoadon(MaHD, Ngayban, Tongtien, PTTT, MaKH, MaNV)
VALUES
('HD001', '2025-08-01', 150000, N'Tiền mặt', 'KH001', 'NV002'),
('HD002', '2025-08-02', 230000, N'Chuyển khoản', 'KH005', 'NV004'),
('HD003', '2025-08-03', 125000, N'Tiền mặt', 'KH010', 'NV009'),
('HD004', '2025-08-04', 98000, N'Tiền mặt', 'KH015', 'NV018'),
('HD005', '2025-08-05', 300000, N'Chuyển khoản', 'KH020', 'NV012');
select * from dbo.Hoadon

INSERT INTO Chitiet_Hoadon(MaH, MaHD, SL_hangban, Dongia_ban, Magiamgia)
VALUES
('HH001','HD001',2,25000,NULL),
('HH004','HD002',3,32000,NULL),
('HH005','HD003',5,4000,NULL),
('HH010','HD004',2,30000,NULL),
('HH020','HD005',10,10000,NULL);
select * from dbo.Chitiet_Hoadon

INSERT INTO Phieu_yeucau_Xuatkho(MaYC, Lydo, MaNV)
VALUES
('YC001', N'Bổ sung hàng hóa quầy 1', 'NV003'),
('YC002', N'Bổ sung hàng hóa quầy 2', 'NV007'),
('YC003', N'Bổ sung hàng hóa quầy 3', 'NV010'),
('YC004', N'Bổ sung hàng hóa quầy 4', 'NV013'),
('YC005', N'Bổ sung hàng hóa quầy 5', 'NV017');
select * from dbo.Phieu_yeucau_Xuatkho

INSERT INTO Chitiet_PYCXK(MaH, MaYC, SL_hangyeucau)
VALUES
('HH001','YC001',20),
('HH004','YC002',15),
('HH005','YC003',30),
('HH010','YC004',10),
('HH020','YC005',50);
select * from dbo.Chitiet_PYCXK

INSERT INTO Phieukiemke(MaPKK, NgayKK, GhichuKK, MaNV)
VALUES
('PKK001', '2024-08-01', N'Kiểm kê định kỳ', 'NV003'),
('PKK002', '2024-09-02', N'Kiểm kê định kỳ', 'NV007'),
('PKK003', '2024-10-03', N'Kiểm kê hàng hóa bị hư hỏng', 'NV010'),
('PKK004', '2024-10-24', N'Kiểm kê hàng gần hết hạn', 'NV013'),
('PKK005', '2024-10-30', N'Kiểm kê hàng mới nhập', 'NV017');
select * from dbo.Phieukiemke

INSERT INTO Chitiet_PKK(MaH, MaPKK, SL_hangKK)
VALUES
('HH001','PKK001',100),
('HH004','PKK002',50),
('HH005','PKK003',200),
('HH010','PKK004',80),
('HH020','PKK005',300);
select * from dbo.Chitiet_PKK

INSERT INTO Phieuxuat(MaPX, Ngayxuat, GhichuPX, MaNV)
VALUES
('PX001','2023-08-01', N'Xuất hàng cho quầy 1','NV003'),
('PX002','2024-08-10', N'Xuất hàng cho quầy 2','NV007'),
('PX003','2024-08-30', N'Xuất hàng cho quầy 3','NV010'),
('PX004','2024-09-14', N'Xuất hàng cho quầy 4','NV013'),
('PX005','2024-09-25', N'Xuất hàng cho quầy 5','NV017');
select * from dbo.Phieuxuat

INSERT INTO Chitiet_PX(MaH, MaPX, SL_hangxuat, Dongiaxuat)
VALUES
('HH001','PX001',20,25000),
('HH004','PX002',15,32000),
('HH005','PX003',30,4000),
('HH010','PX004',10,30000),
('HH020','PX005',50,10000);
select * from dbo.Chitiet_PX

INSERT INTO Phieunhap(MaPN, Ngaynhap, Tongtiennhap, GhichuPN, MaNCC, MaNV) 
VALUES
('PN001','2025-08-01',500000, N'Nhập hàng từ NCC001','NCC001','NV005'),
('PN002','2025-08-02',450000, N'Nhập hàng từ NCC002','NCC002','NV006'),
('PN003','2025-08-03',600000, N'Nhập hàng từ NCC003','NCC003','NV015'),
('PN004','2025-08-04',300000, N'Nhập hàng từ NCC004','NCC004','NV016'),
('PN005','2025-08-05',700000, N'Nhập hàng từ NCC005','NCC005','NV019');
select * from dbo.Phieunhap

INSERT INTO Chitiet_PN(MaH, MaPN, SL_hangnhap, Dongianhap)
VALUES
('HH001','PN001',50,25000),
('HH004','PN002',30,32000),
('HH005','PN003',100,4000),
('HH010','PN004',40,30000),
('HH020','PN005',70,10000);
select * from dbo.Chitiet_PN
