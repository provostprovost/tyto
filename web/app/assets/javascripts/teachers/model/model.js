(function() {
  window.Classroom = function (classroom){
    this.id = classroom.id;
    this.course_id = classroom.course_id;
    this.teacher_id = classroom.teacher_id;
    this.name = classroom.name;
    this.students = {};
    this.assignments = {};
  };
})();

