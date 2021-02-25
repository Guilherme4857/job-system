class JobsController < ApplicationController
  def index
    @jobs = Job.all_enable
    @level = Level.model_name.human
    @company = Company.model_name.human
  end

  def show
    @job = Job.find(params[:id])
    @level = Level.model_name.human
  end 
end
