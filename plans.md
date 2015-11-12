# Snap<em>!</em> Autograder Site Plans

## Key Features
* Maintain a bank of problems, which have:
	* text/html w/ images
	* An autograder file / evaluator
	* Metadata - difficulty, tags, etc.
* Supports LTI
* Problems are backed by an API
	* Easy importing and exporting
* Usage data is anonymously logged
	* Test results are logged to a DB
	* Code is saved (lower priority)
* Someday: Users can track progress?
	* Maybe supports SSO to use w/ Snap<em>!</em>Cloud ?
* Someday: Background grading API
	* Upload a file and get results back later...

## Key Dev Goals 
* Use Snap<i>!</i> as a library
* Use the existing autograder as a library.
* A "standalone" autograder should be available.
	* It should still log data.