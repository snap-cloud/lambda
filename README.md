# λ : lambda
> TODO: CodeCov, CI, CodeClimate badges

Lambda is an LTI app for autograding [Snap<em>!</em>][1] programs.

It is currently in active development.

## Overview

We have:
* Problems
* Submissions
* Users
* AG-Interfaces

## API

## Integrations -- TODO
### edX
### Canvas (bCourses)


---

## Cloning
Clone with `git clone --recursive` to download the snap source as a submodule.

If you've already cloned without `--recursive` do:

* `git submodule init`
* `git submodule update`

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [Heroku Local]:

    % heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)

---

#### Rails Doc Suggestions ( TODO )
* Ruby version
	* 2.3.0
* System dependencies
	* Postgres, qt, ngrok
	* `brew install postgres qt ngrok`
	* OSX Install postgres:
	```sh
	# To have launchd start postgresql at login:
	ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents

	# Then to load postgresql now:
	launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
	```
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions

