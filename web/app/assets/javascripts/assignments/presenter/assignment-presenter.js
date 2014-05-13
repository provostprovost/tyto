(function () {
  window.AssignmentPresenter = function (options){
    this.view = options.views[0];
    this.model = options.model;

    var presenter = this;

    this.view.setProps({ handleSubmit: function (data){
      // e.preventDefault();

      str = data.answer.replace(/\s+/g, '');
      if(str===''){
        console.log("blank string rejected")
      }
      else{
        $.ajax({
          url: '/responses/create',
          dataType: 'json',
          type: 'POST',
          data: params,
          success: function(data) {
            result = data.table
            presenter.view.setState({questionText: result.question.question,
                           questionsAnswered: result.number_answered,
                           currentStreak: result.current_streak,
                           longestStreak: result.longest_streak,
                           proficiency: result.response.proficiency,
                           questionLevel: result.question.level,
                           answer: "",
                           submittedAnswer: result.response.answer
                          });
          }
        });
      }
    }
  });
  }
})();








