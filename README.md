# λ : lambda
Lambda is an LTI app for autograding [Snap<em>!</em>][1] programs.

λ maintains a database of questions and submissions, and will allow students to
log in through LTI - which means that their scores can be saved to whatever
LMS you're course is using, like Canvas or edX.

**N.B.** As of 2019, the LTI functionality is in a poor state, but the rest of the app works.

[1]: https://snap.berkeley.edu

## Overview

We have:
* questions
* Submissions
* Users
* AG-Interfaces

## LTI Overview

### Running in Development
If you're developing against a public LMS, like a hosted edX course or Canvas
instance, then you'll need ngrok or another tool to expose your dev environment
to the internet.

The ngrok configuration is mostly setup, but you'll need an API key. Once that
is set, you can use `./launch-lti` to get it running.

### Configurations
LTI Config TODO.

* Launch URL: `https://lambda.cs10.org/lti/sessions`
* Key and Secret: Currently stored on the server :O
* Use `?question_id=X` after the launch URL to load a specific question.

### Custom Parameters
None Yet...
### edX

* Follow edX guide. TODO: get link.

### Canvas (bCourses)
**Note about submitting grades:** Canvas requires you to be in "Student View" for the LTI tool to be able to passback a grade. Get to this through your course's settings.

* Pass the tool 'public' information

---

## Cloning
Clone with `git clone --recursive` to download the snap source as a submodule.

If you've already cloned without `--recursive` do:

* `git submodule init`
* `git submodule update`

## Development Getting Started
Once things are setup, use `./run` to launch Rails and start ngrok. You can skip this if you're not using LTI.

**A working instance (even locally) requires both Redis and Postgres to be running**.

---

## Requirements and Setup
* Ruby version
	* 2.5.5
* System dependencies
	* Postgres
	* Redis
	* `brew install postgres qt redis`
	* OSX Install postgres:
	```sh
	# To have launchd start postgresql at login:
	ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents

	# Then to load postgresql now:
	launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
	```
	* `ngrok` 2 Mac binary is in `bin/`
		* Currently the run script uses `ngrok.yml` with a custom domain.
		* If you don't want to pay, just edit this file.
* Configuration
* Database creation
	* Postgres needs to be running!
	* `rake db:create`
	* `rake db:migrate`
* Database initialization
	* TODO create seeds file
* How to run the test suite

## Start the App:

```sh
foreman start -f Procfile.dev
```

This ensures redis and postgres are running on your dev machine.

## Canvas Testing Configuration
URL: https://bcourses.berkeley.edu/courses/1268501/settings/configurations
