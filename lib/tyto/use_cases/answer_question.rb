module Tyto
  class AnswerQuestion < UseCase
    def run(inputs)
      session = Tyto.db.get_session(inputs[:session_id])

      return failure :session_not_found if session.nil?

      student = Tyto.db.get_student(session.student_id)
      assignment = Tyto.db.get_assignment(inputs[:assignment_id])

      return failure :assignment_not_found if assignment.nil?
      return failure :assignment_not_valid if assignment.student_id != student.id

      question = Tyto.db.get_question(inputs[:question_id])

      return failure :question_not_found if question.nil?

      response = Tyto.db.create_response( question_id: question.id,
                                          student_id:  student.id,
                                          assignment_id: assignment.id,
                                          difficult: inputs[:difficult],
                                          correct: check_answer(question.id, inputs[:answer]),
                                          chapter_id: assignment.chapter_id )

      next_question = Tyto.db.get_next_question(  response.proficiency,
                                                  student.id,
                                                  assignment.chapter_id)

      questions_completed = Tyto.db.get_responses_for_assignment(assignment.id)

      number_answered = questions_completed.size

      complete = number_answered >= assignment.assignment_size

      success :response => response,
              :question => next_question,
              :complete => complete,
              :number_answered => number_answered
    end

    def check_answer(question_id, answer)
      answer.downcase == Tyto.db.get_question(question_id).answer.downcase
    end
  end
end
