module Tyto
  class Entity
    include ActiveModel::Validations

    def initialize(attrs={})
      attrs && attrs.each do |attr, value|
        setter = "#{attr}="
        self.send(setter, value) if self.class.method_defined?(setter)
      end
    end
  end
end
