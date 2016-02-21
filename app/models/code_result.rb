# == Schema Information
#
# Table name: code_results
#
#  id               :integer          not null, primary key
#  actual_output    :text
#  expected_output  :text
#  submit_id        :integer
#  test_case_id     :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  evaluator_status :integer
#  status           :integer
#  code_errors      :text
#  id              :integer          not null, primary key
#  actual_output   :text
#  expected_output :text
#  passed          :integer
#  has_errors      :boolean
#  submit_id       :integer
#  test_case_id    :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CodeResult < ActiveRecord::Base
  belongs_to :submit
  belongs_to :test_case

  enum evaluator_status: [:ok, :error, :timeout]
  enum status: [:passed, :wrong, :code_timeout]
end
