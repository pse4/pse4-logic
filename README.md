pse4-logic
==========

The logic part of group 4's PSE project.

1. Install Ruby 1.9+, and [download](http://rubyinstaller.org/downloads/) and [install](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit) the devkit (don't forget ruby dk.rb init/install, and when manually editing the config.yml, prefix the absolute path with "-").
2. `gem install bundler`
3. `bundle install`
4. run with `ruby test.rb`, 
5. view documentation with `yard server --reload`, then navigate to http://localhost:8808

#For developers:#
* [Bundler (gemfile)]( http://gembundler.com/rationale.html )
* [YARD]( http://rubydoc.info/docs/yard/file/docs/GettingStarted.md )
* [MongoDB]( http://www.mongodb.org/ ), [on ruby]( http://rubylearning.com/blog/2010/12/21/being-awesome-with-the-mongodb-ruby-driver/ ), [getting started](https://github.com/mongodb/mongo-ruby-driver/wiki/Tutorial)
The [system.index collection](http://docs.mongodb.org/manual/reference/system-collections/) is used internally, [interactive tutorial](http://try.mongodb.org/).

* Should we ask for the DevKit to be installed as well so we can use `bson_ext` which supposedly makes things run faster?
