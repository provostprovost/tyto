module Tyto
  class UseCase

    def self.run(inputs)
      self.new.run(inputs)
    end

    def failure(error_sym, data={})
      UseCaseFailure.new(data.merge :error => error_sym)
    end

    def success(data={})
      UseCaseSuccess.new(data)
    end
  end

  class UseCaseFailure < OpenStruct
    def success?
      false
    end
  end

  class UseCaseSuccess < OpenStruct
    def success?
      true
    end
  end
end
