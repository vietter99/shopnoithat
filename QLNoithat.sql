use master
Drop Database QLNoithat
----------
create database QLNOITHAT
GO
use QLNOITHAT
GO
CREATE TABLE KHACHHANG
(
	MaKH INT IDENTITY(1,1),
	HoTen nVarchar(50) NOT NULL,
	Taikhoan Varchar(50) UNIQUE,
	Matkhau Varchar(50) NOT NULL,
	Email Varchar(100) UNIQUE,
	DiachiKH nVarchar(200),
	DienthoaiKH Varchar(50),	
	Ngaysinh DATETIME
	CONSTRAINT PK_Khachhang PRIMARY KEY(MaKH)
)
GO
Create Table LOAISANPHAM
(
	MaLoaiSP int Identity(1,1),
	TenLoaiSP nvarchar(50) NOT NULL,
	CONSTRAINT PK_ChuDe PRIMARY KEY(MaLoaiSP)
)
GO
CREATE TABLE SANPHAM
(
	Masp INT IDENTITY(1,1),
	Tensp NVARCHAR(100) NOT NULL,
	Giaban Decimal(18,0) CHECK (Giaban>=0),
	Mota NVarchar(Max),
	Anhbia VARCHAR(50),
	Ngaycapnhat DATETIME,
	Soluongton INT,
	MaLoaiSP INT,
	CONSTRAINT PK_Sach PRIMARY KEY(Masp),
	CONSTRAINT FK_Chude FOREIGN KEY(MaLoaiSP) REFERENCES LOAISANPHAM(MaLoaiSP),
)
GO
CREATE TABLE DONDATHANG
(
	MaDonHang INT IDENTITY(1,1),
	Dathanhtoan bit,
	Tinhtranggiaohang  bit,
	Ngaydat Datetime,
	HoTen nVarchar(50) NOT NULL,
	DiachiKH nVarchar(200),
	DienthoaiKH Varchar(50),	
	GhiChu NVarchar(Max),
	CONSTRAINT PK_DonDatHang PRIMARY KEY(MaDonHang)
)
GO
CREATE TABLE CHITIETDONTHANG
(
	MaDonHang INT,
	Masp INT,
	Soluong Int Check(Soluong>0),
	Dongia Decimal(18,0) Check(Dongia>=0),	
	CONSTRAINT PK_CTDatHang PRIMARY KEY(MaDonHang,Masp),
)
GO
CREATE TABLE ADMIN
(
	UserAdmin varchar(30) primary key,
	PassAdmin varchar(30) not null,
	Hoten nVarchar(50),
)
GO
/****** LOAISANPHAM******/
INSERT LOAISANPHAM(TenLoaiSP) VALUES (N'Ghế Sofa')
INSERT LOAISANPHAM(TenLoaiSP) VALUES (N'Bàn ăn')
INSERT LOAISANPHAM(TenLoaiSP) VALUES (N'Ghế ăn')
INSERT LOAISANPHAM(TenLoaiSP) VALUES (N'Đèn phòng khách')

/****** KHACHHANG ******/
INSERT KHACHHANG (Hoten, DiachiKH, DienthoaiKH, Taikhoan, Matkhau, Ngaysinh, Email)
VALUES (N'Dương Thành Phết', N'12 Trần Huy Liệu', N'0918062755', N'thayphet.net', N'123456', '08/20/1976', 'phetcm@hgmail.com')
INSERT KHACHHANG (Hoten, DiachiKH, DienthoaiKH, Taikhoan, Matkhau, Ngaysinh, Email) 
VALUES (N'Nguyễn Tiến Luân', N'21 Quận 6', N'0917654310', N'thang', N'123456', '10/15/1990', N'ntluan@hcmuns.edu.vn')
INSERT KHACHHANG (Hoten, DiachiKH, DienthoaiKH, Taikhoan, Matkhau, Ngaysinh, Email) 
VALUES (N'Đặng Quốc Hòa', N'32 Sư Vạn Hạnh', N'098713245', N'dqhoa', N'hoa', '05/21/1991', N'dqhoa@hcmuns.edu.vn')
INSERT KHACHHANG (Hoten, DiachiKH, DienthoaiKH, Taikhoan, Matkhau, Ngaysinh, Email) 
VALUES (N'Ngô Ngọc Ngân', N'12 Khu chung cư', N'0918544699', N'nnngan', N'ngan', '10/12/1986', N'nnngan@hcmuns.edu.vn')

/******SANPHAM ******/
INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Sofa giường BR', 1400000, N'Ghế Sofa ngày nay là một vật dụng nội thất không thể thiếu trong không gian phòng khách hiện đại. Với kiểu dáng và màu sắc phong phú, ghế sofa Klosso là lựa chọn hàng đầu cho một không gian nội thất phòng khách đẹp. Vì thế, việc chọn sofa sao cho hài hòa với bố cục diện tích của phòng và làm đẹp không gian trong phòng là không hề đơn giản. Sofa thư giãn Klosso mang lại cảm giác thư thái và thoải mái cho bạn sau một ngày làm việc mệt nhọc. Sofa thư giãn Klosso có thể đặt ở rất nhiều vị trí: phòng khách, phòng đọc sách, thư giãn xem tivi, ...', 'sofa1.jpg',1,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Sofa giường GIFT', 4490000, N'Ghế Sofa ngày nay là một vật dụng nội thất không thể thiếu trong không gian phòng khách hiện đại. Với kiểu dáng và màu sắc phong phú, ghế sofa Klosso là lựa chọn hàng đầu cho một không gian nội thất phòng khách đẹp. Vì thế, việc chọn sofa sao cho hài hòa với bố cục diện tích của phòng và làm đẹp không gian trong phòng là không hề đơn giản. Sofa thư giãn Klosso mang lại cảm giác thư thái và thoải mái cho bạn sau một ngày làm việc mệt nhọc. Sofa thư giãn Klosso có thể đặt ở rất nhiều vị trí: phòng khách, phòng đọc sách, thư giãn xem tivi, ...','sofa2.jpg',1,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Sofa giường Xám', 6490000, N'Ghế Sofa ngày nay là một vật dụng nội thất không thể thiếu trong không gian phòng khách hiện đại. Với kiểu dáng và màu sắc phong phú, ghế sofa Klosso là lựa chọn hàng đầu cho một không gian nội thất phòng khách đẹp. Vì thế, việc chọn sofa sao cho hài hòa với bố cục diện tích của phòng và làm đẹp không gian trong phòng là không hề đơn giản. Sofa thư giãn Klosso mang lại cảm giác thư thái và thoải mái cho bạn sau một ngày làm việc mệt nhọc. Sofa thư giãn Klosso có thể đặt ở rất nhiều vị trí: phòng khách, phòng đọc sách, thư giãn xem tivi, ...','sofa3.jpg',1,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton)
VALUES (N'Sofa giường', 7490000, N'Ghế Sofa ngày nay là một vật dụng nội thất không thể thiếu trong không gian phòng khách hiện đại. Với kiểu dáng và màu sắc phong phú, ghế sofa Klosso là lựa chọn hàng đầu cho một không gian nội thất phòng khách đẹp. Vì thế, việc chọn sofa sao cho hài hòa với bố cục diện tích của phòng và làm đẹp không gian trong phòng là không hề đơn giản. Sofa thư giãn Klosso mang lại cảm giác thư thái và thoải mái cho bạn sau một ngày làm việc mệt nhọc. Sofa thư giãn Klosso có thể đặt ở rất nhiều vị trí: phòng khách, phòng đọc sách, thư giãn xem tivi, ...','sofa4.jpg',1,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Sofa thư giãn', 13990000, N'Ghế Sofa ngày nay là một vật dụng nội thất không thể thiếu trong không gian phòng khách hiện đại. Với kiểu dáng và màu sắc phong phú, ghế sofa Klosso là lựa chọn hàng đầu cho một không gian nội thất phòng khách đẹp. Vì thế, việc chọn sofa sao cho hài hòa với bố cục diện tích của phòng và làm đẹp không gian trong phòng là không hề đơn giản. Sofa thư giãn Klosso mang lại cảm giác thư thái và thoải mái cho bạn sau một ngày làm việc mệt nhọc. Sofa thư giãn Klosso có thể đặt ở rất nhiều vị trí: phòng khách, phòng đọc sách, thư giãn xem tivi, ...','sofa5.png',1,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Sofa thư giãn điện Bron', 25000000, N'Ghế Sofa ngày nay là một vật dụng nội thất không thể thiếu trong không gian phòng khách hiện đại. Với kiểu dáng và màu sắc phong phú, ghế sofa Klosso là lựa chọn hàng đầu cho một không gian nội thất phòng khách đẹp. Vì thế, việc chọn sofa sao cho hài hòa với bố cục diện tích của phòng và làm đẹp không gian trong phòng là không hề đơn giản. Sofa thư giãn Klosso mang lại cảm giác thư thái và thoải mái cho bạn sau một ngày làm việc mệt nhọc. Sofa thư giãn Klosso có thể đặt ở rất nhiều vị trí: phòng khách, phòng đọc sách, thư giãn xem tivi, ...','sofa6.jpg',1,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Bàn tròn Diamon', 700000, N'Bàn thiết kế sang trọng với các đường cong uống lượng hoàn mỹ. Bề mặt gổ được phủ 1 lớp chống thấm nước , mặt gổ màu nâu sang trọng , khung sắt dầy , chắc chắn .','banan1.png',2,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton)
VALUES (N'Bàn ăn mở rộng Diamon', 2000000, N'Bàn thiết kế sang trọng với các đường cong uống lượng hoàn mỹ. Bề mặt gổ được phủ 1 lớp chống thấm nước , mặt gổ màu nâu sang trọng , khung sắt dầy , chắc chắn .','banan2.png',2,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Bàn ăn hình tròn Vintage', 2000000, N'Bàn thiết kế sang trọng với các đường cong uống lượng hoàn mỹ. Bề mặt gổ được phủ 1 lớp chống thấm nước , mặt gổ màu nâu sang trọng , khung sắt dầy , chắc chắn .','banan3.png',2,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Bàn trà', 1300000, N'Bàn thiết kế sang trọng với các đường cong uống lượng hoàn mỹ. Bề mặt gổ được phủ 1 lớp chống thấm nước , mặt gổ màu nâu sang trọng , khung sắt dầy , chắc chắn .','banan4.png',2,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Bàn cà phê tròn Tolix', 1200000, N'Bàn thiết kế sang trọng với các đường cong uống lượng hoàn mỹ. Bề mặt gổ được phủ 1 lớp chống thấm nước , mặt gổ màu nâu sang trọng , khung sắt dầy , chắc chắn .','banan5.png',2,'10/25/2020', 30)
	
INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Bàn cà phê Invista', 1300000, N'Bàn thiết kế sang trọng với các đường cong uống lượng hoàn mỹ. Bề mặt gổ được phủ 1 lớp chống thấm nước , mặt gổ màu nâu sang trọng , khung sắt dầy , chắc chắn .','banan6.png',2,'10/25/2020', 30)
		
INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Ghế thư giãn Viking', 2000000, N'Ghế thư giãn Viking sử dụng từ 5-7 năm trong nhà, 3-4 năm ở ban công có mái che. Ngoài việc mang đến trải nghiệm thư giãn mỗi khi đọc sách, nghe nhạc, chiếc ghế còn trở thành bạn đồng hành của các mẹ bầu, bà mẹ chăm con nhỏ, giảm thiểu đau lưng và tác động bế con lên cột sống','ghean1.png',3,'10/25/2020', 30)
							
INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Ghế bành Tolix', 1500000, N'Ghế thư giãn Viking sử dụng từ 5-7 năm trong nhà, 3-4 năm ở ban công có mái che. Ngoài việc mang đến trải nghiệm thư giãn mỗi khi đọc sách, nghe nhạc, chiếc ghế còn trở thành bạn đồng hành của các mẹ bầu, bà mẹ chăm con nhỏ, giảm thiểu đau lưng và tác động bế con lên cột sống','ghean2.png',3,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton)
VALUES (N'Ghế Tựa Tolix', 800000, N'Ghế thư giãn Viking sử dụng từ 5-7 năm trong nhà, 3-4 năm ở ban công có mái che. Ngoài việc mang đến trải nghiệm thư giãn mỗi khi đọc sách, nghe nhạc, chiếc ghế còn trở thành bạn đồng hành của các mẹ bầu, bà mẹ chăm con nhỏ, giảm thiểu đau lưng và tác động bế con lên cột sống','ghean3.png',3,'10/25/2020', 30)																

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Ghế tựa Vintage', 800000, N'Ghế thư giãn Viking sử dụng từ 5-7 năm trong nhà, 3-4 năm ở ban công có mái che. Ngoài việc mang đến trải nghiệm thư giãn mỗi khi đọc sách, nghe nhạc, chiếc ghế còn trở thành bạn đồng hành của các mẹ bầu, bà mẹ chăm con nhỏ, giảm thiểu đau lưng và tác động bế con lên cột sống','ghean4.png',3,'10/25/2020', 30)	

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Ghế tựa Vintage classic', 200000, N'Ghế thư giãn Viking sử dụng từ 5-7 năm trong nhà, 3-4 năm ở ban công có mái che. Ngoài việc mang đến trải nghiệm thư giãn mỗi khi đọc sách, nghe nhạc, chiếc ghế còn trở thành bạn đồng hành của các mẹ bầu, bà mẹ chăm con nhỏ, giảm thiểu đau lưng và tác động bế con lên cột sống','ghean5.png',3,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Ghế tựa khung thép', 600000, N'Ghế thư giãn Viking sử dụng từ 5-7 năm trong nhà, 3-4 năm ở ban công có mái che. Ngoài việc mang đến trải nghiệm thư giãn mỗi khi đọc sách, nghe nhạc, chiếc ghế còn trở thành bạn đồng hành của các mẹ bầu, bà mẹ chăm con nhỏ, giảm thiểu đau lưng và tác động bế con lên cột sống','ghean6.png',3,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Đèn treo tường J5K7', 2000000, N'Đèn tường đồng trang trí mang phong cách châu âu, cổ điển, tân cổ điển trong thiết kế nội thất luôn được xem là một trong những vẻ đẹp sang trọng và đẳng cấp.','den1.png',4,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Đèn thả led trang trí QW2H', 2500000, N'Đèn tường đồng trang trí mang phong cách châu âu, cổ điển, tân cổ điển trong thiết kế nội thất luôn được xem là một trong những vẻ đẹp sang trọng và đẳng cấp.','den2.png',4,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton)
VALUES (N'Đèn treo tường J5K4', 500000, N'Đèn tường đồng trang trí mang phong cách châu âu, cổ điển, tân cổ điển trong thiết kế nội thất luôn được xem là một trong những vẻ đẹp sang trọng và đẳng cấp.','den3.png',4,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Đèn thả trang trí ADH1', 1000000, N'Đèn tường đồng trang trí mang phong cách châu âu, cổ điển, tân cổ điển trong thiết kế nội thất luôn được xem là một trong những vẻ đẹp sang trọng và đẳng cấp.','den4.png',4,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Đèn treo tường H1J5', 2000000, N'Đèn tường đồng trang trí mang phong cách châu âu, cổ điển, tân cổ điển trong thiết kế nội thất luôn được xem là một trong những vẻ đẹp sang trọng và đẳng cấp.','den5.png',4,'10/25/2020', 30)

INSERT SANPHAM(Tensp, Giaban, Mota, Anhbia,MaLoaiSP, Ngaycapnhat, Soluongton) 
VALUES (N'Đèn thả led trang trí A1HD', 200000, N'Đèn tường đồng trang trí mang phong cách châu âu, cổ điển, tân cổ điển trong thiết kế nội thất luôn được xem là một trong những vẻ đẹp sang trọng và đẳng cấp.','den6.png',4,'10/25/2020', 30)

select * from SANPHAM

/****** DONDATHANG ******/


/******CHITIETDONHANG ******/
INSERT CHITIETDONTHANG (MaDonHang,Masp,SOLUONG, Dongia) VALUES (1, 19, 1, 25000)
INSERT CHITIETDONTHANG (MaDonHang,Masp,SOLUONG, Dongia) VALUES (1, 15, 3, 50000)
INSERT CHITIETDONTHANG (MaDonHang,Masp,SOLUONG, Dongia) VALUES (1, 14, 1, 25000)
INSERT CHITIETDONTHANG (MaDonHang,Masp,SOLUONG, Dongia) VALUES (2, 5, 3, 10000)
INSERT CHITIETDONTHANG (MaDonHang,Masp,SOLUONG, Dongia) VALUES (2, 9, 1, 15000)
INSERT CHITIETDONTHANG (MaDonHang,Masp,SOLUONG, Dongia) VALUES (2, 15, 3, 150000)
INSERT CHITIETDONTHANG (MaDonHang,Masp,SOLUONG, Dongia) VALUES (3, 9, 1, 25000)
INSERT CHITIETDONTHANG (MaDonHang,Masp,SOLUONG, Dongia) VALUES (3, 10, 3,70000)

/******ADMIN ******/
INSERT ADMIN (UserAdmin,PassAdmin,Hoten) VALUES (N'Admin',N'Admin123',N'Quản lý website')
