require '../lib/tyto.rb'

module Tyto
  class Entity
    def persisted?
      !!@id
    end

    def to_key
      [id]
    end
    alias get_key to_key
  end
end
