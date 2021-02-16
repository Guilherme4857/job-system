class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params.require(:company).permit.(:name, :cnpj, :site, :company_history, 
                                                            :company_address_id))

    if @company.save
      redirect_to root_path
    else
      render :new
    end
  end
end