module Tyto
  class Teacher < Entity
    attr_reader :id, :username, :password, :email, :phone_number
    validates_presence_of :username, :password, :email, :phone_number
  end
end
