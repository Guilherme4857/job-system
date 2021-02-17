class JobsController < ApplicationController
  before_action :authenticate_employee!, only: %i[destroy update create new edit]

  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  
end
