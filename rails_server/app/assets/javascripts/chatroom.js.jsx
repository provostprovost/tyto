/** @jsx React.DOM */
$(document).ready(function() {
        $('.chatFixed').click(function() {
                $('.chatBox').slideToggle("fast");
        });


});

  var ws = new WebSocket("ws://fierce-tundra-6534.herokuapp.com/");
  ws.onmessage = function(message) {
    var data = JSON.parse(message.data);
  };
  window.ChatBox = React.createClass({
    getInitialState: function() {
    return {classrooms: [], selectedIndex: 0, message: ''};
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
    handleSubmit: function(e){
      e.preventDefault();
    },
    handleMessageChange: function(e){
      this.setState({message: e.target.value })
      console.log(e.target.value)
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
        <div className="reactChatBox">
          <div className="topChatBar row">
                <select className="classroomList" onChange={this.handleChatChange}>
                  {classrooms}
                </select>
          </div>
          <div className="chatMessages">
            {messages}
          </div>
          <div className="chatInput row">
            <form onSubmit={this.handleSubmit}>
              <input type="text" placeholder="start chatting" value={this.state.message} onChange={this.handleMessageChange} />
            </form>
          </div>
        </div>
        );
    }
  });



