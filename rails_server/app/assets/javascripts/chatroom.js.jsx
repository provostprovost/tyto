/** @jsx React.DOM */
$(document).ready(function() {
  $('.chatClick').click(function() {
    $('.chatBox').slideToggle("fast");
    messaging = $('.chatMessages');
    messaging.scrollTop(messaging.prop("scrollHeight"));
    $(".chatClick").css("background-color","#2ba6cb");
  });
  $(window).on('inviteSubmit', function(){
    window.ChattingBox.invitesWillUpdate();
  });
});

var ws = new WebSocket("ws://fierce-tundra-6534.herokuapp.com/");

ws.onmessage = function(message) {
  var data = JSON.parse(message.data);
  classrooms = [];
  ChattingBox.state.classrooms.forEach(function(classroom, index){
    if(classroom.id===data.classroom_id){
      if($('.chatBox').css('display') == 'none'){
        $(".chatClick").css("background-color","#80bd41");
      }
      classroom.chat.push(data);
      ChattingBox.setState({selectedIndex: index});
    }
    classrooms.push(classroom);
  });
  ChattingBox.setState({classrooms: classrooms});
  messaging = $('.chatMessages');
  messaging.scrollTop(messaging.prop("scrollHeight"));
};

window.ChatBox = React.createClass({
  getInitialState: function() {
  return {classrooms: [], selectedIndex: 0, message: ''};
  },
  componentWillMount: function() {
    if(this.props.classroomIds.length > 0){
      data = {classroom_ids: this.props.classroomIds};
      $.ajax({
        url: '/messages/index',
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
    }
  },
  invitesWillUpdate: function(){
    object = {student_id: this.props.id};
    setTimeout(function(){
      $.ajax({
            url: '/classrooms/accepted',
            dataType: 'json',
            type: 'POST',
            data: object,
            success: function(data) {
              window.ChattingBox.setState({classrooms: data});
            }.bind(this),
            error: function(xhr, status, err) {
              console.error(this.props.url, status, err.toString());
            }.bind(this)
          });
    },1000);
  },
  handleChatChange: function(e){
    this.setState({selectedIndex: e.target.value}, function() {
    messaging = $('.chatMessages');
    messaging.scrollTop(messaging.prop("scrollHeight"));
    });
  },
  handleSubmit: function(e){
    e.preventDefault();
    var username = this.props.username;
    var message   = this.state.message;
    var classroom_id = this.state.classrooms[this.state.selectedIndex].id;
    var struggling = this.props.struggling;
    var object = {username: username, message: message, classroom_id: classroom_id, struggling: struggling}
    ws.send(JSON.stringify(object));
    this.setState({message: ''});
    $.ajax({
      url: '/messages/create',
      dataType: 'json',
      type: 'POST',
      data: object,
      success: function(data) {
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  handleMessageChange: function(e){
    this.setState({message: e.target.value })
  },
  render: function() {
    var counter = -1;
    var classrooms = this.state.classrooms.map(function(classroom, index) {
      counter = counter + 1;
      if(index === ChattingBox.state.selectedIndex){
        return (
          <option key={counter} value selected={counter}>{classroom.name}</option>);
      }
      else {
        return(
          <option key={counter} value={counter}>{classroom.name}</option>);
      }
    });
    if(this.state.classrooms.length > 0){
      var messages = this.state.classrooms[this.state.selectedIndex].chat.map(function(message) {
         counter = counter + 1;
        return (
          <p key={counter}>{message.username}: {message.message}</p>
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



