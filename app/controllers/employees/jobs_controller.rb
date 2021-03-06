class Employees::JobsController < ApplicationController
  before_action :authenticate_employee!, :enables,
                :job_attributes_names, :model_name
  
  def index
    @company = find_company
    @jobs = @company.jobs
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
    job = Job.find(params[:id])
    job.destroy
    redirect_to employees_company_jobs_path(current_employee.company), 
    notice: 'Vaga deletada com sucesso'
  end
  
  def job_disable
    job = Job.find(params[:id])
    job.disable!
    redirect_to employees_company_job_path(current_employee.company, job)
  end
  
  def job_enable
    job = Job.find(params[:id])
    job.enable!
    redirect_to employees_company_job_path(current_employee.company, job)
  end
  
  private

  def enables
    jobs = Job.all_enable
  end

  def job_params
    job = params.require(:job).permit(
      :company_id, :title, :description, :pay_scale, 
      :requirements, :expiration_date, 
      :job_openings, :level_ids
    )
  end
  
  def find_company
    company = current_employee.company
  end

  def model_name
    @opened = Job.model_name.human(count: Job.all)
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