(function () {
  window.AssignmentPresenter = function (options){
    this.questionForm = options.questionForm;
    this.difficult = options.difficult;
    this.progress = options.progress;
    this.streaks = options.streaks;
    this.model = options.model;
    this.previousQuestion = options.previousQuestion;

    var presenter = this;

    this.questionForm.setProps({
      handleSubmit: function (data){
        data["answer"] = data["answer"].trim();
        if(data["answer"]===''){
          console.log("blank string rejected")
        }
        else{
          $.ajax({
            url: '/responses/create',
            dataType: 'json',
            type: 'POST',
            data: data,
            success: function(data) {
              var result = data.table;
              assignment.questionText = result.question.questionText;
              assignment.questionsAnswered = result.number_answered;
              assignment.currentStreak = result.current_streak;
              assignment.longestStreak = result.longest_streak;
              assignment.proficiency = Math.max.apply(null, result.proficiencies);
              assignment.questionLevel = result.question.level;
              assignment.proficiencies = result.proficiencies;
              assignment.complete = result.complete;
              assignment.previousQuestionText = result.question_text;
              assignment.previousCorrect = result.response.correct;
              assignment.previousResponse = result.response.answer;
              assignment.previousAnswer = result.answer;
              presenter.questionForm.setState({questionText: result.question.question,
                                          answer: "",
                                          questionLevel: result.question.level,
                                          difficult: false,
                                          keepGoing: assignment.keepGoing
              });
              presenter.progress.setState({questionsAnswered: result.number_answered,
                                          proficiency: Math.max.apply(null, result.proficiencies),
                                          proficiencies: result.proficiencies
              });
              presenter.streaks.setState({currentStreak: result.current_streak,
                                          longestStreak: result.longest_streak
              });
              presenter.questionForm.setState({difficult: false});
              presenter.previousQuestion.setState({ previousQuestionText: result.question_text,
                                                    previousCorrect: result.response.correct,
                                                    previousResponse: result.response.answer,
                                                    previousAnswer: result.answer
              });
              if (result.response.correct) {
                $('.previous-question').addClass('animated pulse');
                $('.previous-question').on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                  $(this).removeClass('animated pulse');
                });
              }
            }
          });
        }
      },
      continue: function(keepGoing) {
        assignment.keepGoing = keepGoing;
        presenter.questionForm.setState({keepGoing: assignment.keepGoing});
      }
    });
  }
})();













