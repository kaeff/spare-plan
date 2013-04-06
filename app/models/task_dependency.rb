class TaskDependency < ActiveRecord::Base
  belongs_to :predecessor, class_name: Task
  belongs_to :successor, class_name: Task
end
