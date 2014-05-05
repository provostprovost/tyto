module Tyto
  class Entity
    include ActiveModel::Validations

    def initialize(attrs={})
      attrs.each do |attr_name, value|
        setter = "#{attr_name}="
        self.send(setter, value) if self.class.method_defined?(setter)
      end
    end
  end
end
