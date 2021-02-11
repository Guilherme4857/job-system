class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params.require(:job).permit(:title, :description, :pay_scale, 
                                               :level, :requirements, :expiration_date, 
                                               :job_openings))
                                               
    if @job.save
      redirect_to job_path(@job)
    else
      render 'new'
    end
  end

  def show
    @job = Job.find(params[:id])
  end
end