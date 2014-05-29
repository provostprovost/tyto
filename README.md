Tyto
====

A classroom assignment management app for creating, assigning and completing classwork and homework. Created by [Parth Shah](https://recruit.makersquare.com/?v=pshah5) and [Brian Provost](https://recruit.makersquare.com/?v=bprovost5).

Tech
----
Server-side: Ruby on Rails, Puma with Faye Websockets, PostgreSQL with ActiveRecord, bcrypt

Client-side: ReactJS, Isotope.js, jQuery, Zurb Foundation, Google Analytics

APIs: Twilio, Embedly

Testing: RSpec

Deployment: DigitalOcean, Heroku

![Application Structure](https://raw.github.com/bmprovost/tyto/master/rails_server/app/assets/images/application.png "Application Structure")

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

![Entity Relationship Diagram](https://raw.github.com/bmprovost/tyto/master/rails_server/app/assets/images/entities.png "Entity Relationship Diagram")

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

Measuring Proficiency
---------------------
To measure proficiency, we collect all responses a student has made to questions in a particular chapter. Each response is assigned a weighted value based on whether or not it is correct. Correct responses receive a value of whatever the question difficulty level is, which is a number between +1 and +4. Incorrect responses get a negative or smaller value between -1 for level 1 questions and 0.5 for level 4 questions.

More recent responses are then weighted more strongly using an exponential weighted moving average. This has the effect of making the score climb exponentially, so we take the log of that to make the increase in score look more linear.

If a student has not answered many questions in the topic of the assignment we also scale down the proficiency score of the first few responses.

We consider a score of > 1 to be "proficient." This equates to about 10 consecutive correct responses of increasingly difficult questions, but a teacher can increase the number of questions required to complete the assignment by increasing the number of problems assigned. An assignment is marked complete when a student reaches proficiency or when they reach the number of problems assigned by the teacher.

You can see the code for this in /lib/tyto/database/statistics/proficiency.rb.

### Weaknesses of our algorithm
We think this algorithm is very good for measuring proficiency in performing a specific task, like basic addition, solving for x, etc. It would not be good for measuring *knowledge* like memorized state capitals or dates, so for those type of assignments it would be preferable to assign a specific number of problems rather than relying on our algorithm.

Tyto?
-----
Tyto is the genus name for barn owls. Credit for the name goes to Ifu Aniemeka.
