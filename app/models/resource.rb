class Resource < ActiveRecord::Base
  attr_accessible :name, :capacity

  has_many :tasks
end
