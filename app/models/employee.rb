class Employee < ApplicationRecord
  enum status: {admin: 10, common: 0} 
  has_one :company_employee
  has_one :company, through: :company_employee 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def company?
    if CompanyEmployee.any?
      ce = CompanyEmployee.all
      ce = ce.pluck(:hostname)
      name = separe_hostname()
      if ce.include? name
        true
      else
        false
      end
    else
      return false
    end
  end

  def separe_hostname
    if (email.include? '@') and (email.include? '.com')
      array = email.split('@')
      hostname = '@' + array[1]
    else
      nil
    end
  end
  
end
