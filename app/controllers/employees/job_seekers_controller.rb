class Employees::JobSeekersController < ApplicationController
  before_action :authenticate_employee!, :job_seeker_attributes_names, 
                :models_names, :job_attributes_names
  
  def index
    @applied_job_seekers = JobSeeker.all_applied_job_seekers(
      current_employee.company
    )
    
  end

  def show
    @job_seeker = job.job_seekers.find(params[:id])
  end

  private
  def models_names
    @job_seeker_model_name = JobSeeker.model_name.human(
      count: JobSeeker.all_applied_job_seekers(
        current_employee.company
      )
    )
  end

  def company
    Company.find(params[:id])
  end

  def job
    company.jobs.find(params[:id])
  end

  def job_seeker_attributes_names
    @email = JobSeeker.human_attribute_name('email')
    @profile_picture = JobSeeker.human_attribute_name('profile_picture')
    @social_name = JobSeeker.human_attribute_name('social_name')
    @cpf = JobSeeker.human_attribute_name('cpf')
    @phone = JobSeeker.human_attribute_name('phone')
    @cv = JobSeeker.human_attribute_name('cv')
  end
  
  def job_attributes_names
    @title = Job.human_attribute_name('title')
    @description = Job.human_attribute_name('description')
    @pay_scale = Job.human_attribute_name('pay_scale')
    @requirements = Job.human_attribute_name('requirements')
    @expiration_date = Job.human_attribute_name('expiration_date')
    @job_openings = Job.human_attribute_name('job_openings')
    @level = Job.human_attribute_name('levels')
  end
end