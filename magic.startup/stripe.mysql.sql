/*
 * MySQL script creating stripe payments database.
 */

/*
 * Creating our Stripe database.
 */
create database stripe;

/*
 * Making sure we use stripe database.
 */
use stripe;

/*
 * Contains username to customer_id (at Stripe) references.
 */
create table customers (
  username varchar(256) primary key not null,
  customer_id varchar(256) not null
);

/*
 * Payment method table containing references to payment methods at Stripe.
 */
create table payment_methods (
  payment_method varchar(256) primary key not null,
  username varchar(256) not null,
  card_no varchar(4) not null,
  card_type varchar(100) not null,
  constraint payment_methods_customers_fky foreign key (username) references customers (username)
);

/*
 * Contains subscriptions associated with user.
 */
create table subscriptions (
  subscription varchar(256) primary key not null,
  username varchar(256) not null,
  payment_method varchar(256) not null,
  meta varchar(1024),
  constraint subscriptions_customers_fky foreign key (username) references customers (username)
);
