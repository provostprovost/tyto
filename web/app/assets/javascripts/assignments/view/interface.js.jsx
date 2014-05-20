/** @jsx React.DOM */

(function () {
  var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

  window.QuestionForm = React.createClass({
    getInitialState: function() {
      return {  answer: "",
                questionText: assignment.questionText,
                questionLevel: assignment.questionLevel,
                difficult: false };
    },
    componentWillMount: function() {
      thisQuestionForm = this;
      $(window).on('markDifficult', function() {
        thisQuestionForm.markDifficult();
      });
    },
    componentDidMount: function() {
      window.addEventListener('markDifficult', this.markDifficult);
    },
    componentWillUnmount: function() {
      window.removeEventListener('markDifficult', this.markDifficult);
    },
    render: function() {
      if (assignment.complete && !assignment.keepGoing) {
        return (
          <div className="question">
            <form onSubmit={this.onContinue}>
              <fieldset>
                <div className="row">
                  Congratulations, you have finished this assignment! Want to keep practicing?
                </div>
                <div className="row">
                  <div className="small-6 columns">
                    <a className="button round expand" href="/dashboards">Finished</a>
                  </div>
                  <div className="small-6 columns">
                    <button className="round expand">Keep practicing</button>
                  </div>
                </div>
              </fieldset>
            </form>
          </div>
        );
      }
      else {
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
      }
    },
    onContinue: function(e) {
      e.preventDefault();
      this.props.continue({keepGoing: true});
    },
    markDifficult: function() {
      var button = document.getElementById("difficult-button")
      if(this.state.difficult===false){
        this.state.difficult = true;
        // button.className = "hard"
      }
      else{
        this.state.difficult=false;
         // button.className = "easy"
      }
    },
    onSubmit: function (e) {
      e.preventDefault();
      assignment_id = assignment.id;
      $(window).trigger('questionSubmit');
      this.props.handleSubmit({answer: this.state.answer, assignment_id: assignment_id, difficult: this.state.difficult});
    },
    onChange: function(e) {
      this.setState({answer: e.target.value})
    }
  });

  window.Difficult = React.createClass({
    getInitialState: function() {
      return { difficult: false };
    },
    componentWillMount: function() {
      thisDifficult = this;
      $(window).on('questionSubmit', function() {
        thisDifficult.resetSwitch();
      });
    },
    onClick: function() {
      $(window).trigger('markDifficult');
      if (this.state.difficult === false) {
        this.setState({difficult: true});
      }
      else {
        this.setState({difficult: false});
      }
    },
    resetSwitch: function() {
      this.setState({difficult: false});
    },
    render: function() {
      return (
        <div>
          <label className="switch-light switch-candy" onChange={this.onClick}>
            <input type="checkbox" checked={this.state.difficult} />
            <span>
              <span>LOL no</span>
              <span>Difficult?</span>
            </span>
            <a></a>
          </label>
        </div>
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


