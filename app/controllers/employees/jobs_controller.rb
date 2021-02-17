class Employees::JobsController < ApplicationController
  before_action :authenticate_employee!, only: %i[destroy update create new edit]

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    
    if @job.save
      redirect_to employees_job_path @job
    else
      render 'new'
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    
    if @job.update(job_params)
      redirect_to employees_job_path(@job)
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to employees_jobs_path, notice: 'Vaga deletada com sucesso'
  end
end


private

def job_params
  job = params.require(:job).permit(:title, :description, :pay_scale, 
                                    :level, :requirements, :expiration_date, 
                                    :job_openings)
end