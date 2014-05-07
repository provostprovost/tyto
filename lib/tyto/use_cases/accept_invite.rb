require 'mail'

module Tyto
  class AcceptInvite < UseCase
    def run(inputs)
      invite = Tyto.db.get_invite_from_email_and_code(inputs[:email], inputs[:code])
   end
  end
end
