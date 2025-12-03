-- drop table students;
create table students(
	id serial primary key,
	full_name varchar(50),
	gender varchar(10),
	birth_year int,
	major varchar(50),
	gpa decimal(3,1)
);

insert into students (id, full_name, gender, birth_year, major, gpa) values
(1, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
(2, 'Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
(3, 'Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
(4, 'Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
(5, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
(6, 'Lưu Đức Tài', '2004', 2004, 'Cơ khí', NULL),
(7, 'Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

-- 1. Chèn dữ liệu mới:
-- a. Thêm sinh viên “Phan Hoàng Nam”, giới tính Nam, sinh năm 2003, ngành CNTT, GPA 3.8
insert into students(id, full_name, gender, birth_year, major, gpa) values
(8, 'Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

-- 2. Cập nhật dữ liệu:
-- a. Sinh viên “Lê Quốc Cường” vừa cải thiện học lực, cập nhật gpa = 3.4
update students
set gpa = 3.4
where full_name = 'Lê Quốc Cường';

-- 3. Xóa dữ liệu: Xóa tất cả sinh viên có gpa IS NUL
delete from students
where gpa is null;

-- 4. Truy vấn cơ bản: Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên
select full_name
from students
where gpa >= 3.0
limit 3;

-- 5. Loại bỏ trùng lặp: Liệt kê danh sách ngành học duy nhất
select distinct major
from students;

-- 6. Sắp xếp:Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
select full_name
from students
where major = 'CNTT'
order by gpa desc, full_name asc;

-- 7. Tìm kiếm:Tìm sinh viên có tên bắt đầu bằng “Nguyễn”
select full_name
from students
where full_name ilike 'Nguyễn%';

-- 8. Khoảng giá trị: Hiển thị sinh viên có năm sinh từ 2001 đến 2003
select full_name
from students
where birth_year between 2001 and 2003;


