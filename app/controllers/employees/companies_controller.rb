class Employees::CompaniesController < ApplicationController 
  before_action :authenticate_employee!
  
  def show
    @company = Company.find(params[:id])
    @social_webs = CompanySocialWeb.model_name.human(
    count: @company.company_social_webs.count)
    @address = CompanyAddress.model_name.human
  end

  def new
    @company = Company.new
    @company.build_company_address
    3.times {@company.company_social_webs.build}
    @number = 0
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      company_employee = CompanyEmployee.create!(company: @company, employee: current_employee, 
                                                 hostname: current_employee.separe_hostname)

      redirect_to employees_company_path(@company)
    else
      render :new
    end
  end



  private

  def company_params
    company = params.require(:company).permit(:name, :company_picture, :cnpj, :site, :company_history, 
                                              company_address_attributes:%i[id public_place 
                                              district city zip_code], company_social_webs_attributes:%i[id address_web])

    
  end

end


