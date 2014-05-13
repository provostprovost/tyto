/** @jsx React.DOM */

(function () {
  window.QuestionForm = React.createClass({
    getInitialState: function() {
      return { answer: "" };
    },
    render: function() {
      return (
        <div className="question">
          Current Question: {assignment.questionText}
          <form onSubmit={this.onSubmit}>
            <input onChange={this.onChange} placeholder="Hi brian you are a cool guy" />
            <button>Submit</button>
          </form>
        </div>
      );
    },
    onSubmit: function (e) {
      e.preventDefault();
      assignment_id = assignment.id;
      this.props.handleSubmit({answer: this.state.answer, assignment_id: assignment_id});
      this.setState({answer: ""});
    },

    onChange: function(e) {
      this.setState({answer: e.target.value})
    }
  });

  window.Chart = React.createClass({
    render: function() {
      return (
        <div className="chart">
          A cool chart!
        </div>
      );
    }
  });

  window.Progress = React.createClass({
    render: function() {
      return (
        <div className="progress">
          Proficiency: {assignment.proficiency}<br></br>
          Level: {assignment.questionLevel}<br></br>
        </div>
      );
    }
  });

  window.Streaks = React.createClass({
    render: function() {
      return (
        <div className="streaks">
          Current Streak: {assignment.currentStreak}<br></br>
          Longest Streak: {assignment.longestStreak}<br></br>
        </div>
      );
    }
  });

})();


