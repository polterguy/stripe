
/*
 * Add the payment_method column to the subscriptions table.
 */
alter table subscriptions add column payment_method varchar(256);
alter table subscriptions add constraint subscriptions_payment_methods_fky foreign key payment_method references payment_methods(payment_method);
