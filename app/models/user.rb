class User < ApplicationRecord
validates_length_of :name, :allow_blank => false
validates_length_of :number, :minimum => 10, :maximum => 10, :allow_blank => false
  before_save do
    self.number = self.number.gsub(/\s+/, '').prepend("+1")
  end

end
