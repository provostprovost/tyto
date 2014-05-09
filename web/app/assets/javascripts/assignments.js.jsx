/** @jsx React.DOM */
var Question = React.createClass({
  render: function() {
    // get result.question, render it as new question
    // return (

    // );
  }
});

// proficiency array for D3
console.log("hello");
var Progress = React.createClass({
  render: function() {
    // return (

    // );
  }
});

var Streaks = React.createClass({
  render: function() {

  }
});

var Assignment = React.createClass({
  getInitialState: function() {
    return {  questionText: "",
              answer: "",
              questionsAnswered: 0,
              assignmentSize: 5,
              currentStreak: 0,
              longestStreak: 5 };
  },
  onChange: function(e) {
    this.setState({ answer: e.target.value });
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var nextQuestionText = "";//get next question
    var nextQuestionsAnswered = 1;//get next questions answered
    var nextCurrentStreak = 2;//get current streak
    var nextLongestStreak = 3;//get longest streak
    this.setState({ questionText: nextQuestionText,
                    answer: "",
                    questionsAnswered: nextQuestionsAnswered,
                    currentStreak: nextCurrentStreak,
                    longestStreak: nextLongestStreak });
  },
  render: function() {
    // return (

    // );
  }
});
