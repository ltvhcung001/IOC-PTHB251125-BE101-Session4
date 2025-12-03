create table books(
	id serial primary key,
	title varchar(100),
	author varchar(50),
	category varchar(50),
	publish_year int,
	price int,
	stock int
);


INSERT INTO books(id, title, author, category, publish_year, price, stock) VALUES
(1, 'Lập trình C cơ bản', 'Nguyễn Văn Nam', 'CNTT', 2018, 95000, 20),
(2, 'Học SQL qua ví dụ', 'Trần Thị Hạnh', 'CSDL', 2020, 125000, 12),
(3, 'Lập trình C cơ bản', 'Nguyễn Văn Nam', 'CNTT', 2018, 95000, 20),
(4, 'Phân tích dữ liệu với Python', 'Lê Quốc Bảo', 'CNTT', 2022, 180000, NULL),
(5, 'Quản trị cơ sở dữ liệu', 'Nguyễn Thị Minh', 'CSDL', 2021, 150000, 5),
(6, 'Học máy cho người mới bắt đầu', 'Nguyễn Văn Nam', 'AI', 2023, 220000, 8),
(7, 'Khoa học dữ liệu cơ bản', 'Nguyễn Văn Nam', 'AI', 2023, 220000, NULL);

-- 1. Chuẩn hóa dữ liệu: Xóa các bản ghi trùng lặp hoàn toàn về title, author và publish_year
delete from books 
where id not in (
    select id from (
        select min(id) as id 
        from books 
        group by title, author, publish_year
    )
);

-- 2. Cập nhật giá: Tăng giá 10% cho những sách xuất bản từ năm 2021 trở đi và có price < 200000
update books
set price = price * 1.1
where publish_year >= 2021 and price < 200000;

-- 3. Xử lý lỗi nhập: Với những sách có stock IS NULL, cập nhật stock = 0
update books
set stock = 0
where stock is null;

-- 4. Truy vấn nâng cao:
-- a. Liệt kê danh sách sách thuộc chủ đề CNTT hoặc AI có giá trong khoảng 100000 - 250000
select title
from books
where category in ('CNTT', 'AI') and price >= 100000 and price <= 250000;

-- b. Sắp xếp giảm dần theo price, rồi tăng dần theo title
select title
from books
where category in ('CNTT', 'AI') and price >= 100000 and price <= 250000
order by price desc, title asc;

-- 5. Tìm kiếm tự do: Tìm các sách có tiêu đề chứa từ “học” (không phân biệt hoa thường)
select title
from books
where title ilike '%học%';

-- 6. Thống kê chuyên mục: Liệt kê các thể loại duy nhất (DISTINCT) có ít nhất một cuốn sách xuất bản sau năm 2020
select distinct category
from books
where publish_year >= 2020;

-- 7. Phân trang kết quả:
-- Chỉ hiển thị 2 kết quả đầu tiên, bỏ qua 1 kết quả đầu tiên (dùng LIMIT + OFFSET)
select distinct category
from books
where publish_year >= 2020
limit 2
offset 1;
