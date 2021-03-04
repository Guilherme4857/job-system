class Company < ApplicationRecord
  has_many :jobs
  has_many :company_employees
  has_many :employees, through: :company_employees
  has_many :company_social_webs
  has_one :company_address
  has_one_attached :company_picture
  accepts_nested_attributes_for :company_address 
  accepts_nested_attributes_for :company_social_webs

end