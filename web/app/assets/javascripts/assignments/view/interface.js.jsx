/** @jsx React.DOM */

(function () {
  window.QuestionForm = React.createClass({
    render: function() {
      return (
        <div class="question">
          Current Question: {this.state.questionText}
          <form onSubmit={this.onSubmit}>
            <input ref="answer" value={this.state.answer} />
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
          Proficiency: {this.state.proficiency}<br></br>
          Level: {this.state.questionLevel}<br></br>
        </div>
      );
    }
  });

  window.Streaks = React.createClass({
    render: function() {
      return (
        <div class="streaks">
          Current Streak: {this.state.currentStreak}<br></br>
          Longest Streak: {this.state.longestStreak}<br></br>
        </div>
      );
    }
  });

})();


