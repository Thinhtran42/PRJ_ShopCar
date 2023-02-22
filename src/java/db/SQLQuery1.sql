use master
go

drop  database shopcar
go
-- Tạo database ShopOnline_Demo
create database shopcar
go
use shopcar
go
-- 1: Tạo Table [Accounts] chứa tài khoản thành viên được phép sử dụng các trang quản trị ----
create table TaiKhoan
(
	taiKhoan varchar(20) primary key not null,
	matKhau varchar(20) not null,
	hoDem nvarchar(50) null,
	tenTV nvarchar(30) not null,
	ngaysinh datetime ,
	gioiTinh bit default 1,
	soDT nvarchar(20),
	email nvarchar(50),
	diaChi nvarchar(250),
	trangThai bit default 0,
	vaitro ntext,
	ghiChu ntext

)
go

-- 2: Tạo Table [Customers] chứa Thông tin khách hàng  ---------------------------------------
create table KhachHang
(
	maKH varchar(15) primary key not null,
	tenKH nvarchar(50) not null,
	soDT varchar(20) ,
	email varchar(50),
	diaChi nvarchar(250),
	ngaySinh datetime ,
	gioiTinh bit default 1,
	ghiChu ntext
)
go

-- 3: Tạo Table [Articles] chứa thông tin về các bài viết phục vụ cho quảng bá sản phẩm, ------
--    xu hướng mua sắm hiện nay của người tiêu dùng , ...             ------------------------- 
create table BaiViet
(
	maBV varchar(10) primary key not null,
	tenBV nvarchar(250) not null,
	hinhDD varchar(max),
	ndTomTat nvarchar(2000),
	ngayDang datetime ,
	loaiTin nvarchar(30),
	noiDung nvarchar(4000),
	taiKhoan varchar(20) not null ,
	daDuyet bit default 0,
	foreign key (taiKhoan) references taiKhoan(taiKhoan) on update cascade 
)
go
-- 4: Tạo Table [LoaiSP] chứa thông tin loại sản phẩm, ngành hàng -----------------------------
create table LoaiSP
(
	maLoai int primary key not null identity,
	tenLoai nvarchar(88) not null,
	ghiChu ntext default ''
)
go
-- 4: Tạo Table [Products] chứa thông tin của sản phẩm mà shop kinh doanh online --------------
create table SanPham
(
	maSP varchar(15) primary key not null,
	tenSP nvarchar(500) not NULL,
	hinhDD varchar(max) DEFAULT '',
	ndTomTat nvarchar(2000) DEFAULT '',
	ngayDang DATETIME DEFAULT CURRENT_TIMESTAMP,
	maLoai int not null references LoaiSP(maLoai),
	noiDung nvarchar(4000) DEFAULT '',
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade,
	dvt nvarchar(32) default N'Chiếc',
	daDuyet bit default 0,
	giaBan nvarchar(20),
	giamGia nvarchar(20),
	nhaSanXuat nvarchar(168) default ''
)
go

-- 5: Tạo Table [Orders] chứa danh sách đơn hàng mà khách đã đặt mua thông qua web ------------
create table DonHang
(
	soDH varchar(10) primary key not null ,
	maKH varchar(15) not null foreign key references khachHang(maKH),
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade ,
	ngayDat datetime,
	daKichHoat bit default 1,
	ngayGH datetime,
	diaChiGH nvarchar(250),
	ghiChu ntext
)
go	

-- 6: Tạo Table [OrderDetails] chứa thông tin chi tiết của các đơn hàng ---
--    mà khách đã đặt mua với các mặt hàng cùng số lượng đã chọn ---------- 
create table CtDonHang	
(
	soDH varchar(10) not null foreign key references donHang(soDH),
	maSP varchar(15) not null foreign key references sanPham(maSP),
	soLuong int,
	giaBan nvarchar(20),
	giamGia nvarchar(20),
	PRIMARY KEY (soDH, maSP)
)
go


/*========================== Nhập dữ liệu mẫu ==============================*/

-- YC 1: Nhập thông tin tài khoản, tối thiểu 5 thành viên sẽ dùng để làm việc với các trang: Administrative pages
insert into taiKhoan
values('host','123',N'Trần Gia','Huy',02/11/2003,1,0934721180,'giahuyt12@gmail.com','129/45 TL15, Q12, TP.HCM',1,'','')
insert into taiKhoan
values('admin','123',N'Mai Thế',N'Dân',06/12/2003,1,0961326956,'mtdan@gmail.com','472 CMT8, P.11,Q3, TP.HCM',1,'','')
GO

insert into LoaiSP(tenLoai) values('Toyota')
insert into LoaiSP(tenLoai) values('Chevrolet')
insert into LoaiSP(tenLoai) values('KIA')
insert into LoaiSP(tenLoai) values('Ford')
insert into LoaiSP(tenLoai) values('Vinfast')
insert into LoaiSP(tenLoai) values('Mercedes')
insert into LoaiSP(tenLoai) values('Audi')
insert into LoaiSP(tenLoai) values('Hyundai')
insert into LoaiSP(tenLoai) values('Nissan')
insert into LoaiSP(tenLoai) values('Peugeot')
insert into LoaiSP(tenLoai) values('Mazda')
go

-- YC3: Nhập thông tin bài viết, Tối thiểu 10 bài viết thuộc loại: giới thiệu sản phẩm, khuyến mãi, quảng cáo, ... 
--      liên quan đến sản phẩm mà bạn dự định kinh doanh trong đồ án sẽ thực hiện
insert into BaiViet(maBV, tenBV, hinhDD, ndTomTat, loaiTin, ngayDang, noiDung, taiKhoan, daDuyet)
			values('BV01',N'Ford hé lộ SUV điện hoàn toàn mới thế chỗ Fiesta: Ra mắt đầu năm sau, đấu Toyota bZ4X',
				   '/materials/images/Article/suv-dien-ford-sap-ra-mat.png',N'Những thông tin về mẫu SUV điện hoàn toàn mới từ Ford thế chỗ Fiesta trên thị trường đã bắt
				   đầu được thương hiệu Mỹ công bố.','GT','2022/12/19',N'Giám đốc phân nhánh xe điện Model E của Ford
				   là Martin Sander đã hé lộ một vài thông tin mới xoay quanh dòng xe điện sắp được Ford ra mắt vào 
				   năm sau. Nằm ở phân khúc SUV cỡ trung, mẫu xe mới đã được xác nhận sự tồn tại vào cuối năm 2021. 
				   Tuy vậy, tới bây giờ thời điểm xe ra mắt mới được xác nhận là vào tháng 3-2023.Teaser được Ford
				   công bố cho xe chỉ hé lộ vóc dáng tổng thể, nhưng hãng xác nhận dòng tên mới sẽ mang bước tiến lớn
				   trong thiết kế, ít nhất là so với đội hình hãng hiện có ở châu Âu. Mâm khí động học, cụm đèn pha dày
				   dặn hay cản trước tương phản trên - dưới là một số điểm nhấn có thể xuất hiện. Kích thước SUV điện
				   Ford sẽ ngang hàng Toyota bZ4X, Nissan Ariya hay Volvo XC40 Recharge trong phân khúc xe điện. Khung
				   gầm xe sử dụng là loại MEB mượn từ đối tác Volkswagen.','admin',1);
insert into BaiViet(maBV, tenBV, hinhDD, ndTomTat, loaiTin, ngayDang, noiDung, taiKhoan, daDuyet)
			values('BV02',N'Tàu chở 999 xe VinFast VF 8 đã tới Mỹ: Hình ảnh qua cầu Cổng Vàng gây sốt',
				   '/materials/images/Article/tau-cho-999-xe-vinfast-di-qua-cau-cong-vang.png',N'Sau 20 ngày lênh đênh trên biển, tàu chở lô 999 xe VinFast VF 8 đã tới Mỹ. Xe sẽ đến tay khách
				   hàng ngay trong tháng này.','TT','2022/12/18',N'Chiều 17/12/2022 (giờ PST, tức sáng sớm 18/12/2022
				   giờ Việt Nam), con tàu chở 999 xe VinFast VF 8 đã tiến vào khu vực Vịnh San Francisco, đi qua cầu
				   Cổng Vàng biểu tượng và chuẩn bị cập bến California (Mỹ). Tàu mất 20 ngày để tới đây từ Hải Phòng 
				   (Việt Nam). Sau khi hoàn tất cả thủ tục cần thiết, dự kiến những chiếc VinFast VF 8 đầu tiên sẽ sẵn
				   sàng bàn giao cho khách hàng Mỹ ngay trong tháng 12.Để vận chuyển lô xe này sang Mỹ, VinFast đã thuê
				   con tàu Silver Queen của Panama. Con tàu dài khoảng 183 mét, có tải trọng hơn 11.000 tấn, có thể chở
				   khoảng 4.500 ô tô cùng lúc. Thân tàu sơn logo VinFast.999 xe VF 8 chỉ là một phần rất nhỏ trong số 
				   khoảng 65.000 đơn đặt hàng hai mẫu xe điện VF 8 và VF 9 trên toàn cầu. Sau Mỹ, thị trường tiếp theo
				   nhận xe VF 8 là Canada. Theo kế hoạch, VF 9 sẽ được bàn giao sau, từ quý I/2023 cho cả thị trường Việt Nam và quốc tế.','admin',1);
insert into BaiViet(maBV, tenBV, hinhDD, ndTomTat, loaiTin, ngayDang, noiDung, taiKhoan, daDuyet)
			values('BV03',N'Kia Stonic - Xe gầm cao giàu trang bị, khung gầm Hyundai Kona, kích cỡ tương đương Seltos',
				   '/materials/images/Article/gioi-thieu-kia-stonic-quantum_1.png',N'Kia Stonic Quantum sẽ mở bán vào quý 1-2023.','GT','2022/12/17',N'Kia Stonic ra mắt lần đầu vào
				   năm 2017 đảm nhiệm vị trí thấp nhất thương hiệu Hàn Quốc tại một số khu vực. Kia Stonic - dòng SUV cỡ
				   nhỏ - đang là xe thấp nhất đội hình thương hiệu chủ quản tại nhiều nơi chẳng hạn châu Âu, khi bước sang
				   năm 2023, sẽ được bổ sung một phiên bản đặc biệt mới. Có tên gọi chính thức là Kia Stonic Quantum, phiên
				   bản này sẽ bắt đầu được mở bán vào quý 1 năm sau. Bản này sẽ thế chỗ Stonic GT Line trở thành bản cao nhì
				   đội hình dòng SUV cỡ nhỏ, chỉ sau Stonic 3. Tương tự mẫu xe bị thế chân, Kia Stonic Quantum chọn triết lý
				   thể thao làm chủ đạo. Ngoại thất Kia Stonic Quantum sử dụng giao diện 2 tông màu với bản mặc định lấy nền
				   xám tô điểm trần, cột A và nắp gương bên vàng. Nội thất xe tiếp tục sử dụng cách phối màu trên khi trang bị
				   vải bọc đen đi kèm ghế bọc da giả tông xám. Giá khởi điểm tham khảo xe là 26.400 USD.','admin',1);

-- Toyota -------------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('TYTCR', N'Toyota Camry', 'https://www.autosbangla.com/images/toyota/toyota-camry-img3.jpg',
			          N'Toyota Camry được mệnh danh là “Vua của các dòng xe sedan”, là chiếc xe 
					  bình dân thứ 2 tại Việt Nam được trang bị động cơ Hybrid và Toyota đang
					  là hãng xe tiên phong mang đến phương tiện di chuyển xanh, thân thiện với
					  môi trường','admin','1.105.000.000','10%',1, N'Toyota',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('TYTFT', N'Toyota Fortuner', 'https://www.carshowroom.com.au/media/21472131/2017-toyota-fortuner-crusade-29.jpg',
			          N'Được trang bị các công nghệ an toàn hiện đại nhất hiện tại, Toyota Fortuner vẫn
					  sẽ tiếp tục giữ vững ngôi vương trong phân khúc xe SUV 7 chỗ của mình', 'admin',
					  '1.200.000.000','15%',1,N'Toyota', N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('TYTINV', N'Toyota Innova', 'http://s2.paultan.org/image/2016/12/Toyota-Innova-2.0-G-ext-6.jpg',
			          N'Toyota Innova chính là một trong những dòng xe MPV thành công nhất, đảm
					  đương hoàn hảo sứ mệnh thay thế cho mẫu xe Zace "huyền thoại"', 'admin',
					  '870.000.000','12%',1,N'Toyota',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('TYTVI', N'Toyota Vios', 'https://s2.paultan.org/image/2016/03/Toyota_Vios-1-1200x800.jpg',
			          N'Toyota Vios như là một biểu tượng của sự bền bỉ, yếu tố thương hiệu, 
					  giá trị bán lại và vẫn vững vàng với vai trò là thành trì quan trọng 
					  bậc nhất của liên doanh Nhật', 'admin','592.000.000','15%',1,N'Toyota', N'Bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('TYTCRL', N'Toyota Corolla Altis', 'https://i.ytimg.com/vi/B2g4iZwbDg4/maxresdefault.jpg',
			          N'Với tiêu chí ‘Đậm chất chơi, ngời chuẩn mực’ Toyota Corolla Altis
					  2022 hướng đến sự năng động, khỏe khoắn mà vẫn đảm bảo sự tiện nghi
					  cùng khả năng vận hành êm ái.', 'admin','765.000.000','10%',1,N'Toyota', N'Bộ');
go


-- Chevrolet -------------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CVLAV', N'Chevrolet Aveo', 'https://auto.ironhorse.ru/wp-content/uploads/2011/05/aveo-t250-3d.jpg',
			          N'Aveo có giá khá mềm, là sự lựa chọn có phần ưu tiên hơn đối với các khách hàng
					  có mục đích mua xe để phục vụ nhu cầu kinh doanh hay cả những khách hàng muốn có
					  sự tiết kiệm chi phí hơn và khả năng bền bỉ lâu dài phục vụ cho xe gia đình',
					  'admin','495.000.000','0%',2,N'Chevrolet',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CVLCLRD', N'Chevrolet Colorado', 'https://pictures.topspeed.com/IMG/jpg/201709/chevrolet-silverado--21.jpg',
			          N'Chevrolet Colorado là dòng bán tải đến từ Mỹ với thiết kế năng động, khoẻ khoắn,
					  bền bỉ chắc chắn sẽ làm bất ngờ về khả năng di chuyển rất linh hoạt', 'admin',
					  '953.000.000','0%',2,N'Chevrolet',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CVLCRZ', N'Chevrolet Cruze', 'https://tse3.mm.bing.net/th?id=OIP.sZzhJ_vRmnuUSZxtTDhpMwHaE8&pid=Api&P=0',
			          N'Chevrolet Cruze 2022 hiện đang là một trong những “ông hoàng bất bại” về số
					  lượng xe bán ra của dòng xe hạng C trên thị trường xe hiện nay.','admin',
					  '599.000.000','0%',2,N'Chevrolet',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CVLSPA', N'Chevrolet Spark', 'https://www.carscoops.com/wp-content/uploads/2018/04/2019-chevrolet-spark-0.jpg',
			          N'Chevrolet Spark từ lâu đã được đánh giá là dòng xe Mini car 5 cửa tiện nghi với
					  giá thành rẻ. Xe được xem là cái tên nổi bật bên cạnh các tên tuổi khác trong cùng
					  phân khúc xe gia đình nhỏ gọn.', 'admin','299.000.000','0%',2,N'Chevrolet',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt)
				values('CVLTBZ', N'Chevrolet Trailblazer', 'https://www.unnamedproject.com/wp-content/uploads/Trailblazer_0317.jpg',
			          N'Với phong cách thiết kế thể thao nhưng không kém phần sang trọng, động cơ Duramax mạnh mẽ đúng
					  bản chất xe Mỹ, không gian nội thất rộng rãi với 7 ghế ngồi và công nghệ an toàn được tích hợp
					  khá đầy đủ, là những ưu điểm nổi bật mà Chevrolet Trailblazer mang lại', 'admin','885.000.000','0%',2,
					  N'Chevrolet', N'Chiếc');
go

-- KIA -------------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('KIACNV', N'KIA Carnival', 'https://images.hgmsites.net/hug/2022-kia-carnival_100803140_h.jpg',
			          N'Kia Carnival 2022 là một mẫu xe đa dụng cực kỳ đáng mua trong tầm giá. Thiết kế
					  đẹp mắt và hiện đại cùng không gian nội thất rộng rãi, tiện nghi vượt tầm phân khúc là những điểm
					  có thể thuyết phục cả những khách hàng khó tính nhất', 'admin','1.199.000.000','5%',3,N'KIA',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('KIACRT', N'KIA Cerato', 'https://content.api.news/v3/images/bin/bbfa5dc42c0d370ad36590411203bf74',
			          N'KIA Cerato luôn nằm trong nhóm các mẫu xe bán chạy nhất ở Việt
					  Nam. Ngoài giá rẻ nhất trong cùng phân khúc thì KIA Cerato sở hữu
					  khá nhiều ưu điểm nổi trội.', 'admin','559.000.000','0%',3,N'KIA',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('KIAMN', N'KIA Morning', 'https://drive.gianhangvn.com/image/kia-morning-gt-line-1659485j25995.jpg',
			          N'Kia Morning là một trong những xe nổi bật nhất phân khúc hatchback hạng A,
					  thu hút bởi thiết kế trẻ trung đi cùng với hệ thống trang bị hiện đại',
					  'admin','439.000.000','10%',3,N'KIA', N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('KIAST', N'KIA Seltos', 'https://img-ik.cars.co.za/images/2020/2/Kia-Seltos/tr:n-news_1200x/Kia-Seltos-7.jpg',
			          N'Ngoại hình trẻ trung, nội thất rộng rãi, trang bị dẫn đầu phân khúc,
					  giá xe hợp lý… ngay khi về Việt Nam, Kia Seltos đã nhanh chóng khuấy đảo
					  phân khúc SUV/CUV hạng B.','admin','699.000.000','10%',3,N'KIA',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('KIASLT', N'KIA Soluto', 'http://xe360.vn/images/muaban/xehoi/23280/kia-soluto-2019-sedan-01.jpg',
			          N'Kia Soluto là một mẫu xe được xem làm nằm trong top các sản phẩm
					  được quan tâm nhất hiện nay. Ngoại hình ấn tượng, hiện đại kết hợp
					  với nhiều điểm nhấn ấn tượng giúp Kia Soluto trở nên thu hút hơn.',
					  'admin','399.000.000','0%',3,N'KIA',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('KIASRT', N'KIA Sorento', 'https://www.motortrend.com/uploads/sites/5/2019/01/2019-Kia-Sorento-1.jpg',
			          N'Kia Sorento nhận được nhiều sự đánh giá cao về thiết kế lẫn công
					  nghệ trang bị. Vô lăng xe dạng 3 chấu, bọc da rất mịn. Trên vô lăng
					  tích hợp đầy đủ các phím chức năng với thiết kế nền đen viền bạc khá
					  nổi bật. Ở bản Sorento Signature máy dầu và xăng có thêm tính năng sưởi
					  vô lăng.','admin','1.119.000.000','5%',3,N'KIA',N'Chiếc');
go

-- Ford -----------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('FORDEVR', N'Ford Everest', 'https://img-ik.cars.co.za/images/2020/5/tr:n-news_1200x/Ford-Everest-4x4.jpg',
			          N'Ford Everest thế hệ mới được đánh giá cao ở ngoại hình vạm vỡ, thiết
					  kế thay đổi cao cấp hơn, công nghệ ngập tràn, động cơ mạnh mẽ bậc nhất phân khúc', 
					  'admin','1.099.000.000','0%',4,N'Ford',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('FORDEXP', N'Ford Explorer', 'https://cdn.motor1.com/images/mgl/918W1/s1/ford-explorer-phev.jpg',
			          N'Ford Explorer 2022: SUV cỡ lớn nhập Mỹ, thiết kế khỏe khoắn, vận hành
					  mạnh mẽ, không gian rộng rãi và nhiều tiện nghi','admin','2.499.000.000','0%',4,
					  N'Ford', N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('FORDRG', N'Ford Ranger', 'https://img-ik.cars.co.za/news-site-za/images/2016/08/DSC_8875.jpg',
			          N'Thiết kế hiện đại, năng động, vừa thích hợp đi phố thị, vừa thích hợp
					  đi đường rừng, trèo đèo lội suối; động cơ bi-turbo mạnh mẽ; danh sách
					  trang bị tiện nghi hậu hĩnh đó là những điểm mạnh của Ranger','admin','899.000.000','0%',4,N'Ford', N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('FORDRR', N'Ford Ranger Raptor', 'https://cdn.motor1.com/images/mgl/GPYrG/s3/2019-ford-ranger-raptor-im-test.jpg',
			          N'Nhờ hiệu suất hoạt động mạnh mẽ, di chuyển được hầu hết các cung đường, chở được
					  nhiều hàng và thiết kế rất đồ sộ nên Ford Ranger Raptor được người dùng rất ưa chuộng', 
					'admin','1.299.000.000','0%',4,N'Ford',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('FORDECOS', N'Ford Ecosport', 'https://img-ik.cars.co.za/images/2018/7/FordEcolaunch/tr:n-news_1200x/FordEcosport4.jpg',
			          N'Ford Ecosport là một trong những mẫu xe nổi bật và bán chạy nhất của Ford
					  ngay từ khi ra mắt thị trường tính đến thời điểm hiện tại. Ford Ecosport
					  là dòng xe thuộc phân khúc cỡ nhỏ, tạo ra cơn sốt không hề giảm nhiệ
					  t trên nhiều quốc gia, trong đó có Việt Nam.','admin','679.000.000','0%',4,N'Ford',N'Chiếc');
go

-- Vinfast--------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('VIFVF5', N'Vinfast VF5', 'https://static.motor.es/fotos-noticias/2022/02/vinfast-vf-5-2023-202284604-1643705820_1.jpg',
			          N'Vinfast VF5 là mẫu SUV điện nhỏ nhất của Vinfast trong các dòng VF
					  mà Vinfast vừa mới cho ra mắt và đang dần thương mại. Xe được định vị
					  là một trong những dòng xe thuộc phân khúc SUV hạng A “mới nổi” trên
					  cả thế giới cũng như tại Việt Nam.','admin', '458.000.000','0%',5,N'Vinfast',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('VIFVF6', N'Vinfast VF6', 'https://angiangauto.com/wp-content/uploads/2022/01/ngoai-that-vinfast-vf6.jpg',
			          N'VinFast VF 6 vẫn nắm giữ lợi thế là động cơ thân thiện với môi trường.
					  Không những vậy, chiếc SUV hạng B còn ghi điểm trong mắt nhiều người Việt
					  nhờ thiết kế ngoại thất hướng tương lai cùng với khoang nội thất hiện đại', 
					 'admin', '819.000.000', '0%' ,5,N'Vinfast',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('VIFVF7', N'Vinfast VF7', 'https://vanhoavaphattrien.vn/uploads/images/2022/01/09/10-vf7-8-1641706136.jpg',
			          N'VinFast VF7 mẫu xe được định vị thuộc phân khúc SUV hạng C. Đây là 
					  một mảnh ghép quan trọng để hoàn thiện chuỗi sản phẩm “xanh” của hãng
					  xe này đi thực hiện cuộc cách mạng xanh trên toàn Thế giới.', 'admin','1.049.000.000','0%',5,N'Vinfast', N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('VIFVF8', N'Vinfast VF8', 'https://s3-prod-europe.autonews.com/s3fs-public/VinFast%20VF8%20web.jpg',
					  N'Chiếc SUV chạy điện 5 chỗ VinFast VF 8 được thiết kế để mang đến vẻ
					  ngoài ấn tượng và phong cách. Đồng thời tạo ra trải nghiệm lái xe thông
					  minh và an toàn hơn', 'admin','1.129.000.000','0%',5,N'Vinfast',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('VIFVF9', N'Vinfast VF9', 'https://www.actu-automobile.com/wp-content/uploads/2022/05/Vinfast-VF9_-3.jpeg',
			          N'Với thiết kế nội thất/ngoại thất cực kì sang trọng, hệ thống trang thiết
					  bị an toàn và tiện nghi VinFast VF 9 được kỳ vọng có thể thu hút khách hàng
					  đang tìm kiếm những mẫu SUV cỡ lớn cho gia đình','admin','1.689.000.000','0%',5,N'Vinfast',N'Chiếc');
go
-- Audi--------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AUDIA3', N'Audi A3', 'http://wallsdesk.com/wp-content/uploads/2017/01/Audi-A3-Sportback-E-Tron-Wallpapers-.jpg',
			          N'Audi A3 là mẫu xe được kết hợp hài hòa giữa quá khứ và
					  hiện đại khi mang nét đẹp cổ điển cùng sự trẻ trung, hiện
					  đại để phù hợp đối tượng trẻ tuổi.','admin','1.369.000.000','0%',7,N'Audi',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AUDIQ5', N'Audi Q5', 'https://www.carscoops.com/wp-content/uploads/2019/05/82bcf2b3-2020-audi-q5-55-tfsi-e-quattro-phev-0.jpg',
			          N'Audi Q5 được xem là con át chủ bài của hãng xe Đức khi nằm
					  trong danh sách các mẫu xe bán chạy nhất','admin','2.999.000.000','0%',7,N'Audi',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('AUDITT', N'Audi TT', 'https://st.automobilemag.com/uploads/sites/5/2018/07/2019-Audi-TT-Roadster-front-three-quarters.jpg',
			          N'Audi TT thỏa mãn nhu cầu của các đại gia mê xe 4 chỗ có hình
					  dáng Coupe. Phiên bản mới nhất Audi TT ra đời vẫn có khả năng
					  vận hành vượt trội dù đã gần 2 thập kỷ tồn tại','admin','2.399.000.000','0%',7,N'Audi',N'Chiếc');
go
-- Hyundai--------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HDACC', N'Hyundai Accent', 'https://cdn.motor1.com/images/mgl/Pj9RG/s1/2018-hyundai-accent-first-drive.jpg',
			          N'Hyundai Accent là dòng xe sedan hạng B hiện đang có mặt trên thị 
					  trường Việt Nam và được nhập khẩu nguyên chiếc từ Hàn Quốc đem đến cho các
					  khách hàng một dòng xe có kiểu dáng thiết kế sang trọng, trang bị nhiều công
					  nghệ hiện đại và cho khả năng vận hành bền bỉ.','admin','459.000.000','0%',8,N'Hyundai',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HDCRT', N'Hyundai Creta', 'https://cdni.autocarindia.com/ExtraImages/20180604050039_Creta%20facelift%202.jpg',
			          N'Hyundai Accent là dòng xe sedan hạng B hiện đang có mặt trên thị 
					  trường Việt Nam và được nhập khẩu nguyên chiếc từ Hàn Quốc đem đến cho các
					  khách hàng một dòng xe có kiểu dáng thiết kế sang trọng, trang bị nhiều công
					  nghệ hiện đại và cho khả năng vận hành bền bỉ.','admin','689.000.000','0%',8,N'Hyundai',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HDI10', N'Hyundai i10', 'https://www.smetechguru.co.za/wp-content/uploads/2018/02/grand_i10_front_blue_01.jpg',
			          N'Hyundai i10 là một dòng xe có kích thước khá nhỏ gọn nhưng với thiết kế đầy
					  trẻ trung và quý phái nên từ khi vừa mới ra mắt, dòng xe này đã nhanh
					  chóng lọt vào mắt xanh của nhiều khách hàng','admin','369.000.000','0%',8,N'Hyundai',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HDSTF', N'Hyundai Santafe', 'https://img-ik.cars.co.za/images/2018/11/HyundaiSantaFeLR/tr:n-news_1200x/dscf7740_1800x1800.jpg',
			          N'Hyundai Santafe là một trong những cái tên đã quá là quen thuộc với các
					  khách hàng Việt Nam. Là dòng xe có kiểu dáng thiết kế sang trọng, trang bị
					  rất nhiều công nghệ tiên tiến và cho khả năng vận hành mạnh mẽ.','admin','1.049.000.000','0%',8,N'Hyundai',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('HDTS', N'Hyundai Tucson', 'https://cdn.motor1.com/images/mgl/WwM8L/s1/hyundai-tucson-diesel-test.jpg',
			          N'Hyundai Tucson ra mắt với nhiều cải tiến mới mẻ thu hút sự chú ý của
					  rất nhiều khách hàng. Đây cũng là dòng xe hiện đang có mức doanh số ấn 
					  tượng nhất trong phân khúc SUV 5 chỗ','admin','1.059.000.000','0%',8,N'Hyundai',N'Chiếc');
go
-- Mazda--------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MAZD3', N'Mazda 3', 'https://cdn.carbuzz.com/gallery-images/1600/348000/200/348268.jpg',
			          N'Mazda 3 được đánh giá như một mẫu xe hoàn hảo đáp ứng được đầy đủ yêu
					  cầu của khách hàng. Với mức giá bán hợp lý cùng chất lượng tốt bền bỉ chắc
					  chắn Mazda 3 2022 sẽ không là khách hàng phải thất vọng với sự lựa chọn của 
					  mình','admin','739.000.000','0%',11,N'Mazda',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MAZDCX5', N'Mazda CX5', 'https://cdn.carbuzz.com/gallery-images/2020-mazda-cx-5-front-angle-view-carbuzz-661677-1600.jpg',
			          N'Mazda CX-5 là dòng xe có kiểu dáng thiết kế sang trọng, đẳng cấp giúp
					  cho khách hàng có được ấn tượng sâu sắc và khó quên ngoài ra xe được trang
					  bị thêm nhiều trang bị hiện đại hơn.','admin','1.059.000.000','0%',11,N'Mazda',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MAZDCX8', N'Mazda CX8', 'http://performancedrive.com.au/wp-content/uploads/2018/09/2018-Mazda-CX-8-Asaki.jpg',
			          N'Mazda CX8 là mẫu SUV này được phần đông khách hàng tại Việt Nam yêu thích nhờ ngoại
					  thất đẹp, nội thất tiện nghi và khả năng tiết kiệm nhiên liệu ấn tượng.','admin','1.169.000.000','0%',11,N'Mazda',N'Chiếc');
go
-- Mercedes--------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MERCC200', N'Mercedes C200', 'https://lkswebprdcdnep4.azureedge.net/api/image/stock/6c2cb594-954c-4799-9d29-25e58f93cdbd?w=1200',
			          N'Mercedes C200 2022 ra mắt thị trường Việt Nam như là thế hệ mới được nâng cấp
					  từ thiết kế, nội thất với phong cách trẻ trung và đậm chất tương lai','admin','1.499.000.000','0%',6,N'Mercedes',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MERCC300', N'Mercedes C300', 'https://bringatrailer.com/wp-content/uploads/2016/08/DSC_0107.jpg',
			          N'Mercedes C300 là chiếc sedan thể thao hiệu suất cao hướng đến khách hàng cá tính
					  yêu thích tốc độ.Phiên bản C300 AMG được lắp ráp trong nước với nhiều với nhiều thay
					  đổi từ thiết kế, trang bị đến vận hành','admin','2.089.000.000','0%',6,N'Mercedes',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MERCG63', N'Mercedes G63', 'https://blog.gumtree.co.za/wp-content/uploads/2018/11/Large-30117-NewMercedes-AMGG63.jpg',
			          N'Với đặc tính là một mẫu xe địa hình và sở hữu nhiều công nghệ hiện đại nhất hiện nay,
					  Mercedes AMG G63 được ví như một “cỗ xe tăng” bất bại trong phân khúc','admin','11.699.000.000','0%',6,N'Mercedes',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MERCGLC2', N'Mercedes GLC200', 'https://www.dsf.my/wp-content/uploads/2020/01/Mercedes-Benz-GLC-200-14.jpeg',
			          N'Mercedes GLC 200 hội tụ nhiều ưu điểm và thế mạnh. Siêu xe nhà Mercedes có một
					  kiểu dáng nhỏ gọn với thiết kế năng động, trẻ trung, hiện đại với vẻ đẹp vô cùng
					  nổi bật.','admin','1.099.000.000','0%',6,N'Mercedes',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('MERCGLC3', N'Mercedes GLC300', 'http://icdn-5.motor1.com/images/mgl/oXygL/s1/2016-mercedes-benz-glc300-4matic-review.jpg',
			          N'Mercedes GLC 300 sẽ làm cho khách hàng có được ấn tượng sâu sắc và khó quên
					  khi trên xe được sở hữu với rất nhiều điểm cái tiến mới mẻ làm cho khách hàng
					  phải bất ngờ.','admin','2.639.000.000','0%',6,N'Mercedes',N'Chiếc');
go
-- Nissan--------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('NISNVR', N'Nissan Navara', 'https://performancedrive.com.au/wp-content/uploads/2019/11/2019-Nissan-Navara-N-TREK-hero.jpg',
			          N'Dòng xe này có những thiết kế vô cùng ấn tượng, trang bị tiện ích giúp đáp ứng
					  được tối đa nhu cầu của người dùng. Đây cũng chính là lý do mà nhiều khách hàng
					  vẫn lựa chọn sản phẩm bán tải của Nissan','admin','889.000.000','0%',9,N'Nissan',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('NISSUN', N'Nissan Sunny', 'https://fsautomoveis.com/wp-content/uploads/2021/02/Nissan-Sunny-GTI-R-001-1024x684.jpg',
			          N'Nissan Sunny là một trong những lựa chọn hoàn hảo dành cho khách hàng. Xe có
					  chất lượng tốt bền bỉ theo thời gian, dễ dàng sử dụng cho mọi đối tượng người dùng,
					  sẽ không làm khách hàng phải thất vọng với sự lựa chọn của mình.','admin','499.000.000','10%',9,N'Nissan',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('NISTER', N'Nissan Terra', 'http://performancedrive.com.au/wp-content/uploads/2018/02/2018-Nissan-Terra-1280x878.jpg',
			          N'Là một chiếc SUV cỡ trung Nissan Terra đã gây được sự chú ý của rất nhiều người
					  ưa chuộng dòng xe SUV bằng những thiết bị hiện đại, nội thất tinh tế và sức mạnh
					  cực kì đáng gờm','admin','1.199.000.000','0%',9,N'Nissan',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('NISXTRA', N'Nissan Xtrail', 'https://images.carexpert.com.au/resize/3000/-/app/uploads/2020/04/nissan-x-trail-n-trek-awd-6.jpg',
			          N'Nissan X-Trail mang một thiết kế mới của hãng giúp cho chiếc xe mạng một diệ
					  n mạo mới trẻ trung và năng động cùng với đó là những chi tiết tỉ mỉ tinh tế đều
					  được chiếc xe thể hiện rõ ràng','admin','919.000.000','0%',9,N'Nissan',N'Chiếc');
go
-- Peugeot--------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('PEG208', N'Peugeot 2008', 'https://tse4.mm.bing.net/th?id=OIP.iuys4eBmtMeucfVcMdaVhAHaFj&pid=Api&P=0',
			          N'Peugeot 2008 có sự thay đổi vô cùng nổi bật ở diện mạo bên ngoài của xe.Ngoài
					  ra dòng xe này còn được bổ sung thêm động cơ thuần điện vô cùng ấn tượng','admin','769.000.000','0%',10,N'Peugeot',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('PEG308', N'Peugeot 3008', 'http://premium.goauto.com.au/wp-content/uploads/2017/08/Peugeot_3008_7.jpg',
			          N'Peugeot 3008 đã có sự thay đổi rất lớn về diện mạo bên ngoài so với thế hệ trước,
					  cụ thể dòng xe này vừa giữ được nét lãng tử đậm chất của hãng xe Pháp, vừa mang đến
					  một diện mạo trẻ trung và thanh lịch hơn rất nhiều.','admin','1.069.000.000','0%',10,N'Peugeot',N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('PEG508', N'Peugeot 5008', 'http://www.wheels-alive.co.uk/wp-content/uploads/2018/06/Peugeot-5008-SUV-side-front-static-view.jpg',
			          N'Peugeot 5008 luôn dành được nhiều sự quan tâm của người dùng xe trên toàn thế giới
					  . Mới đây Peugeot 5008 2022 đã chính thức được tình làng, với nhiều nâng cấp đáng
					  chú ý về cả trang bị và tiện nghi.','admin','1.309.000.000','0%',10,N'Peugeot',N'Chiếc');
go