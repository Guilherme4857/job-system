class JobsController < ApplicationController
  def index
    @jobs = Job.all
    @level = Level.model_name.human
  end

  def show
    @job = Job.find(params[:id])
    @level = Level.model_name.human
  end 
end
