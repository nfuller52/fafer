## Development setup
#####Generate local database, run migrations, seed database

```sh
$ rails fafer:reset
```
#####Configuration

Environment variables are stored in the `.env.development` file in the root of the directory.

## Run test suite

```sh
$ bundle exec rspec spec/
```

##Development process

### Tools
1. RSpec
2. Capybara
3. FactoryBot
4. ShouldaMatchers
5. Your choice of a text editor
6. PostgreSQL

### Outside-in TDD Process
1. Before beginning a feature, write a "happy path" system test (stored in `spec/system/`
2. That test should fail, continue writing code to make the test not fail until you have created a controller or a model
3. Once a model or controller is created, jump in a level and write unit tests for each

### What to Test
1. System tests should test the "happy path" and not edge cases, unless you're specifically writing code for that edge case.
2. Controller tests should cover
  - Record was created, updated, or deleted
  - Jobs have been queued
  - Emails were sent
  - In general, logic that the controller dictates; any conditionals etc.
3. Controller tests should not cover
  - Instance variables have been set
  - Complex model behavior within the controller; this should be mocked or stubbed.
4. Model tests should cover
  - Rails validations, with shoulda matchers
  - Custom validations
  - Scopes
  - Any method created by the user
5. Model tests should not cover
  - Associations
6. Test all background jobs; stub any model logic which is tested from within the model itself.
7. Test all mailers; stub any model logic which is tested from within the model itself.
8. Helpers with complex processing should be tested, but simple view helpers will be exercised through the system tests.

##Deployment instructions
Heroku CD will deploy the master branch.

TODO: Outline process
