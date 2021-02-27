class JobsController < ApplicationController
  before_action :authenticate_job_seeker!, only: %i[apply_to]
  before_action :job_attributes_names, :models_name

  def index
    @jobs = Job.all_enable
  end

  def show
    @job = Job.find(params[:id])
  end
  
  def apply_to
    job = Job.find(params[:id])
    current_job_seeker.apply_to!(job)
    redirect_to job_path(job), notice: 'Candidatura feita com sucesso'
  end

  def unapply_to
    job = Job.find(params[:id])
    current_job_seeker.unapply_to!(job)
    redirect_to job_path(job), notice: 'Candidatura desfeita com sucesso'
  end

  private
  def models_name
    @company = Company.model_name.human
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
