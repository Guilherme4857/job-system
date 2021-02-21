class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
    @company_social_webs = CompanySocialWeb.model_name.human(count:
    @company.company_social_webs.all.count)
    @company_address = CompanyAddress.model_name.human
  end
end