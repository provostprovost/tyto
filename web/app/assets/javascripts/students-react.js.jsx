/** @jsx React.DOM **/

(function () {

  var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

  window.ClassroomList = React.createClass({
    getInitialState: function() {
      return {data: []};
    },
    componentWillMount: function() {
      thisClassroomList = this;
      $.ajax({
        url: this.props.url,
        dataType: 'json',
        success: function(data) {
          this.setState({data: data});
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
      $(window).on('inviteSubmit', function(e){
        $.ajax({
          url: thisClassroomList.props.url,
          dataType: 'json',
          success: function(data) {
            thisClassroomList.setState({data: data});
          }.bind(thisClassroomList),
          error: function(xhr, status, err) {
            console.error(thisClassroomList.props.url, status, err.toString());
          }.bind(thisClassroomList)
        });
      });
    },
    componentDidMount: function() {
      window.addEventListener('inviteSubmit', this.handleInviteSubmit);
    },
    componentWillUnmount: function() {
      window.removeEventListener('inviteSubmit', this.handleInviteSubmit);
    },
    handleInviteSubmit: function() {
      this.componentWillMount();
    },
    render: function() {
      var classroomNodes = this.state.data.map(function (classroom) {
        return <Classroom key={classroom.id} name={classroom.course_name}></Classroom>
      });
      return (
        <dl id="filters" className="sub-nav student-sub">
          <dt>Filter:</dt>
          <dd><a data-filter="*" href="#">Show all</a></dd>
          <dd><a data-filter=".complete" href="#">Complete</a></dd>
          <dd className="active"><a data-filter=".incomplete" href="#">Incomplete</a></dd>
          {classroomNodes}
        </dl>
      );
    }
  });

  var Classroom = React.createClass({
    render: function() {
      classroomClass = ".classroom" + this.props.key
      return (
        <dd className="classroom">
          <a data-filter={classroomClass} href="#">{this.props.name}</a>
        </dd>
      );
    }
  });
  window.InviteList = React.createClass({
    getInitialState: function() {
      return {data: []};
    },
    componentWillMount: function() {
      $.ajax({
        url: this.props.url,
        dataType: 'json',
        success: function(data) {
          this.setState({data: data});
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
    },
    handleInviteSubmit: function(data) {
      $.ajax({
        type: "PATCH",
        url: data.url,
        dataType: 'json'
      })
      $(window).trigger('inviteSubmit');
      this.componentWillMount();
    },
    render: function() {
      var thisInviteList = this;
      var inviteNodes = this.state.data.map(function (invite) {
        return <Invite onInviteSubmit={thisInviteList.handleInviteSubmit} key={invite.id} courseName={invite.course_name} teacherName={invite.teacher_name}></Invite>
      });
      return (
        <div className="invite-box">
          <ReactCSSTransitionGroup transitionName="transition">
            {inviteNodes}
          </ReactCSSTransitionGroup>
        </div>
      );
    }
  });
  var Invite = React.createClass({
    handleAccept: function(e) {
      e.preventDefault();
      var url = "/invites/" + this.props.key;
      this.props.onInviteSubmit({url: url, accept: true});
    },
    render: function() {
      return (
        <div className="invite">
          <p className="inviteCourseName">
            {this.props.courseName}
          </p>
          <p className="inviteTeacherName">
            {this.props.teacherName}
          </p>
          <form className="acceptInviteButton" onSubmit={this.handleAccept}>
            <input type="submit" className="button" value="Accept" />
          </form>
        </div>
      );
    }
  });
})();
