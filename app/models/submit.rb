class Submit < ActiveRecord::Base
  has_many :code_results
  belongs_to :challenge
end
