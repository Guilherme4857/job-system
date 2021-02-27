class Employees::JobSeekersController < ApplicationController
  before_action :authenticate_employee!
  before_action :attributes_names
  def index
    @applied_job_seekers = JobSeeker.all_applied_job_seekers(current_employee.company)
    @job_seeker_model_name = JobSeeker.model_name.human(count: @applied_job_seekers.count)
  end

  def show
    @job_seeker = JobSeeker.find(params[:id])
  end



  private

  def attributes_names
    @social_name = JobSeeker.human_attribute_name('social_name')
    @email = JobSeeker.human_attribute_name('email')
    @phone = JobSeeker.human_attribute_name('phone')
  end

  def job_seeker_params
    params.require(:job_seeker).permit(:email, :social_name, :cpf, :phone, :cv)
  end

  def profile_picture_params
    params.require(:job_seeker).permit(:profile_picture)
  end
end