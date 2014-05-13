(function () {
  window.AssignmentPresenter = function (options){
    this.view = options.views;
    this.model = options.model;

    var presenter = this;

    this.view[0].setProps({
      handleSubmit: function (data){
        console.log(data);
        str = data.answer.replace(/\s+/g, '');
        if(str===''){
          console.log("blank string rejected")
        }
        else{
          $.ajax({
            url: '/responses/create',
            dataType: 'json',
            type: 'POST',
            data: data,
            success: function(data) {
              console.log(data);
              result = data.table;

              assignment.questionText = result.question.questionText;
              assignment.questionsAnswered = result.number_answered;
              assignment.currentStreak = result.current_streak;
              assignment.longestStreak = result.longest_streak;
              assignment.proficiency = result.response.proficiency;
              assignment.questionLevel = result.question.level;
              assignment.proficiencies = result.proficiencies;
              assignment.complete = result.complete;
              presenter.view[0].setState({questionText: result.question.question,
                                          answer: "",
                                          questionLevel: result.question.level
              });
              presenter.view[1].setState({proficiencies: result.proficiencies
              });
              presenter.view[2].setState({questionsAnswered: result.number_answered,
                                          proficiency: result.response.proficiency
              });
              presenter.view[3].setState({currentStreak: result.current_streak,
                                          longestStreak: result.longest_streak
              });
            }
          });
        }
      }
    });
  }
})();













