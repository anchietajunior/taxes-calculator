
# Taxes calculator

## Versions

This app is using Ruby 3.2.2

## Running the app

To run the application just run in your console:

```shell
ruby app.rb
```

## Running the tests

bundle exec rspec

## Notes after refactoring

- Applied Strategy pattern for Taxes
- Applied Factory patten to build the correct Tax class instance
- Applied Command patten to run Product creations and Ticket printings
- Renamed ShoppingBasket to Ticket
- Improved test coverage for the new classes
- Refactored the app.rb file to separate responsabilities through the classes
- Added BigDecimal operations over Float operations to avoid decimals inconsistencies
- Moved the non taxed products to the not_taxed_products.yml file
- Improved classes, variables and methods names
