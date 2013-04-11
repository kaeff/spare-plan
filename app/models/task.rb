class Task < ActiveRecord::Base
  attr_accessible :title, :duration, :project, :resource
  attr_accessor :early_start_date, :early_end_date, :late_start_date, :late_end_date

  belongs_to :project
  belongs_to :resource
  has_many :predecessors, through: :predecessor_dependencies
  has_many :predecessor_dependencies, class_name: "TaskDependency", foreign_key: :successor_id
  has_many :successors, through: :successor_dependencies
  has_many :successor_dependencies, class_name: "TaskDependency", foreign_key: :predecessor_id

  validate :project, presence: true
  validate :title, presence: true


  def duration
    self.attributes["duration"] || 0
  end

  def early_start
    latest_predecessor = self.predecessors.sort_by(&:early_end).last
    latest_predecessor ? latest_predecessor.early_end : 0
  end

  def early_end
    self.early_start + self.duration
  end

  def late_start
    self.late_end - self.duration
  end

  def late_end
    return self.early_end if self.successors.empty?
    earliest_successor = self.successors.sort_by(&:late_start).first
    earliest_successor.late_start
  end

  def free_buffer
    return 0 if self.successors.empty?
    earliest_successor = self.successors.sort_by(&:early_start).first
    earliest_successor.early_start - self.early_end
  end

  def total_buffer
    self.late_start - self.early_start
  end

  def on_critical_path?
    self.free_buffer == 0 && self.total_buffer == 0
  end

  def as_json(*args)
    super methods: [
      :early_start,
      :early_end,
      :late_start,
      :late_end,
      :free_buffer,
      :total_buffer,
      :on_critical_path?,
      :predecessor_ids,
      :successor_ids
    ]
  end
end
