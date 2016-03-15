# Expect

## Installation

    gem install expectations

## Presentation

A short presentation is hosted at [Github](http://radiospiel.github.com/expectation).

## Documentation

Documentation is available at [rubydoc.info](http://rubydoc.info/gems/expectation).

## Getting started

This function expects a String argument starting with "http:", an Integer or Float argument, and a Hash
with a String entry at key `:foo`, and either an Array or nil at key `:bar`.

    def function(a, b, options = {})
      expect! a => /^http:/, 
              b => [Integer, Float], 
              options => {
                :foo => String,
                :bar => [ Array, nil ]
              }
    end
    
## License

The expectations gem is distributed under the terms of the Modified BSD License, see LICENSE.BSD for details.
