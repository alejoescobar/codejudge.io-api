# == Schema Information
#
# Table name: challenges
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Challenge < ActiveRecord::Base
  before_create :set_uid

  has_many :test_cases, dependent: :destroy
  has_many :submits, dependent: :destroy
  belongs_to :user

  validates :name, :user_id, presence: true

  protected
    def set_uid
      while self.uid.blank? or !Challenge.find_by_uid(self.uid).blank?
        self.uid = make_slug( SecureRandom.hex(4))
      end
    end

    def make_slug(input)
      input.to_s.scan(/.{1,4}/).join('-').upcase
    end
end
