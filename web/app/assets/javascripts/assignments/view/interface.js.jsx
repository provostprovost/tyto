/** @jsx React.DOM */

(function () {
  window.QuestionForm = React.createClass({
    getInitialState: function() {
      return { answer: "", questionText: assignment.questionText, questionLevel: assignment.questionLevel};
    },
    render: function() {
      return (
        <div className="question">
          Level: {this.state.questionLevel}<br></br>
          Current Question: {this.state.questionText}
          <form onSubmit={this.onSubmit}>
            <input onChange={this.onChange} value={this.state.answer} />
            <button>Submit</button>
          </form>
        </div>
      );
    },
    onSubmit: function (e) {
      e.preventDefault();
      assignment_id = assignment.id;
      this.props.handleSubmit({answer: this.state.answer, assignment_id: assignment_id});
    },

    onChange: function(e) {
      this.setState({answer: e.target.value})
    }
  });

  window.Chart = React.createClass({
    getInitialState: function() {
      return { proficiencies: assignment.proficiencies};
    },
    render: function() {
      return (
        <div className="chart">
          A cool chart!
        </div>
      );
    }
  });

  window.Progress = React.createClass({
    getInitialState: function() {
      return { proficiency: assignment.proficiency};
    },
    render: function() {
      return (
        <div className="progress">
          Proficiency: {this.state.proficiency}<br></br>
        </div>
      );
    }
  });

  window.Streaks = React.createClass({
    getInitialState: function() {
      return { currentStreak: assignment.currentStreak, longestStreak: assignment.longestStreak};
    },
    render: function() {
      return (
        <div className="streaks">
          Current Streak: {this.state.currentStreak} <br></br>
          Longest Streak: {this.state.longestStreak} <br></br>
        </div>
      );
    }
  });

})();


