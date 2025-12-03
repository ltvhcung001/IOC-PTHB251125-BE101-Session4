create table employees(
	id serial primary key, 
	full_name varchar(50), 
	department varchar(50),
	position varchar(50),
	salary int,
	bonus int,
	join_year int
);

INSERT INTO employees (id, full_name, department, position, salary, bonus, join_year) VALUES
(1, 'Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
(2, 'Trần Thị Mai', 'HR', 'Recruiter', 12000000, NULL, 2020),
(3, 'Lê Quốc Trung', 'IT', 'Tester', 15000000, 800000, 2023),
(4, 'Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
(5, 'Phạm Ngọc Hân', 'Finance', 'Accountant', 14000000, NULL, 2019),
(6, 'Bùi Thị Lan', 'HR', 'HR Manager', 20000000, 3000000, 2018),
(7, 'Đặng Hữu Tài', 'IT', 'Developer', 17000000, NULL, 2022);


-- 1. Chuẩn hóa dữ liệu: Xóa các bản ghi trùng nhau hoàn toàn về tên, phòng ban và vị trí
delete from employees 
where id not in (
    select id from (
        select min(id) as id 
        from employees 
        group by full_name, department, position
    )
);


-- 2. Cập nhật lương thưởng:
-- a. Tăng 10% lương cho những nhân viên làm trong phòng IT có mức lương dưới 18,000,000
update employees
set salary = salary * 1.1 
where salary < 18000000;

-- b. Với nhân viên có bonus IS NULL, đặt giá trị bonus = 500000
update employees
set bonus = 500000
where bonus is null;

-- 3. Truy vấn: 
-- a. Hiển thị danh sách nhân viên thuộc phòng IT hoặc HR, gia nhập sau năm 2020, và có tổng thu nhập (salary + bonus) lớn hơn 15,000,000
select full_name
from employees
where department in ('IT', 'HR') and join_year > 2020 and (salary + bonus) > 15000000;

-- b. Chỉ lấy 3 nhân viên đầu tiên sau khi sắp xếp giảm dần theo tổng thu nhập
select full_name, (salary + bonus) as total_income
from employees
where salary is not null and bonus is not null
order by total_income desc
limit 3;

-- 4. Truy vấn theo mẫu tên: Tìm tất cả nhân viên có tên bắt đầu bằng “Nguyễn” hoặc kết thúc bằng “Hân”
select full_name
from employees
where full_name ilike 'Nguyễn%' or full_name ilike '%Hân';

-- 5. Truy vấn đặc biệt: Liệt kê các phòng ban duy nhất có ít nhất một nhân viên có bonus IS NOT NULL
select distinct department
from employees
where bonus is not null;

-- 6. Khoảng thời gian làm việc: Hiển thị nhân viên gia nhập trong khoảng từ 2019 đến 2022 (BETWEEN)
select full_name
from employees
where join_year between 2019 and 2022;
