/** @jsx React.DOM */

(function () {
  var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

  window.QuestionForm = React.createClass({
    getInitialState: function() {
      return {  answer: "",
                questionText: assignment.questionText,
                questionLevel: assignment.questionLevel,
                difficult: false,
      };
    },
    componentWillMount: function() {
      thisQuestionForm = this;
      $(window).on('markDifficult', function() {
        thisQuestionForm.markDifficult();
      });
      $('.previous-question').on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
        $('.previous-question').removeClass('animated bounce');
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
          <div className="continue">
            <form onSubmit={this.onContinue}>
              <fieldset className="continue-fieldset">
                <div className="row congrats">
                  <div className="large-8 medium-8 small-12 small-centered columns">
                    <p>Congratulations, you have finished this assignment! Want to keep practicing?</p>
                  </div>
                </div>
                <div className="row">
                  <div className="small-6 medium-6 columns">
                    <a className="button radius expand" href="/dashboards">Finished</a>
                  </div>
                  <div className="small-6 medium-6 columns">
                    <button className="radius expand">Keep going!</button>
                  </div>
                </div>
              </fieldset>
            </form>
          </div>
        );
      }
      else {
        var fontSize = 0;
        if (this.state.questionText.length < 12) {
          fontSize = {"font-size": "3em"};
        }
        else if (this.state.questionText.length < 30) {
          fontSize = {"font-size": "2em"};
        }
        else {
          fontSize = {"font-size": "1em"};
        }
        return (
          <div className="question">
            <form onSubmit={this.onSubmit}>
              <fieldset className="question-fieldset">
                <legend>Problem #{assignment.questionsAnswered + 1}</legend>
                <div className="row">
                  <div style={fontSize} className="small-10 medium-8 columns small-centered question-text">
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
                    <button className="radius expand">Submit</button>
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
      }
      else{
        this.state.difficult=false;
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
        <div className="panel difficult">
          <p>Is this problem difficult?</p>
          <label className="switch-light switch-candy switch-candy-blue" onChange={this.onClick}>
            <input type="checkbox" checked={this.state.difficult} />
            <span>
              <span>No</span>
              <span>Yes</span>
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
          <div className="row"><h4>Streaks</h4></div>
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

  window.PreviousQuestion = React.createClass({
    getInitialState: function() {
      return {
        previousQuestionText: assignment.previousQuestionText,
        previousCorrect: assignment.previousCorrect,
        previousResponse: assignment.previousReponse,
        previousAnswer: assignment.previousAnswer
      }
    },
    render: function() {

      if (this.state.previousCorrect === true) {
        return (
          <div className="previous-question previous-correct panel">
            <i className="fa fa-check fa-3x"></i>&nbsp;&nbsp;&nbsp;<h3 className="correct-message">Correct!</h3>
          </div>
        )
      }
      else if (this.state.previousCorrect === false) {
        return (
          <div className="previous-question previous-incorrect panel">
            <p><strong>Previous question:</strong> {this.state.previousQuestionText}<br></br>
            <strong>Answer:</strong> {this.state.previousAnswer}</p>
          </div>
        );
      }
      else {
        return (
          <div className="previous-question previous-start"><h3>Let's get started!</h3></div>
        )
      }
    }
  });
})();


