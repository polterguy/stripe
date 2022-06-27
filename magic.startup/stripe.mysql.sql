/*
 * MySQL script creating stripe payments database.
 */

/*
 * Contains username to customer_id (at Stripe) references.
 */
create table customers (
  username varchar(256) primary key,
  customer_id varchar(256) not null
);

/*
 * Payment method table containing references to payment methods at Stripe.
 */
create table payment_methods (
  payment_method varchar(256) primary key,
  username varchar(256) not null,
  card_no varchar(4) not null,
  card_type varchar(100) not null,
  constraint payment_methods_customers_fky foreign key (username) references customers (username)
);

/*
 * Contains subscriptions associated with user.
 */
create table subscriptions (
  subscription varchar(256) primary key,
  username varchar(256) not null,
  constraint subscriptions_customers_fky foreign key (username) references customers (username)
);
