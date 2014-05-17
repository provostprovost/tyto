(function() {
  window.Invite = function(invite) {
    this.id = invite.id;
    this.teacher_id = invite.teacher_id;
    this.classroom_id = invite.classroom_id;
    this.accepted = invite.accepted;
    this.teacher_name = invite.teacher_name;
    this.course_name = invite.course_name;
  };
})();
