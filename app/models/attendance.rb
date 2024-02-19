class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  # Validations
  validates :user, uniqueness: { scope: :event }
end