class Analytic < ApplicationRecord
  belongs_to :user

  validates :search, presence: true, length: { maximum: 500 }
end
