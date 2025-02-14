class Project < ApplicationRecord
  belongs_to :user


  enum status: { in_progress: 0, completed: 1, pending: 2 }

  validates :title, presence: true
  validates :status, presence: true
end
