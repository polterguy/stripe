
create table payments (
  payment varchar(256) primary key,
  username varchar(256) not null,
  amount integer not null,
  currency varchar(5) not null,
  payment_method varchar(256) not null,
  foreign key (username) references customers (username),
  foreign key (payment_method) references payment_methods (payment_method)
);
