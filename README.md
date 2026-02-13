
Primary Stripe integration module containing a whole range of workflow actions you can use to integrate
your apps with Stripe.

## Workflow actions

This module contains the following Stripe related workflow actions you can chain together to create your own
custom logic.

* stripe-charge-webhook - Webhook action making it easy to create Stripe webhooks to accept callback from Stripe.
* stripe-charges-get - Returns latest charges, optionally for a specific customer.
* stripe-customer-create - Creates a new customer in Stripe.
* stripe-payment-create - Creates a new payment for the specified amount.
* stripe-payment-link-create - Creates a purchase link and returns to caller.
* stripe-payment-method-create - Creates a new payment method and associates with some customer.
* stripe-refund-create - Refunds the specified payment.
* stripe-subscription-create - Creates a new subscription based upon a price reference.
* stripe-subscription-delete - Deletes the specified subscription.

## Configuration

You'll need one configuration setting, being your Stripe API token. This will typically look like the following in your configuration.

```json
{
  "magic": {
    "stripe": {
      "token": "sk_test_XYZXYZ"
    }
  }
}

```

Notice, the above token is (obviously) just some random garbage. You'll have to login to your
Stripe dashboard to actually retrieve your real token. If you use your test token, all data
will automatically be created in Stripe's sandbox environment if you want to test your integration.
