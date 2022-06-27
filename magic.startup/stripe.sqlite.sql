/*
 * SQLite script creating stripe payments database.
 */

PRAGMA foreign_keys = ON;

/*
 * Contains username to customer_id (at Stripe) references.
 */
create table customers (
  username varchar(256) primary key,
  customer_id varchar(256) not null
);
