require 'spec_helper'

describe Tyto::AnswerQuestion do
  before { Tyto.db.clear_everything }

  before do
      @student = db.create_student( username: "Kool Guy",
                                    password: "supercool500",
                                    email: "koolguy@email.com",
                                    phone_number: '1234567890' )
  end

  it ""

end
