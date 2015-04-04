# feature-config

Introduces Feature class.
Each instance of Feature class is feature configuration, and keeps
* feature name
* state (enabled or disabled)
* also may contain some feature-specific configuration as key-value

Features instantiates at application startup and keeps in memory while application is running.


### Using
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

### Configuring

Place all general configs under config/features as .yml files

```yml
awesome_feature: true
useless_feature: false
not_so_hot_feature: true
```

If you want to configure some features with additional properties
drop .yml file (or files) under config/features/configurations

```yml
awesome_feature:
  host: localhost
  port: 1111
  awesomeness: 'awesome'
```

Also, you can specify which users available the feature, just specify
UserQuery name and value

```yml
awesome_feature:
  ...
    query: 'deposit_range'
    min: 500
    max: 600
```

```
Feature.find('awesome_feature').available_for
=> [1,2,3,4] # array of user ids
```
