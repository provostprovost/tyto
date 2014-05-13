(function() {
  window.Assignment = function (assignment){
    this.id = assignment.id;
    this.questionText = assignment.current_question_text;
    this.questionsAnswered = assignment.questions_answered;
    this.assignmentSize = assignment.assignment_size;
    this.currentStreak = assignment.current_streak;
    this.longestStreak = assignment.longest_streak;
    this.proficiency = assignment.proficiency;
    this.questionLevel = assignment.question_level;
    this.proficiencies = assignment.proficiencies;
    this.complete = assignment.complete;
  };
})();

