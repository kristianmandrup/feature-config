# feature-config

Each instance of Feature class is feature configuration, and keeps
* feature name
* state (enabled or disabled)
* also may contain some feature-specific configuration as key-value

Features are instantiated at application startup and is kept in memory while application is running.

## Install

in `Gemfile`

`gem 'feature-config', github: 'smigit/feature-config'`

## Quickstart

### Usage
```
Feature.find('awesome_feature')
=> #<Feature:0x0..>
```

```
Feature.find('awesome_feature').enabled?
=> true
```

```
Feature.find('awesome_feature').properties
=> { :host => 'localhost', :login => 'login', :log => 'whatever' }
```

Check whether the feature is defined for an application
```
Feature.defined?('awesome_feature')
=> false
```

Or list all features for an application
```
Feature.names
=> [ 'awesome_feature', 'not_so_hot_feature', 'useless_feature' ]
```

Also, first-level properties accessible as instance methods:
```
Feature.find('awesome_feature').log
=> 'whatever'
```

```
Feature.find('awesome_feature').available_for
=> [1,2,3,4] # array of user ids
```

## API

## Dependencies

`rails ~> 3.2.18`

## More info

### Wiki

## Copyright

2015 (c) Offsidegaming.com


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

### Configuration

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
bonus:
  limit: 500
vip: true
```

This will create Filter class instances for the Feature with the supplied configuration parameters.

- `Feature::BonusFilter` : `limit: 500`
- `Feature::VipFilter`

The Feature will aplly all filters to see for which users the Feature applies. Each filter returns a list of users (ids). The intersection of all filter results is the list of users for which the feature will apply (ie. be enabled).

## API Usage

The Feature API is grouped into

- class API (general info on registered features)
- instance API

### Feature class API

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

### Feature instance API

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
=> { :host => 'localhost', :login => 'login', :log => 'whatever' }
```

First-level properties accessible as instance methods:

```
awesome_feature.min_amount
=> 500
```



