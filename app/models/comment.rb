class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_paper_trail only: [:text]

  validates :text, presence: true
end
