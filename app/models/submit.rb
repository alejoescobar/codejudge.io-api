# == Schema Information
#
# Table name: submits
#
#  id           :integer          not null, primary key
#  code         :text
#  status       :integer
#  challenge_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Submit < ActiveRecord::Base
  has_many :code_results
  belongs_to :challenge
end
