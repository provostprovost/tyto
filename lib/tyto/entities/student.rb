require 'bcrypt'

module Tyto
  class Student < Entity
    attr_reader :username, :email, :phone_number
    attr_accessor :id, :password_digest
<<<<<<< HEAD
    validates_presence_of :email

    def initialize(attrs)
      @password_digest = BCrypt::Password.create(attrs.delete(:password))
      super(attrs)
    end
=======
    validates_presence_of :username, :email, :phone_number
>>>>>>> 9a9edab5ba626777dc7bdd833b4eb0af68bef224

    def correct_password?(password)
      @password_digest == password
    end
  end
end
