require 'bcrypt'

module Tyto
  class Student < Entity
    attr_reader :username, :email, :phone_number
    attr_accessor :id, :password_digest
    validates_presence_of :username, :password, :email, :phone_number

    def initialize(attrs)
      @password_digest = BCrypt::Password.create(attrs.delete(:password))
      super(attrs)
    end

    def correct_password?(password)
      @password_digest == password
    end
  end
end
