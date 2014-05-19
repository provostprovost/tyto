module Tyto
  class AddStudentsToClass < UseCase
    def run(inputs)
     classroom = Tyto.db.get_classroom(inputs[:classroom_id])
     return failure(:classroom_not_found) if classroom == nil
     return failure(:no_students_added) if inputs[:students]==[]
     invites = inputs[:students].map do |x|
        Tyto.db.create_invite(email: x,
                              teacher_id: inputs[:teacher_id].to_i,
                              classroom_id: classroom.id,
                              accepted: false)
     end

     invite_ids = invites.map {|x| x.id}

     success :classroom => classroom, :invites => invites, :invite_ids => invite_ids
   end
  end
end
