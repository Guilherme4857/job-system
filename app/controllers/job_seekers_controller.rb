class JobSeekersController < ApplicationController
  def show
    @job_seeker = JobSeeker.find(params[:id])
  end

  def edit
    @job_seeker = JobSeeker.find(params[:id])
  end

  def update
    @job_seeker = JobSeeker.find(params[:id])

    if @job_seeker.update(job_seeker_params)
      redirect_to job_seeker_path(@job_seeker)
    else
      render :edit
    end
  end

  def new_profile_picture
    @job_seeker = JobSeeker.find(params[:id])
  end

  def profile_pictures
    @job_seeker = JobSeeker.find(params[:id])
    if @job_seeker.update(profile_picture_params)
      redirect_to job_seeker_path(@job_seeker)
    else
      render 'new_profile_picture'
    end
  end

  def edit_profile_picture
    @job_seeker = JobSeeker.find(params[:id])
  end

  def profile_picture
    @job_seeker = JobSeeker.find(params[:id])
    if @job_seeker.update(profile_picture_params)
      redirect_to job_seeker_path(@job_seeker)
    else
      render 'edit_profile_picture'
    end    
  end

  def destroy_profile_picture
    @job_seeker = JobSeeker.find(params[:id])
    @job_seeker.profile_picture.purge

    redirect_to job_seeker_path(@job_seeker)
  end
  private

  def job_seeker_params
    params.require(:job_seeker).permit(:email, :social_name, :cpf, :phone, :cv)
  end

  def profile_picture_params
    params.require(:job_seeker).permit(:profile_picture)
  end
end