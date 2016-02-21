class TestCasesController < ApplicationController
  def destroy
   @test_case = TestCase.find(params[:id])
   challenge = @test_case.challenge
   @test_case.destroy
   redirect_to challenge_path(challenge)
 end
end
