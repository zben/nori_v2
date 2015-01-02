NoriV2
====

[![Build Status](https://secure.travis-ci.org/savonrb/nori_v2.png)](http://travis-ci.org/savonrb/nori_v2)
[![Gem Version](https://badge.fury.io/rb/nori_v2.png)](http://badge.fury.io/rb/nori_v2)
[![Code Climate](https://codeclimate.com/github/savonrb/nori_v2.png)](https://codeclimate.com/github/savonrb/nori_v2)
[![Coverage Status](https://coveralls.io/repos/savonrb/nori_v2/badge.png?branch=master)](https://coveralls.io/r/savonrb/nori_v2)


Really simple XML parsing ripped from Crack which ripped it from Merb.  
NoriV2 was created to bypass the stale development of Crack, improve its XML parser  
and fix certain issues.

``` ruby
parser = NoriV2.new
parser.parse("<tag>This is the contents</tag>")
# => { 'tag' => 'This is the contents' }
```

NoriV2 supports pluggable parsers and ships with both REXML and Nokogiri implementations.  
It defaults to Nokogiri since v2.0.0, but you can change it to use REXML via:

``` ruby
NoriV2.new(:parser => :rexml)  # or :nokogiri
```

Make sure Nokogiri is in your LOAD_PATH when parsing XML, because NoriV2 tries to load it  
when it's needed.


Typecasting
-----------

Besides regular typecasting, NoriV2 features somewhat "advanced" typecasting:

* "true" and "false" String values are converted to `TrueClass` and `FalseClass`.
* String values matching xs:time, xs:date and xs:dateTime are converted
  to `Time`, `Date` and `DateTime` objects.

You can disable this feature via:

``` ruby
NoriV2.new(:advanced_typecasting => false)
```


Namespaces
----------

NoriV2 can strip the namespaces from your XML tags. This feature might raise  
problems and is therefore disabled by default. Enable it via:

``` ruby
NoriV2.new(:strip_namespaces => true)
```


XML tags -> Hash keys
---------------------

NoriV2 lets you specify a custom formula to convert XML tags to Hash keys.  
Let me give you an example:

``` ruby
parser = NoriV2.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })

xml = '<userResponse><accountStatus>active</accountStatus></userResponse>'
parser.parse(xml)  # => { :user_response => { :account_status => "active" }
```

Dashes and underscores
----------------------

NoriV2 will automatically convert dashes in tag names to underscores.
For example:

```ruby
parser = NoriV2.new
parser.parse('<any-tag>foo bar</any-tag>')  # => { "any_tag" => "foo bar" }
```

You can control this behavior with the `:convert_dashes_to_underscores` option:

```ruby
parser = NoriV2.new(:convert_dashes_to_underscores => false)
parser.parse('<any-tag>foo bar</any-tag>') # => { "any-tag" => "foo bar" }
```
