class Task < ActiveRecord::Base
  belongs_to :project

  validates :title, presence: true

  scope :pending,   -> { where(completed: false) }
  scope :completed, -> { where(completed: true)  }

end
