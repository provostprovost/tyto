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
              longestStreak: 0,
              proficiency:0,
              questionLevel:1,
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
              proficiencies: result.proficiencies,
              questionLevel: result.question_level
      });
    }.bind(this));
  },

  onChange: function(e) {
    this.setState({ answer: e.target.value });
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var params = {answer: this.state.answer,
              assignment_id: this.state.id }
      $.ajax({
        url: '/responses/create',
        dataType: 'json',
        type: 'POST',
        data: params,
        success: function(data) {
          var result = data.table;
          // console.log(result);
          this.setState({questionText: result.question.question,
                         answer: "",
                         questionsAnswered: result.number_answered,
                         currentStreak: result.current_streak,
                         longestStreak: result.longest_streak,
                         proficiency: result.response.proficiency,
                         proficiencies: result.response.proficiencies,
                         questionLevel: result.question.level,
          });
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
      ///////////////// D3 Test //////////////////
    var data = this.state.proficiencies,
      w = 400,
      h = 200,
      margin = 20,
      y = d3.scale.linear().domain([0, d3.max(data)]).range([0 + margin, h - margin]),
      x = d3.scale.linear().domain([0, data.length]).range([0 + margin, w - margin]);

      var vis = d3.select("#line-graph")
          .append("svg:svg")
          .attr("width", w)
          .attr("height", h);

      var g = vis.append("svg:g")
          .attr("transform", "translate(0, 200)");

      var line = d3.svg.line()
          .x(function(d,i) { return x(i); })
          .y(function(d) { return -1 * y(d); });

      g.append("svg:path").attr("d", line(data));

      g.append("svg:line")
          .attr("x1", x(0))
          .attr("y1", -1 * y(0))
          .attr("x2", x(w))
          .attr("y2", -1 * y(0));

      g.append("svg:line")
          .attr("x1", x(0))
          .attr("y1", -1 * y(0))
          .attr("x2", x(0))
          .attr("y2", -1 * y(d3.max(data)));

      g.selectAll(".xLabel")
          .data(x.ticks(5))
          .enter().append("svg:text")
          .attr("class", "xLabel")
          .text(String)
          .attr("x", function(d) { return x(d) })
          .attr("y", 0)
          .attr("text-anchor", "middle");

      g.selectAll(".yLabel")
          .data(y.ticks(4))
          .enter().append("svg:text")
          .attr("class", "yLabel")
          .text(String)
          .attr("x", 0)
          .attr("y", function(d) { return -1 * y(d) })
          .attr("text-anchor", "right")
          .attr("dy", 4);

      g.selectAll(".xTicks")
          .data(x.ticks(5))
          .enter().append("svg:line")
          .attr("class", "xTicks")
          .attr("x1", function(d) { return x(d); })
          .attr("y1", -1 * y(0))
          .attr("x2", function(d) { return x(d); })
          .attr("y2", -1 * y(-0.3));

      g.selectAll(".yTicks")
          .data(y.ticks(4))
          .enter().append("svg:line")
          .attr("class", "yTicks")
          .attr("y1", function(d) { return -1 * y(d); })
          .attr("x1", x(-0.3))
          .attr("y2", function(d) { return -1 * y(d); })
          .attr("x2", x(0));
          ////////////////////////////////////////////
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




