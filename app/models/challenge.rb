class Challenge < ActiveRecord::Base
  has_many :test_cases
  has_many :submits
  belongs_to :user
end
