require 'bcrypt'

module Tyto
  class Teacher < Entity
    attr_reader :username, :email, :phone_number
    attr_accessor :id, :password_digest

    validates_presence_of :username, :email, :phone_number

    def correct_password?(password)
      @password_digest == password
    end
  end
end
