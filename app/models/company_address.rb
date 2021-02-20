class CompanyAddress < ApplicationRecord
  belongs_to :company

  def company_address_attributes(index)
    attributes = [CompanyAddress.human_attribute_name('public_place'),
                  CompanyAddress.human_attribute_name('district'),
                  CompanyAddress.human_attribute_name('city'), 
                  CompanyAddress.human_attribute_name('zip_code')]

    attributes[index]
  end
end
