class HomeController < ApplicationController
  before_action :job_attributes_names, :company_attributes_names

  def index  
  end

  def search
    @companies = Company.where('name = ?' , params[:element])
    @jobs = Job.where('title = ? OR pay_scale = ? OR 
    expiration_date = ? OR job_openings = ?', params[:element],
    params[:element], params[:element], params[:element])
  end

  private

  def job_attributes_names
    @title = Job.human_attribute_name('title')
    @description = Job.human_attribute_name('description')
    @pay_scale = Job.human_attribute_name('pay_scale')
    @requirements = Job.human_attribute_name('requirements')
    @expiration_date = Job.human_attribute_name('expiration_date')
    @job_openings = Job.human_attribute_name('job_openings')
    @level = Job.human_attribute_name('levels')
  end

  def company_attributes_names
    @name = Company.human_attribute_name('name')
  end
end