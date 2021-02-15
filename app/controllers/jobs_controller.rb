class JobsController < ApplicationController
  before_action :authenticate_employee!, only: %i[destroy update create new edit]

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
      redirect_to @job
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
    edited_job = params.require(:job).permit(:title, :description, :pay_scale, 
                                       :level, :requirements, :expiration_date, 
                                       :job_openings)
    if @job.update(edited_job)
      redirect_to @job
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, notice: 'Vaga de Desenvolvedor Ruby deletada com sucesso'
  end
end