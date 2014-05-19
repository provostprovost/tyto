/** @jsx React.DOM */
$(document).ready(function()
    {
        $(".classroomTable").tablesorter();
        $("form.createClassroom").on('submit', function(e){
            e.preventDefault();
            console.log("hello");
            React.renderComponent(<StudentList />, document.getElementById('panelcreate'));
        });
    });

var classroomRow = React.createClass({
    render: function() {
        return (<tr><th colSpan="3">{this.props.classroom}</th></tr>);
    }
});

var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var StudentList = React.createClass({
  getInitialState: function() {
    return {students: ["pss8te@virginia.edu"],
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
    console.log(this.state.students);
  },
  onChange: function(e) {
    this.setState({emailField: e.target.value});
  },
  render: function() {
    console.log(this.state.students)
    var students = this.state.students.map(function(student, i) {
      return (
        <div key={student} onClick={this.handleRemove.bind(this, i)}>
          {student}
        </div>
      );
    }.bind(this));
    return (
      <div>
        <div><input type="text" placeholder="Parent Email:" value={this.state.emailField} onChange={this.onChange}></input><button className="button small" onClick={this.handleAdd}>Add Student</button></div>
        <ReactCSSTransitionGroup transitionName="example">
          {students}
        </ReactCSSTransitionGroup>
      </div>
    );
  }
});

var studentRow = React.createClass({
    render: function() {
        var name = <span>{this.props.Student.name}</span>
        if(this.props.Student.struggling === true){
            name = <span style={{color: 'red'}}>{this.props.Student.name}</span>;
        }
        else if(this.props.Student.late === true){
            name = <span style={{color: 'orange'}}>{this.props.Student.name}</span>;
        }
        return (
            <tr>
                <td>{name}</td>
                <td><a href={this.props.Student.Email}>Email</a></td>
                <td><a href="#">Text</a></td>
            </tr>
        );
    }
});

var StudentTable = React.createClass({
    render: function() {
        console.log(this.props);
        var rows = [];
        var lastclassroom = null;
        this.props.students.forEach(function(Student) {
            if (Student.name.indexOf(this.props.filterText) === -1 || (!Student.struggling && this.props.strugglingOnly)||(!Student.late && this.props.lateOnly)) {
                return;
            }
            if (Student.classroom !== lastclassroom) {
                rows.push(<classroomRow classroom={Student.classroom} key={Student.classroom} />);
            }
            rows.push(<studentRow Student={Student} key={Student.id} />);
            lastclassroom = Student.classroom;
        }.bind(this));
        return (
            <table className="studentTable">
                <tbody>{rows}</tbody>
            </table>
        );
    }
});

var SearchBar = React.createClass({
    handleChange: function() {
        this.props.onUserInput(
            this.refs.filterTextInput.getDOMNode().value.charAt(0).toUpperCase() + string.slice(1),
            this.refs.strugglingOnlyInput.getDOMNode().checked,
            this.refs.lateOnlyInput.getDOMNode().checked
        );
    },
    render: function() {
        return (
            <form onSubmit={this.handleSubmit}>
                <input
                    type="text"
                    placeholder="Search..."
                    value={this.props.filterText}
                    ref="filterTextInput"
                    onChange={this.handleChange}
                />
                <p>
                    <input
                        type="checkbox"
                        value={this.props.strugglingOnly}
                        ref="strugglingOnlyInput"
                        onChange={this.handleChange}
                    />
                    Only show struggling students
                </p>
                <p>
                 <input
                        type="checkbox"
                        value={this.props.lateOnly}
                        ref="lateOnlyInput"
                        onChange={this.handleChange}
                    />
                    Only show students not completing work
                </p>
            </form>
        );
    }
});

var FilterableStudentTable = React.createClass({
    getInitialState: function() {
        return {
            filterText: '',
            strugglingOnly: false,
            lateOnly: false
        };
    },

    handleUserInput: function(filterText, strugglingOnly, lateOnly) {
        this.setState({
            filterText: filterText,
            strugglingOnly: strugglingOnly,
            lateOnly: lateOnly
        });
    },

    render: function() {
        return (
            <div>
                <SearchBar
                    filterText={this.state.filterText}
                    strugglingOnly={this.state.strugglingOnly}
                    lateOnly={this.state.lateOnly}
                    onUserInput={this.handleUserInput}
                />
                <StudentTable
                    students={this.props.students}
                    filterText={this.state.filterText}
                    strugglingOnly={this.state.strugglingOnly}
                    lateOnly={this.state.lateOnly}
                />
            </div>
        );
    }
});


React.renderComponent(<FilterableStudentTable students={window.studentsAll} />, document.getElementById('search'));










