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

  window.Chart = React.createClass({
    getInitialState: function() {
      return { proficiencies: assignment.proficiencies};
    },
    render: function() {
      var ctx = document.getElementById("chart").getContext("2d");
      var chart = new Chart(ctx);
      console.log(this.state.proficiencies);
      return (
        <canvas id="chart-canvas" width="300" height="200"></canvas>
      );
    }
  });

  window.Progress = React.createClass({
    getInitialState: function() {
      return { proficiency: assignment.proficiency, proficiencies: assignment.proficiencies};
    },
    render: function() {
      var barWidth = Math.min((this.state.proficiency * 100), 100) + "%";
      var barStyle = {width: barWidth};
      var barColor = "";
      console.log(this);
      if (this.state.proficiencies[this.state.proficiencies.length - 1] === this.state.proficiency) {
        barColor = "success";
      }
      else if (this.state.proficiencies[this.state.proficiencies.length - 1] < this.state.proficiencies[this.state.proficiencies.length - 2]) {
        barColor = "secondary";
      }
      var divClass = "progress small-12 round " + barColor;
      return (
        <div className={divClass} >
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
})();


