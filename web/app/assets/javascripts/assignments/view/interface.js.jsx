/** @jsx React.DOM */

(function () {
  window.QuestionForm = React.createClass({
    getInitialState: function() {
      return { answer: "", questionText: assignment.questionText, questionLevel: assignment.questionLevel, difficult: false, };
    },
    render: function() {
      return (
        <div className="question">
          <form onSubmit={this.onSubmit}>
            <fieldset>
              <legend>Problem #{assignment.questionsAnswered + 1}</legend>
              <div className="row">
                <div className="small-12 columns question-text">
                  {this.state.questionText}
                </div>
              </div>
              <div className="row">
                <div className="small-12 medium-6 large-8 medium-centered columns">
                  <input type="text" onChange={this.onChange} value={this.state.answer} />
                </div>
              </div>
              <div className="row">
                <div className="small-12 medium-6 large-8 medium-centered columns">
                  <button className="round expand">Submit</button>
                </div>
              </div>
            </fieldset>
          </form>
        </div>
      );
          // <button onClick={this.onClick} id="difficult" className='easy'> Difficult </button>
    },
    onClick: function(e) {
      e.preventDefault;
      var button = document.getElementById("difficult")
      if(this.state.difficult===false){
        this.state.difficult = true;
        button.className = "hard"
      }
      else{
        this.state.difficult=false;
         button.className = "easy"
      }
    },
    onSubmit: function (e) {
      e.preventDefault();
      assignment_id = assignment.id;
      this.props.handleSubmit({answer: this.state.answer, assignment_id: assignment_id, difficult: this.state.difficult});
    },

    onChange: function(e) {
      this.setState({answer: e.target.value})
    }
  });

  window.Progress = React.createClass({
    getInitialState: function() {
      return { proficiency: assignment.proficiency};
    },
    render: function() {
      var barWidth = Math.min((this.state.proficiency * 100), 100) + "%";
      var barStyle = {width: barWidth};
      return (
        <div className="progress small-12 success round">
          <span className="meter" style={barStyle}></span>
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
        <div className="streaks panel">
          <div className="row">Streaks</div>
          <div className="row">
            <div className="small-8 columns">
              Current:
            </div>
            <div className="small-4 columns">
              {this.state.currentStreak}
            </div>
          </div>
          <div className="row">
            <div className="small-8 columns">
              Longest:
            </div>
            <div className="small-4 columns">
              {this.state.longestStreak}
            </div>
          </div>
        </div>
      );
    }
  });

  // window.Chart = React.createClass({
  //   getInitialState: function() {
  //     return { proficiencies: assignment.proficiencies};
  //   },
  //   render: function() {
  //     var ctx = document.getElementById("chart").getContext("2d");
  //     var chart = new Chart(ctx);
  //     console.log(this.state.proficiencies);
  //     return (
  //       <canvas id="chart-canvas" width="300" height="200"></canvas>
  //     );
  //   }
  // });

  var Chart = React.createClass({
    render: function() {
      return (
        <svg width={this.props.width} height={this.props.height}>{this.props.children}</svg>
      );
    }
  });

  var Line = React.createClass({
    getDefaultProps: function() {
      return {
        path: "",
        color: "green",
        width: 3
      }
    },
    render: function() {
      return (
        <path d={this.props.path} stroke={this.props.color} strokeWidth={this.props.width} fill="none" />
      );
    }
  });

  var DataSeries = React.createClass({
    getDefaultProps: function() {
      return{
        data: [],
        interpolate: "cardinal"
      }
    },
    render: function() {
      var yScale = this.props.yScale;
      var xScale = this.props.xScale;
      var path = d3.svg.line()
        .x(function(d) {return xScale(d.x); })
        .y(function(d) {return yScale(d.y); })
        .interpolate(this.props.interpolate);
        console.log(this.props.data);
      return (
        <Line path={path(this.props.data)} color={this.props.color} />
      )
    }
  });

  window.LineChart = React.createClass({
    getInitialState: function() {
      return {proficiencies: assignment.proficiencies}
    },
    getDefaultProps: function() {
      return {
        width: 300,
        height: 200
      }
    },
    render: function() {
      var data = this.state.proficiencies,
          size = { width: this.props.width, height: this.props.height };
          console.log(this);
      var max = _.chain(data)
        .zip()
        .map(function(values) {
          return _.reduce(values, function(memo, value) { return Math.max(memo, value.y); }, 0);
        })
        .max()
        .value();

      var xScale = d3.scale.linear()
        .domain([0, data.length-1])
        .range([0, this.props.width]);

      var yScale = d3.scale.linear()
        .domain([0, max])
        .range([this.props.height, 0]);

      return (
        <Chart width={this.props.width} height={this.props.height}>
          <DataSeries data={this.state.proficiencies} size={size} xScale={xScale} yScale={yScale} ref="series1" color="cornflowerblue" />
        </Chart>
      );
    }
  });
})();


