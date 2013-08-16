wolfram_rule30
======

A Ruby/Javascript app whichalculates [Wolfram's Rule 30](http://en.wikipedia.org/wiki/Rule_30). 
A running example can be found [here](http://serene-bayou-1556.herokuapp.com/).

To clone, run
> git clone https://github.com/meekrabR6R/wolfram_rule30.git 

from the console in desired directory.

To install dependencies, run
> bundle install

in the root directory of the app. If Bundler is not installed, it can be installed by running
> gem install bundler

Dependencies include:
1. sinatra
2. rack
3. json
4. rspec

After dependencies are installed, to run app locally, run
> ruby routes.rb

from the root directory of the app, and open localhost with assigned port (usually 4567) in browser.


The code which calculates the the cell on/off statuses according to Rule 30 can be found in line_maker.rb, which
is in the app's root. The code which handles the client-side line display and event handling can be found in
public/js/rule_process.js. Tests (for all of the Ruby code) can be found in spec.
