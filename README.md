
# Stripe subscription payments module

This is the primary module we'll use ourselves to charge for cloudlets. However, since we're
nice guys and gals, we've chosen to open source license it, such that you can use it in your own
projects. the project has the following logical entities.

* payment-methods - Creates, reads or deletes a payment method for the currently authenticated user
* subscriptions - Creates, reads or deletes a subscription for the currently authenticated user

## Usage

The first thing you'll need to do to create a subscription type of payment, is to invoke
the `POST` _"payment-method"_ endpoint passing in the following arguments

* card_number
* card_exp_month
* card_exp_year
* card_cvs

This will internally within Stripe's systems create a payment method object, and if the
customer needs to be created, it will create the customer also in Stripe's systems, keep
a reference to the customer ID and associate it with the currently authenticated username,
and associate the payment method with the customer in Stripe's systems.

Everything is taken care of internally by the module itself though, so you don't need to
worry about the details above, just make sure you invoke the endpoint with a user that
belongs to one of the following roles.

* root
* admin
* guest

When you later want to create a subscription for the customer, you're expected to pass in the
payment method reference that you can retrieve ewith the `GET` _"payment-methods"_, that
will only return payment methods previously associated with the currently authenticated user.
This allows your users to create multiple payment methods, with for instance multiple cards,
and have them choose which payment method to use as they pay for a subscription service.

You can also (internally) delete a payment method by invoking the `DELETE` _"payment_methods"_
endpoint.

When you are ready to create a subscription, you'll need to invoke the `POST` _"subscriptions"_
endpoint, passing in a reference to one payment method previously created with the currently
authenticated user, in addition to a _"price"_. The price is basically a reference to a product
that you'll typically create in your Stripe dashboard.

If you want to delete a subscription, and/or a payment method, you can invoke the `DELETE`
equivalent endpoints, and the module will take care of everything internally by itself, and
correctly invoke the Stripe API to cancel the subscription.
