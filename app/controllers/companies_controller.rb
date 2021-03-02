class CompaniesController < ApplicationController
  before_action :company_attributes_names, :company_address_attributes

  def show
    @company = Company.find(params[:id])
    models_name @company
  end

  private

  def models_name(company)
    @company_social_webs = CompanySocialWeb.model_name.human(
      count:company.company_social_webs.all.count
    )
    @company_address = CompanyAddress.model_name.human 
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