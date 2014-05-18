/** @jsx React.DOM */
$(document).ready(function()
    {
        $(".classroomTable").tablesorter();
    }
);

var classroomRow = React.createClass({
    render: function() {
        return (<tr><th colSpan="3">{this.props.classroom}</th></tr>);
    }
});

var studentRow = React.createClass({
    render: function() {
        var name = this.props.Student.struggling ?
            this.props.Student.name :
            <span style={{color: 'red'}}>
                {this.props.Student.name}
            </span>;
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
            if (Student.name.indexOf(this.props.filterText) === -1 || (!Student.struggling && this.props.strugglingOnly)) {
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
            this.refs.filterTextInput.getDOMNode().value,
            this.refs.strugglingOnlyInput.getDOMNode().checked
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


React.renderComponent(<FilterableStudentTable students={window.students} />, document.getElementById('search'));








