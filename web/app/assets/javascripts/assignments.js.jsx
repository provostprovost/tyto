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
    return {  id: "",
              questionText: "",
              answer: "",
              questionsAnswered: "",
              assignmentSize: "",
              currentStreak: "",
              longestStreak: "",
              proficiency:"",
              questionLevel:"",
                     };
  },

  componentDidMount: function() {
    $.getJSON(document.URL, function(result) {
      console.log(result)
      this.setState({
              id: result.id,
              questionText: result.current_question_text,
              answer: "",
              questionsAnswered: result.questions_answered,
              assignmentSize: result.assignment_size,
              currentStreak: result.current_streak,
              longestStreak: result.longest_streak,
              proficiency: result.proficiency,
              questionLevel: result.question_level
      });
    }.bind(this));
  },

  onChange: function(e) {
    this.setState({ answer: e.target.value });
  },
  handleSubmit: function(e) {
    e.preventDefault();
    params = {answer: this.state.answer,
              assignment_id: this.state.id}
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
                         longestStreak: result.longest_streak,
                         proficiency: result.response.proficiency,
                         questionLevel: result.question.level,
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
         Current Streak: {this.state.currentStreak}<br></br>
         Longest Streak: {this.state.longestStreak}<br></br>
         Proficiency: {this.state.proficiency} <br></br>
         Level: {this.state.questionLevel}<br></br>
        Current Question: {this.state.questionText}
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




