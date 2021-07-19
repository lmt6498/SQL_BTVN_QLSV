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

select * from sinhvien;

select concat(hodem,ten,' có điểm là  ', diemtb) as hovsten from sinhvien;

select * from sinhvien join lop on sinhvien.lop = lop.id
where sinhvien.lop = lop.id;
			
select concat(hodem,ten,' có điểm là  ', diemtb) as hovsten, (year(now()) - year(ngaysinh)) as tuoi from sinhvien;
