module Tyto
  class Entity
    def initialize(attrs={})
      include ActiveModel::Validations
      attrs.each do |attr_name, value|
        setter = "#{attr_name}="
        self.send(setter, value) if self.class.method_defined?(setter)
      end
    end
  end
end
