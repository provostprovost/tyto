require '../lib/tyto.rb'
Tyto.db_class = Tyto::Database::Persistence
Tyto.env = 'development'
Tyto.db.seed_database
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
