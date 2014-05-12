(function () {
  window.AssignmentPresenter = function (options){
    this.view = options.view;
    this.model = options.model;
    this.view.setProps({ handleSubmit: function (e){
      e.preventDefault();
      params = {answer: this.state.answer,
              assignment_id: this.state.id}
      str = params.answer.replace(/\s+/g, '');
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
            this.setState({questionText: result.question.question,
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








