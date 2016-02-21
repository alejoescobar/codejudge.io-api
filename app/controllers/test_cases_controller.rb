class TestCasesController < ApplicationController
  def destroy
   @test_case = TestCase.find(params[:id])
   challenge = @test_case.challenge
   @test_case.destroy
   redirect_to challenge_path(challenge)
 end
 # def create
 #    @test_case = TestCase.new(test_case_params)
 #    @test_case.challenge_id = params[:test_case_id]
 #    @test_case.save
 #    redirect_to challenge_path(challenge)
 # end
 #  private
 #  def test_case_params
 #    params.require(:test_case).permit(:input,:output)
 #  end
end
