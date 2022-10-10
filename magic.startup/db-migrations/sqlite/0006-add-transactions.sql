create table transactions (
  `transaction` varchar(256) primary key not null,
  created timestamp not null default current_timestamp,
  username varchar(256) not null,
  amount integer not null,
  invoice varchar(250),
  type varchar(100),
  payment_method varchar(256),
  foreign key (username) references customers (username)
);
