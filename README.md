# Feature config

Enables fine-grained control of features:

- which features are enabled
- for which users a given feature is enabled

All enabled features are instantiated at application startup and kept in memory 
while the application is running.

Each feature consists of:

* name
* enabled?
* filters with specific configuration

## Install

in `Gemfile`

`gem 'feature-config', github: 'smigit/feature-config'`

## Quickstart

```ruby
wallet = Feature.find('wallet')

wallet.enabled?
=> true

wallet.available.include?(current_user.id)
=> false
```

```ruby
Feature.find('service').properties do |service|
  RestApi::Base.establish_connection(url: service.rest_api_url)
  RestApi::Base.user_agent = service.user_agent
  RestApi::Base.transport = service.transport
end
```

## API Usage

The Feature API is grouped into

- class API (general info on registered features)
- instance API

#### Feature class API

*Check if feature is defined*

```
Feature.defined?('awesome_feature')
=> false
```

*List all features*

```
Feature.names
=> [ 'awesome_feature', 'not_so_hot_feature', 'useless_feature' ]
```

*Find a feature instance by name*

```
awesome_feature = Feature.find('awesome_feature')
=> #<Feature:0x0..>
```

#### Feature instance API

*Test if feature is enabled*

```
awesome_feature.enabled?
=> true
```

*Test if feature is disabled*

```
awesome_feature.disabled?
=> false
```

*Get feature configuration properties*

```
awesome_feature.properties
 => #<Feature::Properties:0x0... @properties={}>
```

First-level properties accessible as instance methods:

```
awesome_feature.properties.min_amount
=> 500
```

## Configuration

Place all general configs under `config/features` as `.yml` files names per category of features.
Example: `casino_features.yml`

```yml
secret_wallet: true
bonus_wallet: false
unlock_bonus: true
```

Features can be configured with additional properties
by creating feature config files under `config/features/configurations`.
Each key should link to a Filter class of the same name
Example: `unlock_bonus_feature.yml`

```yml
bonus:            # name of feature
  available:      # 'available' section contains filters information
    limit:        # name of filter subclass
      value: 500  # filter options
```

Multiple filters supported

```
vip:
  available:
    vip:
      is_vip: true
    currency:
      currency_list:
        - 'USD'
        - 'EUR'
```

This will create Filter class instances for the Feature with the supplied configuration parameters.

- `Feature::Filter::Bonus` : `limit: 500`
- `Feature::Filter::Vip` : `is_vip: true`
- `Feature::Filter::Currency` : `currency_list: ['USD', 'EUR']`

The Feature will aplly all filters to see for which users the Feature applies. Each filter returns a list of users (ids). The intersection of all filter results is the list of users for which the feature will apply (ie. be enabled).


## Dependencies

`rails ~> 3.2.18`

## More info

### Wiki

## Copyright

2015 (c) Offsidegaming.com



