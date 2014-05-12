(function () {
  window.AssignmentPresenter = function (options){
    this.view = options.view;
    this.model = options.model;
    this.updateView = function(data) {
      // ajax
      // update model
      // view.setState(...)
    };

    this.view.setProps({ handleSubmit:  this.updateviewcallback })
  };




}
