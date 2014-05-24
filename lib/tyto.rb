require 'ostruct'
require 'active_model'

require_relative 'tyto/entity.rb'
require_relative 'tyto/entities/assignment.rb'
require_relative 'tyto/entities/course.rb'
require_relative 'tyto/entities/chapter.rb'
require_relative 'tyto/entities/class.rb'
require_relative 'tyto/entities/question.rb'
require_relative 'tyto/entities/response.rb'
require_relative 'tyto/entities/session.rb'
require_relative 'tyto/entities/student.rb'
require_relative 'tyto/entities/teacher.rb'
require_relative 'tyto/entities/invite.rb'
require_relative 'tyto/entities/message.rb'

require_relative 'tyto/databases/in_memory.rb'
require_relative 'tyto/databases/sqlite.rb'

require_relative 'tyto/use_case.rb'
require_relative 'tyto/use_cases/answer_question.rb'
require_relative 'tyto/use_cases/sign_in.rb'
require_relative 'tyto/use_cases/student_sign_up.rb'
require_relative 'tyto/use_cases/teacher_sign_up.rb'
require_relative 'tyto/use_cases/assign_homework.rb'
require_relative 'tyto/use_cases/add_students_to_class.rb'
require_relative 'tyto/use_cases/accept_invite.rb'
require_relative 'tyto/use_cases/update_teacher.rb'
require_relative 'tyto/use_cases/update_student.rb'

module Tyto
  def self.db
    @__db_instance ||= @db_class.new(@env || 'test')
  end

  def self.db_class=(db_class)
    @db_class = db_class
  end

  def self.env=(env_name)
    @env = env_name
  end
end
