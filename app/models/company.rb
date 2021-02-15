class Company < ApplicationRecord
  has_many :company_social_webs
  has_many :employees
end
