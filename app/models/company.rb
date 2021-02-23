class Company < ApplicationRecord
  has_many :jobs
  has_many :company_employees
  has_many :employees, through: :company_employees
  has_many :company_social_webs
  has_one :company_address
  has_one_attached :company_picture
  accepts_nested_attributes_for :company_address 
  accepts_nested_attributes_for :company_social_webs


  def company_attributes(index)
    attributes = [Company.human_attribute_name('name'),
                  Company.human_attribute_name('company_picture'),
                  Company.human_attribute_name('cnpj'), 
                  Company.human_attribute_name('site'), 
                  Company.human_attribute_name('company_history')]
            
    attributes[index]
  end
end
