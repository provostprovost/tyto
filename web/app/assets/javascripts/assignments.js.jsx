/** @jsx React.DOM */
$(function() {
var Question = React.createClass({
  render: function() {
    // get result.question, render it as new question
    return (
      <p> whats good brian </p>
    );
  }
});

// proficiency array for D3
console.log("hello");
var Progress = React.createClass({
  render: function() {
    return (
      <p> whats good brian </p>
    );
  }
});

var Streaks = React.createClass({
  render: function() {
    return (
      <p> whats good brian </p>
    );
  }
});

var Assignment = React.createClass({
  getInitialState: function() {
    return {  id: 0,
              questionText: "",
              answer: "",
              questionsAnswered: 0,
              assignmentSize: 0,
              currentStreak: 0,
              longestStreak: 0 };
  },

  componentDidMount: function() {
    $.getJSON(document.URL, function(result) {
      this.setState({
              id: result.id,
              questionText: result.current_question_text,
              answer: "",
              questionsAnswered: result.questions_answered,
              assignmentSize: result.assignment_size,
              currentStreak: result.current_streak,
              longestStreak: result.longest_streak
      });
    }.bind(this));
  },

  onChange: function(e) {
    this.setState({ answer: e.target.value });
  },
  handleSubmit: function(e) {
    e.preventDefault();
    params = {answer: this.state.answer,
              assignment_id: this.state.id};
    //           questionText: result.question.question
    //           // answer: "",
    //           // questionsAnswered: result.number_answered,
    //           // currentStreak: result.current_streak,
    //           // longestStreak: result.longest_streak
    //   });
    // });
      $.ajax({
        url: '/responses/create',
        dataType: 'json',
        type: 'POST',
        data: params,
        success: function(data) {
          result = data.table
          this.setState({questionText: result.question.question,
                         answer: "",
                         questionsAnswered: result.number_answered,
                         currentStreak: result.current_streak,
                         longestStreak: result.longest_streak
          });
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
  },
  render: function() {
    return (
      <div>
        <h3>Answer Question</h3>
        {this.state.questionText}
        <form onSubmit={this.handleSubmit}>
          <input onChange={this.onChange} value={this.state.answer} />
          <button>Submit</button>
        </form>
      </div>
    );
  }
});


React.renderComponent(
  <Assignment />,
  document.getElementById('question')
);
});




