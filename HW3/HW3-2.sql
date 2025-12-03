drop table students;
create table students(
	id serial primary key,
	name varchar(50),
	age int,
	major varchar(50),
	gpa decimal(3, 2)
);

create table scholarships(
	id serial primary key,
	student_id int references students(id),
	name varchar(50),
	amount decimal(10, 2),
	year int
);

insert into students(name, age, major, gpa) values
('An', 20, 'CNTT', 3.5),
('Bình', 21, 'Toán', 3.2),
('Cường', 22, 'CNTT', 3.8),
('Dương', 20, 'Vật lý', 3.0),
('Em', 21, 'CNTT', 2.9);

insert into scholarships(student_id, name, amount, year) values
(1, 'Học bổng xuất sắc', 1000, 2025),
(3, 'Học bổng xuất sắc', 1200, 2025),
(2, 'Học bổng khuyến khích', 500, 2025),
(4, 'Học bổng khuyến khích', 400, 2025);


-- 1. Thêm học bổng mới cho sinh viên "Em" với tên "Học bổng khuyến khích" và giá trị 450 cho năm 2025
insert into scholarships(id, student_id, name, amount, year) values
(5, 5, 'Học bổng khuyến khích', 450, 2025);


-- 2. Cập nhật GPA của sinh viên có học bổng "Học bổng xuất sắc" lên 4.0
update students
set gpa = 4.0
where id in (select distinct student_id 
			 from scholarships
			 where name = 'Học bổng khuyến khích');

-- 3. Xóa các học bổng của sinh viên có GPA < 3.0
delete from scholarships
where student_id in (select id
					 from students
					 where gpa < 3.0);

-- 4. Liệt kê tên sinh viên, chuyên ngành, tên học bổng và số tiền của các học bổng năm 2025, sắp xếp theo số tiền giảm dần
select st.name, st.major, sc.name, sc.amount
from students st join scholarships sc on st.id = sc.student_id
where sc.year = 2025
order by sc.amount desc;

-- 5. Liệt kê các sinh viên có nhiều hơn 1 học bổng (sử dụng GROUP BY và HAVING)
select st.name
from students st join scholarships sc on st.id = sc.student_id
group by st.id, st.name
having count(sc.id) > 1;

-- 6. Liệt kê sinh viên có tên chứa chữ 'C' và nhận học bổng > 1000
select st.name
from students st join scholarships sc on st.id = sc.student_id
where st.name ilike '%C%' and sc.amount > 1000;

-- 7. Hiển thị 2 sinh viên đầu tiên theo GPA giảm dần, sử dụng LIMIT/OFFSET
select st.name
from students st
order by st.gpa desc
limit 10
offset 5;


