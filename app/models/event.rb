class Event < ApplicationRecord
  #table N-1  Class_name
  belongs_to :admin_user, class_name: 'User'

  # table N-N Class_name through
  has_many :attendances
  has_many :users, through: :attendances

  # validation
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }, if: :is_multiple_of_5?
  validates :title, presence: true,  length: {maximum:140}
  validates :description, presence: true, length: {minimum:20, maximum:1000}
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true

  # Start_date: pas possible de creer modifier une date dans le passé
  # duration multiple de 5

  private
  def is_multiple_of_5?
    (duration % 5).zero?
  end

end
