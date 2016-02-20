# == Schema Information
#
# Table name: test_cases
#
#  id           :integer          not null, primary key
#  input        :text
#  output       :text
#  challenge_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class TestCase < ActiveRecord::Base
  has_many :code_results
  belongs_to :challenge
end
