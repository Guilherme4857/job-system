class Employees::CompaniesController < ApplicationController 
  before_action :authenticate_employee!, 
                :company_attributes_names, 
                :company_address_attributes 
  
  def show
    models_names
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
    @company.build_company_address
    3.times {@company.company_social_webs.build}
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      company_employee = CompanyEmployee.create!(
        company: @company, employee: current_employee, 
        hostname: current_employee.separe_hostname
      )

      redirect_to employees_company_path(@company)
    else
      render :new
    end
  end



  private

  def company_params
    company = params.require(:company).permit(
      :name, :company_picture, :cnpj, :site, :company_history, 
      company_address_attributes:%i[id public_place 
      district city zip_code], company_social_webs_attributes:%i[id address_web]
    )
  end

  def models_names
    @address = CompanyAddress.model_name.human
    @social_webs = CompanySocialWeb.model_name.human(
      count: current_employee.company.company_social_webs.count
    )
  end  
  
  def company_attributes_names
    @name = Company.human_attribute_name('name')
    @company_picture = Company.human_attribute_name('company_picture')
    @cnpj = Company.human_attribute_name('cnpj')
    @site = Company.human_attribute_name('site')
    @company_history = Company.human_attribute_name('company_history')
  end

  def company_address_attributes
    @public_place = CompanyAddress.human_attribute_name('public_place')
    @district = CompanyAddress.human_attribute_name('district')
    @city = CompanyAddress.human_attribute_name('city')
    @zip_code = CompanyAddress.human_attribute_name('zip_code')
  end
end


