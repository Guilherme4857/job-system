class JobsController < ApplicationController
  before_action :authenticate_job_seeker!, only: %i[apply_to]

  def index
    @jobs = Job.all_enable
    @level = Level.model_name.human
    @company = Company.model_name.human
  end

  def show
    @job = Job.find(params[:id])
    @level = Level.model_name.human
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
end
