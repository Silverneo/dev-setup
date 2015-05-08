Under development right now.

# Setup your Linux machine

Inpired by Laptop script from <https://github.com/thoughtbot> 

'Setup' is a simple way to make your unix/linux machine ready for frontend web development.
With this script you can in one click install all tools, that you need for comfortable development on Linux machine. Its like Laptop script but for Linux and frontend ;-)

# Support

It can be used on : 

* Debian (tested)
* Linux Mint (tested)
* Ubuntu (tested)
* Elementary OS (not tested)
  and other deb-based distors

# Install

It's can be installed via curl : 

    bash <(curl -s https://raw.githubusercontent.com/drKraken/setup.sh/master/setup.sh)

If you dont have curl installed : 

    sudo apt-get install curl;
    bash <(curl -s https://raw.githubusercontent.com/drKraken/setup.sh/master/setup.sh)

If you want to make it executable as a command line function

    curl -L https://raw.githubusercontent.com/drKraken/setup.sh/master/setup.sh -o /usr/local/bin/setup-sh && chmod +x /usr/local/bin/setup-sh



# Usage 

If you have a trouble on your machine you can view ~/.fds-log.log or send me mail with your error type and type of distro.

# Help

If you use linux for front end dev and want to make first set up more comfortable, you can help me to make this script more useful. Simply mail me with your advice.

I need help of people that use **Fedora**, **Arch** and other linux distros to make this script work for these.

# Included

Script will install for you : 

General:

* [Node.js with NPM](www.nodejs.org)
* [Ruby]()
* [Sass]()
* [Compass]()
* [Susy]()
* [Breakpoint]()
* [Jekyll]()
* [Git]()
* [ImageMagick]()
* [Surge](http://surge.sh)

Task runners:

* [Gulp]()
* [Grunt]()

Package management:

* [Bower]()

Testing tools:

* [Mocha]()
* [Testem]()
* [Jasmine](https://github.com/jasmine/jasmine-npm)

Frameworks

* [Sails]()
* [Express]()

Editor

* [Sublime Text 2]()

And its will fix some common troubles with compass, ruby, node, grunt/gulp

For the end of installing, you will have ready for development linux machine.
Its open-source and free for usage. Make fun =)

License: MIT
