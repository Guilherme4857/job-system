# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      if not @employee.company?
        sign_in @employee, scope: :employee        
        @employee.admin!
        redirect_to_new_company(new_employees_company_path)
      else
        sign_in @employee, scope: :employee
        hostname = current_employee.separe_hostname
        company_employee = CompanyEmployee.create!(
          company: company_from_hostname(hostname), employee: current_employee, 
          hostname: hostname
        )
        redirect_to_employee_root(employees_root_path) 
      end
    else
      render 'new'
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  def company_from_hostname(name)
    companies = Company.all
    companies.each do |company|
      return company if company.company_employees.first.hostname == name
    end
  end

  def employee_params
    params.require(:employee).permit(:email, :password)
  end
  
  def redirect_to_new_company(company)
    redirect_to company, notice: 'Bem vindo! Você realizou
                                 seu registro com sucesso.'
  end

  def redirect_to_employee_root(employee)
    redirect_to employee, notice: 'Bem vindo! Você realizou
                                  seu registro com sucesso.'
  end
end
