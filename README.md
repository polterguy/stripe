
# Stripe subscription payments module

This is the primary module we'll use ourselves to charge for cloudlets. However, since we're
nice guys and gals, we've chosen to open source license it, such that you can use it in your own
projects. the project has the following logical entities.

* payment-methods - Creates, reads or deletes a payment method for the currently authenticated user
* subscriptions - Creates, reads or deletes a subscription for the currently authenticated user

## TL;TR

Make sure you apply your Stripe API token as `magic:stripe:token` in your Config dashboard
menu in Magic, then invoke the `POST` _"payment-methods"_ endpoint with something resembling
the following. If you want to try 3D Secure, you can use the card number _"4000002500003155"_.
If you want to test a failed card, you can use _"4000000000009995"_.

```
{
  "card_number": "4242424242424242",
  "card_exp_month": "6",
  "card_exp_year": "2023",
  "card_cvs": "314"
}
```

This will return something resembling the following to you.

```
{
  "payment-method": "pm_1LsdsGSDDSFG634345GF",
  "brand": "visa",
  "card_no": "4242"
}
```

Then invoke `POST` _"subscriptions"_ endpoint with the `payment-method` returned from the above
invocation as follows.

```
{
  "price": "price_sdfujg345sdfvdfs",
  "payment_method": "pm_1LsdsGSDDSFG634345GF"
}
```

Notice, the above price above needs to be manually created in Stripe's dashboard as a _"product"_.
If you want to pay a single shot payment, you can invoke the `POST` _"payments"_ endpoint
instead, at which point you're expected to pass in something resembling the following.

```
{
  "amount": 5555,
  "currency": "USD",
  "payment_method": "pm_1LsdsGSDDSFG634345GF"
}
```

Both the _"subscriptions"_ endpoint and the _"payments"_ endpoint will return _"finished"_
as a boolean true value if the transaction was instantly completed. The transaction might need
authentication, such as 3D Secure, at which point the endpoint will return success status
code, but the _"finished"_ field will have a boolean false value, at which point the client
will either be given a direct payment link for single shot payments - Or an invoice will be
sent to the user that the user needs to pay, and / or the client needs to retrieve the invoice
associated with the subscription.

## Detailed usage description

The first thing you'll need to do to create a subscription type of payment, is to invoke
the `POST` _"payment-method"_ endpoint passing in the following arguments

* card_number
* card_exp_month
* card_exp_year
* card_cvs

This will internally within Stripe's systems create a payment method object, and if the
customer needs to be created, it will create the customer also in Stripe's systems, keep
a reference to the customer ID internally within its own local database, and associate it
with the currently authenticated username, and associate the payment method with the
customer in Stripe's systems.

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
authenticated user, in addition to a _"price"_. The price is a reference to a product
that you'll typically create in your Stripe dashboard.

If you want to delete a subscription, and/or a payment method, you can invoke the `DELETE`
equivalent endpoints, and the module will take care of everything internally by itself, and
correctly invoke the Stripe API to cancel the subscription.

## Helper endpoints

When a subscription is created, both the product ID and the price ID from Stripe is associated
with the subscription, and returned as you invoke the `GET` _"subscriptions"_ endpoint. You can
use the product ID to retrieve meta information about the product, to display something to the
user such that he knows which product he's actually subscribing to. This will internally invoke
Stripe's API, and retrieve the product information associated with your product from their
internal systems. Since this is rarely changed information, the endpoint applies some fairly
aggressive caching, both server side, and client side, so it should be fairly harmless to
invoke in a loop for instance, while iterating all subscriptions the customer has, unless
the number of subscriptions are several hundreds of course. The intention of course would be
to display what type of product is associated with his or her subscription(s).

## Configuration

You'll need one configuration setting, being your Stripe API token. This will typically
look like follows in your configuration.

```
{
  "magic": {
    "stripe": {
      "token": "sk_test_32tDFcvljh345sdfvnjFDSgfddfg456dfghFGHHGF"
    }
  }
}

```

Notice, the above token is (obviously) just some random garbage. You'll have to login to your
Stripe dashboard to actually retrieve your real token. If you use your test token, the payment
will automatically be created in Stripe's sandbox environment if you want to test your integration.

## Workflow actions

In addition to the above endpoints and helper slots, the module also contains a handful of Stripe related
workflow actions you can chain together to create your own custom logic. Below is a list of these.

* stripe-create-customer - Creates a new customer in Stripe
* stripe-create-payment-method - Creates a new payment method and associates with some customer
* stripe-create-payment - Creates a new payment for the specified amount
* stripe-create-purchase-link - Creates a purchase link and returns to caller
* stripe-create-subscription - Creates a new subscription based upon a price reference

## Database support

The library supports MySQL and PostgreSQL _only_.

## Security

The system does _not_ store card information internally, so it doesn't require you being PCI
compliant, it only stores a _"payment method"_ reference, which is a reference to a card
in Stripe's systems. It does however store the 4 last digits of the card number associated
with the payment method, allowing the user to retrieve all his payment methods, and (hopefully)
being able to figure out which is the correct card to use for whatever subscription the customer
wants to pay for later.

## License

The module is licensed under the terms of the MIT license.

