
/*
 * Add the payment_method column to the subscriptions table.
 */
alter table subscriptions
	add column payment_method varchar(256)
    references payment_methods (payment_method);
