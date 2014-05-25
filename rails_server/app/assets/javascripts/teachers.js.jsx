/** @jsx React.DOM */
$(document).ready(function()
    {
        $(".classroomTable").tablesorter();
        $("form.createClassroom").on('submit', function(e){
            e.preventDefault();
            classroom = $('#classroomName').val();
            teacherId = $('#teacherId').val();
            courseName = $('#courseName').val();
            React.renderComponent(<StudentList classroomName = {classroom} teacherId = {teacherId} courseName = {courseName} />, document.getElementById('panelcreate'));
        });
        $(".checkbox1").on('click', function(){
          data={student_id: this.dataset.student, text: this.checked, classroom_id: this.dataset.classroom};
          console.log(data);
          $.post("/classrooms/text", data, function(data){
            console.log(data);
          })
        });
});

var AssignHomework = React.createClass({
    getInitialState: function() {
    return {selectedClassroom: '', selectedSubtopic: '', subtopics: [], deadline: ''};
    },
    handleClassroomChange: function(e) {
        this.setState({selectedClassroom: e.target.value});
        $.ajax({
          url: '/chapters/index',
          dataType: 'json',
          type: 'POST',
          data: {name: e.target.value},
          success: function(data) {
            this.setState({subtopics: data});
          }.bind(this),
          error: function(xhr, status, err) {
            console.error(this.props.url, status, err.toString());
          }.bind(this)
        });
    },
    handleSubtopicChange: function(e) {
        this.setState({selectedSubtopic: e.target.value});
    },
    handleDeadlineChange: function(e) {
        this.setState({deadline: e.target.value});
    },
    handleTimeChange: function(e) {
        this.setState({time: e.target.value});
    },
    handleSizeChange: function(e) {
        this.setState({size: e.target.value});
    },
    handleSubmit: function(e) {
        e.preventDefault();
        data = {name: this.state.selectedClassroom,
                chapter_id: this.state.selectedSubtopic,
                day: this.state.deadline,
                time: this.state.time,
                assignment_size: this.state.size,
                teacher_id: $('#teacherId').val()
                };
        $.ajax({
          url: '/assignments/create',
          dataType: 'json',
          type: 'POST',
          data: data,
          success: function(data) {
            location.reload(true);
          }.bind(this),
          error: function(xhr, status, err) {
            console.error(this.props.url, status, err.toString());
          }.bind(this)
        });

    },
    render: function() {
        var classrooms = this.props.classrooms.map(function(classroom) {
          return (
            <option key={classroom} value={classroom}>{classroom}</option>
          );
        });
        var subtopics = this.state.subtopics.map(function(subtopic) {
          return (
            <option key={subtopic.id} value={subtopic.id}>{subtopic.subname}: {subtopic.name}</option>
          );
        });
        var numbers = [];
        for(var i=5; i<31; i++){
            numbers.push(i)
        };
        var sizes = numbers.map(function(i) {
          return (
            <option key={i} value={i}>{i}</option>
          );
        });

        return (
        <div>
          <h5> Assign Homework </h5>
          <form id="AssignHomework" onSubmit={this.handleSubmit}>
            <div className="row">
              <div className="large-12 columns">
                  <select id="classroomChosen" onChange={this.handleClassroomChange}>
                      <option value="" disabled selected>Select Class</option>
                      {classrooms}
                  </select>
              </div>
            </div>
            <div className="row">
              <div className="large-12 columns">
                    <select id="chosenTopic" onChange={this.handleSubtopicChange}>
                      <option value="" disabled selected>Select Topic</option>
                      {subtopics}
                    </select>
              </div>
            </div>
            <div className="row">
                <div className="large-12 columns">
                  <label>Due Date
                    <input onChange={this.handleDeadlineChange} type="date"></input>
                  </label>
                </div>
            </div>
            <div className="row">
              <div className="large-7 columns">
                  <label>Time
                    <input onChange={this.handleTimeChange} type="time"></input>
                  </label>
                </div>
                <div className="large-5 columns">
                  <label>Assignment
                      <select onChange={this.handleSizeChange}>
                          <option value="" disabled selected>Size</option>
                          {sizes}
                      </select>
                  </label>
                </div>
            </div>
            <div className="row">
              <div className="large-12 columns">
                <input type="submit" className="button small radius expand assign" value="Assign"> </input>
              </div>
            </div>
          </form>
        </div>
            );
    }
});

var classroomRow = React.createClass({
    render: function() {
        return (<tr><th colSpan="3">{this.props.classroom}</th></tr>);
    }
});

var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var StudentList = React.createClass({
  getInitialState: function() {
    return {students: [],
            emailField: ''      };
  },
  handleAdd: function() {
    var newstudents = this.state.students.concat(this.state.emailField);
    this.setState({students: newstudents});
    this.setState({emailField: ''});
  },
  handleRemove: function(i) {
    var newstudents = this.state.students;
    newstudents.splice(i, 1);
    this.setState({students: newstudents});
  },
  onChange: function(e) {
    this.setState({emailField: e.target.value});
  },
   handleSubmit: function() {
    if(this.state.students.length === 0){
    }
    else {
    data = {students: this.state.students, name: this.props.classroomName, teacher_id: this.props.teacherId, course_name: this.props.courseName};
    $.ajax({
      url: '/classrooms/create',
      dataType: 'json',
      type: 'POST',
      data: data,
      success: function(data) {
        location.reload(true);
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    })};
  },
  render: function() {
    var message = 'No students have been added.'
    if (this.state.students.length > 0){
           var message = <p>Click on an email to remove from the list!</p>
            };
    var students = this.state.students.map(function(student, i) {
      return (
        <div key={student} onClick={this.handleRemove.bind(this, i)}>
          {student}
        </div>
      );
    }.bind(this));
    return (
      <div>
        <h3>{this.props.classroomName} </h3>
        <h5>{this.props.courseName} </h5>
        <div><input type="text" placeholder="Parent Email:" value={this.state.emailField} onChange={this.onChange}></input><button className="button radius small" onClick={this.handleAdd}>Add Student</button>   <button className="button small" onClick={this.handleSubmit}>Finished adding?</button></div>
        <ReactCSSTransitionGroup transitionName="example">
          <p>{message}</p>
          <div className="panel callout">
          {students}
          </div>
        </ReactCSSTransitionGroup>
      </div>
    );
  }
});

var StudentRow = React.createClass({
  render: function() {
    var name = <span>{this.props.Student.name}</span>;
    var email = "mailto:" + this.props.Student.email;
    return (
        <tr>
            <td>{name}</td>
            <td><a href={email}>Email</a></td>
            <td><a href="#">Text</a></td>
        </tr>
    );
  }
});

var StudentTable = React.createClass({
  render: function() {
    var rows = [];
    var lastclassroom = null;
    this.props.students.forEach(function(Student) {
        if (Student.name.indexOf(this.props.filterText) === -1 || (!Student.struggling && this.props.strugglingOnly)) {
            return;
        }
        if (Student.classroom !== lastclassroom) {
            rows.push(<classroomRow classroom={Student.classroom} key={Student.classroom} />);
        }
        rows.push(<StudentRow Student={Student} key={Student.id} />);
        lastclassroom = Student.classroom;
    }.bind(this));
    return (
        <table className="studentTable">
            <tbody>{rows}</tbody>
        </table>
    );
  }
});

function toTitleCase(str)
{
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
}

var SearchBar = React.createClass({
    handleChange: function() {
        this.props.onUserInput(
            toTitleCase(this.refs.filterTextInput.getDOMNode().value),
            this.refs.strugglingOnlyInput.getDOMNode().checked
        );
    },
    render: function() {
        return (
            <form onSubmit={this.handleSubmit} className="searchFixed">
              <h5> Search Students </h5>
                <input
                    type="text"
                    placeholder="Search..."
                    value={this.props.filterText}
                    ref="filterTextInput"
                    onChange={this.handleChange}>
                </input>
                <p className="filterStruggling">
                    <input
                        type="checkbox"
                        value={this.props.strugglingOnly}
                        ref="strugglingOnlyInput"
                        onChange={this.handleChange}>
                    </input>
                    Struggling Students Only
                </p>
            </form>
        );
    }
});

var FilterableStudentTable = React.createClass({
    getInitialState: function() {
        return {
            filterText: '',
            strugglingOnly: false
        };
    },

    handleUserInput: function(filterText, strugglingOnly) {
        this.setState({
            filterText: filterText,
            strugglingOnly: strugglingOnly
        });
    },

    render: function() {
        return (
            <div>
                <SearchBar
                    filterText={this.state.filterText}
                    strugglingOnly={this.state.strugglingOnly}
                    onUserInput={this.handleUserInput}
                />
                <StudentTable
                    students={this.props.students}
                    filterText={this.state.filterText}
                    strugglingOnly={this.state.strugglingOnly}
                />
            </div>
        );
    }
});











