create database quanlysinhvien;
use quanlysinhvien;
create table SinhVien(
   maso int primary key,
   hodem nvarchar(30),
   ten nvarchar(15),
   ngaysinh date,
   lop int,
   diemtb double,
   foreign key (lop) references lop(id)
);

create table lop(
	id int primary key,
    ten nvarchar(50),
    khoa int,
	foreign key (khoa) references khoa(id)
);

create table khoa(
	id int primary key,
    ten nvarchar(50)
);

insert into khoa
values (1, 'CNTT'),
(2,'TKDH'),
(3,'KT'),
(4,'NH');

insert into lop
values (1, 'C01',1),
(2,'C02',2),
(3,'C03',3),
(4,'C04',1);
insert into sinhvien
values (1, 'Nguyễn','Toàn','1998-8-8',1,8.5),
(2, 'Nguyễn','Huy','1998-5-8',2,8.5),
(3, 'Lương','Tuấn','1998-6-4',1,7.0),
(4, 'Hoàng','A','1998-4-8',3,5.0)
;
insert into sinhvien
values (5, 'Nguyễn','đức','1998-8-8',1,8.5),
(6, 'Nguyễn','trung','1998-5-8',2,8.5),
(7, 'Lương','phong','1998-6-4',1,7.0),
(8, 'Hoàng','B','1998-4-8',3,5.0)
;

select * from sinhvien;

select concat(hodem,ten,' có điểm là  ', diemtb) as hovsten from sinhvien;

select * from sinhvien join lop on sinhvien.lop = lop.id
where sinhvien.lop = lop.id;
			
select concat(hodem,ten,' có điểm là  ', diemtb) as hovsten, (year(now()) - year(ngaysinh)) as tuoi from sinhvien;

-- Xếp loại sinh viên
select *, (case when diemtb >=8 then 'Giỏi' when diemtb >6.5 then 'Khá' else 'Trung bình' end) as 'Xếp loại'
from sinhvien;
-- Số lượng sinh viên loại giỏi, loại khá, loại trung bình (trong cùng 1 query)
select
count(case when diemtb > 8 then 1 else null end) as "Giỏi",
count(case when diemtb >= 6.5 and diemtb <= 8 then 1 else null end) as "Khá",
count(case when diemtb < 6.5 then 1 else null end) as "Trung bình"
from sinhvien;
-- Số lượng sinh viên loại giỏi, khá, trung bình của từng lớp (trong cùng 1 query)
select lop.ten as 'Tên lớp',count(case when diemtb > 8 then 1 else null end) as "Giỏi",
count(case when diemtb >= 6.5 and diemtb <= 8 then 1 else null end) as "Khá",
count(case when diemtb < 6.5 then 1 else null end) as "Trung bình"
from lop inner join sinhvien on lop.id = sinhvien.lop
group by lop.id;
-- Tên lớp, danh sách các sinh viên của lớp sắp xếp theo điểm trung bình giảm dần
select *
from sinhvien
order by diemtb desc;
-- Tên lớp, tổng số sinh viên của lớp
select lop.ten,count(sinhvien.maso) as 'Số lượng SV'
from lop inner join sinhvien on lop.id = sinhvien.lop
group by lop.id;
-- Tên khoa, tổng số sinh viên của khoa
select khoa.ten,count(sinhvien.maso) as 'Số lượng SV'
from ((khoa inner join lop on khoa.id = lop.khoa)inner join sinhvien on lop.id = sinhvien.lop)
group by lop.id;
-- Tên khoa, tên lớp, điểm trung bình của sinh viên (chú ý: liệt kê tất cả các khoa và lớp, kể cả khoa và lớp chưa có sinh viên)
select khoa.ten as "Tên khoa",lop.ten as "Tên lớp",sinhvien.ten as "Tên sinh viên",sinhvien.diemtb as "Điểm trung bình"
from ((khoa inner join lop on khoa.id = lop.khoa)inner join sinhvien on lop.id = sinhvien.lop)
group by khoa.id,sinhvien.maso;
-- Tên khoa, tên lớp, họ tên, ngày sinh, điểm trung bình của sinh viên có điểm trung bình cao nhất lớp
select khoa.ten as "Tên khoa",lop.ten as "Tên lớp",sinhvien.ten as "Tên sinh viên",sinhvien.diemtb as "Điểm trung bình"
from ((khoa inner join lop on khoa.id = lop.khoa)inner join sinhvien on lop.id = sinhvien.lop)
where sinhvien.diemtb >= all(select diemtb from sinhvien)
group by khoa.id,sinhvien.maso; 
-- Tên khoa, Họ tên, ngày sinh, điểm trung bình của sinh viên có điểm trung bình cao nhất khoa
select khoa.ten as "Tên khoa",sinhvien.ten as "Tên sinh viên",sinhvien.diemtb as "Điểm trung bình"
from ((khoa inner join lop on khoa.id = lop.khoa)inner join sinhvien on lop.id = sinhvien.lop)
where sinhvien.diemtb >= all(select diemtb from sinhvien)
group by khoa.id,sinhvien.maso; 


