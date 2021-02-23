class JobSeekers::ProfilesController < ApplicationController
  def show
    @job_seeker = JobSeeker.find(params[:id])
  end
end