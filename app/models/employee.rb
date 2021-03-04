class Employee < ApplicationRecord
  enum status: {admin: 10, common: 0} 
  has_one :company_employee
  has_one :company, through: :company_employee
  accepts_nested_attributes_for :company_employee
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  def company?
    if CompanyEmployee.any?
      if (CompanyEmployee.all.pluck(:hostname).include? separe_hostname) &&
         (CompanyEmployee.all.pluck(:employee_id).include? id)
        true
      else
        false
      end
    else
      false
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
  
  def exist_hostname?
    if CompanyEmployee.any?
      if CompanyEmployee.all.pluck(:hostname).include? separe_hostname
        true
      else
        false
      end
    else
      false
    end
  end
end
