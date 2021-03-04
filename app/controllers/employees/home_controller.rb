class Employees::HomeController < ApplicationController
  before_action :authenticate_employee!
  def index    
    if current_employee.company?
      @company = current_employee.company
    elsif current_employee.exist_hostname?
      create_company_employee(
        current_employee.separe_hostname
      )
      @company = current_employee.company        
    else
      current_employee.admin!
      redirect_to new_employees_company_path
    end
  end

  private

  def company_from_hostname(name)
    companies = Company.all
    companies.each do |company|
      return company if company.company_employees.first.hostname == name
    end
  end

  def create_company_employee(hostname)
    CompanyEmployee.create!(
      company: company_from_hostname(hostname),
      employee: current_employee,
      hostname: hostname
    )
  end
end