# README

This README would normally document whatever steps are necessary to get the
application up and running.

<-----------------------Assessment outlines------------------------------>

1. created a ProductsController within a Rails application.

2. created a model Product with a name and description with some basic validations. Assuming Product model has these attributes and validations, this requirement is fulfilled.

3. ProductsController contains create and update actions for creating and updating products, respectively.

4. No authentication is required in the controller.

5. Using strong parameters to permit only the required attributes (name and description) for creating and updating products, which provides basic parameter verification.

6. Configurable third-party API endpoints: notify_third_parties method iterates over Rails.application.config.third_party_endpoints, indicating that these endpoints are configurable through Rails application configuration.

7. notify_third_parties method, iterate over the configured third-party endpoints and send a POST request to each with the product details when a new product is created or updated.

8. implemented a basic authenticity token verification in the verify_authenticity_token method.

Note:  However, this implementation is not a standard way to authenticate webhook requests. Typically, third parties are provided with a token or secret key that they include in their requests, which is then verified on the server side.
