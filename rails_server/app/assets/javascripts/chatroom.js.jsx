/** @jsx React.DOM */
$(document).ready(function() {
        $('.chatFixed').click(function() {
                $('.chatBox').slideToggle("fast");
        });


});
  window.ChatBox = React.createClass({
    getInitialState: function() {
    return {classrooms: [], selectedIndex: 0};
    },
    componentWillMount: function() {
      data = {classroom_ids: this.props.classroomIds};
      $.ajax({
        url: '/classrooms/chat',
        dataType: 'json',
        type: 'POST',
        data: data,
        success: function(data) {
          this.setState({classrooms: data});
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
    },
    handleChatChange: function(e){
      this.setState({selectedIndex: e.target.value});
    },
    render: function() {
      var counter = -1;
      var classrooms = this.state.classrooms.map(function(classroom) {
          counter = counter + 1;
          return (
            <option value={counter}>{classroom.name}</option>
          );
        });
      if(this.state.classrooms.length > 0){
      var messages = this.state.classrooms[this.state.selectedIndex].chat.map(function(message) {
          return (
            <p>{message.username}: {message.message}</p>
          );
        })};
      return (
        <div>
          <div className="topChatBar row">
              <div className="small-12 columns">
                <select className="classroomList" onChange={this.handleChatChange}>
                  {classrooms}
                </select>
              </div>
          </div>
          {messages}
        </div>
        );
    }
  });



