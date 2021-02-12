class JobsController < ApplicationController
  def index
    @jobs = Job.all
    @job_attributes = [Job.human_attribute_name("job.description"), Job.human_attribute_name("job.level"),
                       Job.human_attribute_name("job.requirements"), Job.human_attribute_name("job.job_openings"),
                       Job.human_attribute_name("job.expiration_date"), Job.human_attribute_name("job.pay_scale")]
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params.require(:job).permit(:title, :description, :pay_scale, 
                                               :level, :requirements, :expiration_date, 
                                               :job_openings))
    
    if @job.save
      redirect_to @job
    else
      render 'new'
    end
  end

  def show
    @job = Job.find(params[:id])
    @job_attributes = [Job.human_attribute_name("job.description"), Job.human_attribute_name("job.level"),
                       Job.human_attribute_name("job.requirements"), Job.human_attribute_name("job.job_openings"),
                       Job.human_attribute_name("job.expiration_date"), Job.human_attribute_name("job.pay_scale")]
  end
end