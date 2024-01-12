
# Stripe payments module

This is our primary Stripe integration module, containing several workflow actions, you can orchestrate together
to create rich workflows. The module doesn't contain any endpoints, only actions, so it's up to you to wire
things together correctly.

## Workflow actions

This module contains the following Stripe related workflow actions you can chain together to create your own
custom logic.

* stripe-create-customer - Creates a new customer in Stripe
* stripe-create-payment-method - Creates a new payment method and associates with some customer
* stripe-create-payment - Creates a new payment for the specified amount
* stripe-create-purchase-link - Creates a purchase link and returns to caller
* stripe-create-subscription - Creates a new subscription based upon a price reference

## Configuration

You'll need one configuration setting, being your Stripe API token. This will typically
look like follows in your configuration.

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
Stripe dashboard to actually retrieve your real token. If you use your test token, the payment
will automatically be created in Stripe's sandbox environment if you want to test your integration.
