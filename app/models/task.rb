class Task < ActiveRecord::Base
  attr_accessible :title, :duration

  belongs_to :project
  belongs_to :resource
  has_many :predecessors, through: :predecessor_dependencies
  has_many :predecessor_dependencies, class_name: "TaskDependency", foreign_key: :successor_id
  has_many :successors, through: :successor_dependencies
  has_many :successor_dependencies, class_name: "TaskDependency", foreign_key: :predecessor_id
end
