# == Schema Information
#
# Table name: challenges
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Challenge < ActiveRecord::Base
  has_many :test_cases, dependent: :destroy
  has_many :submits, dependent: :destroy
  belongs_to :user

  validates :name, :user_id, presence: true
end
