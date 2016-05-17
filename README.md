# PorRelationCallbacks

This gem makes it easy to extract active record callbacks on relations
of an object that do not belong in the active record object. an example
would be any callback that does not manipulate the data of the base
object directly.

[![Build
Status](https://travis-ci.org/jamesmacwilliam/por_relation_callbacks.svg?branch=master)](https://travis-ci.org/jamesmacwilliam/por_relation_callbacks)

[![Code
Climate](https://codeclimate.com/github/jamesmacwilliam/por_relation_callbacks/badges/gpa.svg)](https://codeclimate.com/github/jamesmacwilliam/por_relation_callbacks)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'por_relation_callbacks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install por_relation_callbacks

## Usage

- create a plain old ruby class to house callbacks on relations of an
object (after_add/after_remove) that do not belong in your model for
whatever reason (ie: callbacks aren't manipulating data on the base
model)

- specify your after_add/after_remove actions and which callback these
apply to, ie: if you want these to trigger when we add or subtract from
user.addresses then `callbacks_for :addresses`

- We instantiate the class by passing in the base record (in the above
example an instance of `User` and then pass the params to update the
record

- define the methods used for after_add/after_remove within the class
  just like you would an active record object

- to use, instantiate the class and save it just like you would an
  ActiveRecord Object, SomeClass.new(bas_record,
  some_params).save


```ruby
include PorRelationCallbacks

after_add :my_method_1, :my_method_2
after_remove :my_method_3

callbacks_for :my_relation
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jamesmacwilliam/por_relation_callbacks. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

