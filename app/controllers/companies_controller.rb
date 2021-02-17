class CompaniesController < ApplicationController
  def new
    @company = Company.new
    @company.build_company_address
    3.times {@company.company_social_webs.build}
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to root_path
    else
      render :new
    end
  end
end


private

def company_params
  company = params.require(:company).permit(:name, :company_picture, :cnpj, :site, :company_history, 
                                            company_address_attributes:[:id, :public_place, 
                                            :district, :city, :zip_code])
end