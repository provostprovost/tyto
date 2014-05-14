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
      return (
        <div className="chart panel">
          <img src="http://placehold.it/300x200"></img>
        </div>
      );
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
          <div class="row">Streaks</div>
          <div class="row">
            <div class="small-8 columns">
              Current:
            </div>
            <div class="small-4 columns">
              {this.state.currentStreak}
            </div>
          </div>
          <div class="row">
            <div class="small-8 columns">
              Longest:
            </div>
            <div class="small-4 columns">
              {this.state.longestStreak}
            </div>
          </div>
        </div>
      );
    }
  });
})();


