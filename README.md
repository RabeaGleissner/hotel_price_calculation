# Hotel price calculator

The API endpoint can be called to retrieve the hotel prices for tenant A, B or C like this:

`GET /hotels/price?tenant_id=A`

Any other query string parameters will be ignored.

## How to run the app

`bundle install`

`rackup`

The app will be running on `http://localhost:9292/`


## How to run the tests

`rspec`

This also generates a test coverage report in a directory called `coverage/`.


## My approach

I started off by thinking about the structure of the whole application. I understood from the instructions, that an important part of the design would be to allow adding new tenants in an easy way. So I tried to find a design that would adhere to the open-closed principle.

Then I started writing the code using an outside-in TDD approach, where I created the collaborators first using rspec's test doubles for any logic that wasn't implemented yet.
Once I had created all the collaborators, I then wrote any more detailed algorithms like the pricing logic.


### Adding or removing pricing logic for a tenant

I understood that most tenants would follow the logic of adding markup, applying a service fee and offering hotels up to a maximum price.
That's why I created the `StandardPriceCalculator`, which is initialised with these three pieces of information.

Tenant C is describe as an "extreme case", which requires completely different pricing logic, so I created a class specifically for that tenant.

To add a new standard tenant, we simply need to add their details to the `config.yml` in this format:

```
tenant_id:
  - markup
  - service_fee
  - max_price
```

To add a special price calculator like the one for tenant C, we would need to add a new class which conforms to the same interface as the other price calculators (i.e. has a method `calculate` which takes the hotel prices as an argument) and then also add that to the factory method.


### Frameworks and libraries

I decided to use the Sinatra web framework because this is a small application without any database. Sinatra is light-weight and seemed the right tool for the job.

I'm using the HTTParty gem to make a web request. I wrapped it in its own class so that the details of that gem don't become scattered throughout the application.
That means it can be easily replaced, should I decide to use a different gem.


### Test coverage

I'm not testing the `Request` class because it is a very thin wrapper around the HTTParty gem.
If I were to test it, I'd ultimately test the gem itself which is not necessary.


## Things to improve

I had already spent quite a lot of time on creating this application, so I wanted to draw the line somewhere. I'm aware that some improvements can be made, so I thought I'd list my thoughts here.


### Adding standard calculator parameters to config file

It might be better to make it clearer what the parameters are, instead of just adding them as an array into the yaml file.
At the moment it would be easy to make a mistake and mix up the order of the numbers, for example.
It would be better if the three parameters were added as a hash.


### Validation

Based on the instructions I figured that validation of query string parameters is not a priority, so I'm currently not validating if the tenant id exists. So if the API is called with any other id than A,B or C the program will crash.

The validation should be done in the controller, before any of the application logic runs.
We could use the config file to check if the tenant exists - in that case we would also need to add any "special case" tenants, like tenant C.


### Tests for tenant C price calculator

The tests for `TenantCPriceCalculator` are not covering the full functionality because they only check if the right price is returned for one cost price in each price span.
I could use a test framework that generates random numbers and create a lot more tests for each price span to ensure that the output is correct.


### Running tests

Currently there is only one command to run the tests, which means that the unit tests are running together with the acceptance tests and the coverage report is also generated each time. The problem is that this makes the tests slow which is bad for local development.

To solve this, I would change the setup to have one command for running unit tests, one command for running the acceptance tests and one for generating the test coverage.

The unit tests will be faster, so they can be run often during local development.

I would create a pre-push git hook to run the acceptance tests - if they fail, the push will abort.

As part of the build process I would run all the tests and fail the build if any tests fail.
