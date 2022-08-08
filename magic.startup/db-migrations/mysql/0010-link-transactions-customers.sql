alter table transactions
	add constraint transactions_customers_fky
    foreign key (username)
    references customers (username);
