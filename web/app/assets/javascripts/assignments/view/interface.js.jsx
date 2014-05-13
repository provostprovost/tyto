/** @jsx React.DOM */

(function () {
  window.QuestionForm = React.createClass({
    render: function() {
      return (
        <div class="question">
          Current Question: {assignment.questionText}
          <form onSubmit={this.onSubmit}>
            <input ref="answer" value={assignment.answer} />
            <button>Submit</button>
          </form>
        </div>
      );
    },
    onSubmit: function (e) {
      e.preventDefault();
      answer = this.refs.answer
      assignment_id = assignment.id
      this.props.handleSubmit({answer: answer, assignment_id: assignment_id});
    }
  });

  window.Chart = React.createClass({
    render: function() {
      return (
        <div class="chart">
          A cool chart!
        </div>
      );
    }
  });

  window.Progress = React.createClass({
    render: function() {
      return (
        <div class="progress">
          Proficiency: {assignment.proficiency}<br></br>
          Level: {assignment.questionLevel}<br></br>
        </div>
      );
    }
  });

  window.Streaks = React.createClass({
    render: function() {
      return (
        <div class="streaks">
          Current Streak: {assignment.currentStreak}<br></br>
          Longest Streak: {assignment.longestStreak}<br></br>
        </div>
      );
    }
  });

})();


