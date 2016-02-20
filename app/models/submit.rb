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
#  language     :string
#

class Submit < ActiveRecord::Base
  has_many :code_results
  belongs_to :challenge

  validates :code, :status, :challenge_id, :language, presence: true

  enum status: [:pending, :evaluating, :passed, :not_passed, :timeout, :error]
end
