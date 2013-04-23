class TaskSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :duration,
    :early_start,
    :early_end,
    :late_start,
    :late_end,
    :free_buffer,
    :total_buffer,
    :on_critical_path?,
    :predecessor_ids,
    :successor_ids,
    :project_id,
    :resource_id
end
