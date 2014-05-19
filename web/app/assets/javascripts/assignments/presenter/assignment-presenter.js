(function () {
  window.AssignmentPresenter = function (options){
    this.questionForm = options.questionForm;
    this.chart = options.chart;
    this.progress = options.progress;
    this.streaks = options.streaks;
    this.model = options.model;

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
              var proficiency = Math.max.apply(null, result.proficiencies);
              console.log(proficiency);
              assignment.questionText = result.question.questionText;
              assignment.questionsAnswered = result.number_answered;
              assignment.currentStreak = result.current_streak;
              assignment.longestStreak = result.longest_streak;
              assignment.proficiency = proficiency;
              assignment.questionLevel = result.question.level;
              assignment.proficiencies = result.proficiencies;
              assignment.complete = result.complete;
              presenter.questionForm.setState({questionText: result.question.question,
                                          answer: "",
                                          questionLevel: result.question.level,
                                          difficult: false,
              });
              presenter.chart.setState({proficiencies: result.proficiencies
              });
              presenter.progress.setState({questionsAnswered: result.number_answered,
                                          proficiency: assignment.proficiency
              });
              presenter.streaks.setState({currentStreak: result.current_streak,
                                          longestStreak: result.longest_streak
              });


            }
          });
        }
      }
    });
  }
})();













