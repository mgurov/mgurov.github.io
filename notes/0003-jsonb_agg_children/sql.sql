drop table if exists lines;
drop table if exists orders;

create table orders(
  order_id INT PRIMARY KEY,
  customer_id INT,
  total_value INT
);

create table lines(
  line_id INT PRIMARY KEY,
  order_id INT references orders(order_id),
  value INT
);

CREATE INDEX lines_odere_id ON lines(order_id);

insert into orders (order_id, customer_id, total_value)
values (1, 1, 15),
       (2, 2, 10);


insert into lines (line_id, order_id, value)
values (1, 1, 10),
       (2, 1, 2),
       (3, 1, 3),
       (4, 2, 10);


SELECT *
from orders
       inner join lines on orders.order_id = lines.order_id;


select orders.*,
       (select jsonb_agg(joined_lines) from
                                            (select * from lines where lines.order_id = orders.order_id) joined_lines
       ) as lines
from orders;

