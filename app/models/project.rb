class Project < ApplicationRecord
  belongs_to :user
  has_paper_trail  only: [:status]

  enum status: { in_progress: 0, completed: 1, pending: 2 }

  validates :title, presence: true
  validates :status, presence: true
end
