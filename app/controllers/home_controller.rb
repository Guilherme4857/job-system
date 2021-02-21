class HomeController < ApplicationController
  def index  
  end

  def search
    @companies = Company.where('name = ?' , params[:element])
    @jobs = Job.where('title = ? OR pay_scale = ? OR 
    expiration_date = ? OR job_openings = ?', params[:element],
    params[:element], params[:element], params[:element])
  end
end