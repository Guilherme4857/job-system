class ApplicationController < ActionController::Base
  before_action :devise_parameter_sanitizer, if: :devise_controller?
  
  protected

  def devise_parameter_sanitizer
    if resource_class == JobSeeker
      JobSeeker::ParameterSanitizer.new(JobSeeker, :job_seeker, params)
    elsif resource_class == Employee
      Employer::ParameterSanitizer.new(Employee, :employee, params)
    else
      super # Use the default one
    end
  end
end
