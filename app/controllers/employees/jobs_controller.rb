class Employees::JobsController < ApplicationController
  before_action :authenticate_employee! 

  def index
    @company = find_company
    @jobs = @company.jobs
    @level = Level.model_name.human
    @opened = Job.model_name.human(count: Job.all)
  end

  def new
    @job = find_company.jobs.build
    @level = Level.all
  end

  def create
    @job = find_company.jobs.build(job_params)
    if @job.save
      redirect_to employees_company_job_path(current_employee.company, @job)
    else
      render 'new'
    end
  end

  def show
    @company = find_company
    @job = Job.find(params[:id])
    @level = Level.model_name.human
  end

  def edit
    @job = Job.find(params[:id])
    @level = Level.all
  end

  def update
    @job = Job.find(params[:id])
    
    if @job.update(job_params)
      redirect_to employees_company_job_path(current_employee.company, @job)
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to employees_company_jobs_path current_employee.company, 
    notice: 'Vaga deletada com sucesso'
  end
end


private

def job_params
  job = params.require(:job).permit(:company_id, :title, :description, :pay_scale, 
                                    :requirements, :expiration_date, 
                                    :job_openings, :level_ids)
end

def find_company
  company = current_employee.company
end