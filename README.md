Tyto
====

A classroom assignment management app for creating, assigning and completing classwork and homework. Created by Parth Shah and Brian Provost.

Students
--------
Students have two views:
* A dashboard where they can view a list of their assignments and invitations to classes. They also have access to a chat box for each class they are in so they can discuss problems with teachers and classmates.
* An assignment view where they complete problems in a problem set. Problems increase in difficulty as the student's measured proficiency increases. The assignment is complete when the proficiency score reaches a certain level or when the assigned number of questions are completed. Students can also watch a video on the assignment topic and notify their teacher when a problem is difficult.

Teachers
--------
All of a teacher's functions are performed from their dashboard. They can:
* Assign work to students
* Monitor individual proficiency levels for subjects
* Automatically text selected parents when assignments are created
* Filter class roster by struggling students
* Send messages to classes in a chat window

Tech
----
Server-side: Ruby on Rails, Puma with Faye Websockets, PostgreSQL with ActiveRecord, bcrypt

Client-side: ReactJS, Isotope.js, jQuery, Zurb Foundation

APIs: Twilio, Embedly

Testing: RSpec

Deployment: DigitalOcean, Heroku

Entities
--------
* Assignments
* Chapters (inherits from courses)
* Classrooms
* Courses
* Invites
* Messages
* Questions
* Responses
* Sessions
* Students
* Teachers

Tyto?
-----
Tyto is the genus name for barn owls. Credit for the name goes to Ifu Aniemeka.
