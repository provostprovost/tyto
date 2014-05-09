require '../lib/tyto.rb'

module Tyto
  class Entity
    def persisted?
      !!@id
    end
  end
end
