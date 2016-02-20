class CodeResult < ActiveRecord::Base
  belongs_to :submit
  belongs_to :test_case
end
