require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'Employee' do
    context '#company?' do
      it 'successfully' do
        
        first_employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                          password: '123456')
        second_employee =  Employee.create!(email: 'henrique@campuscode.com.br',
                                            password: '123456')
        company = Company.create!(name: 'Campus Code', 
                                  cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com.br',
                                  company_history: 'Vem crescendo bastante')
        company_employee = CompanyEmployee.create!(
          company: company, 
          employee: first_employee, 
          hostname: '@campuscode.com.br'
        )
         
        expect(first_employee.company?).to eq true
        expect(second_employee.company?).to eq false
      end
    end
  end

  context '#separe_hostname' do
    it 'successfully' do
      first_employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                        password: '123456')
      second_employee = Employee.create!(email: 'gilberto@google.com', 
                                         password: '123456')
      
      expect(first_employee.separe_hostname).to eq '@campuscode.com.br'
      expect(second_employee.separe_hostname).to eq '@google.com'
    end    
  end

  context '#exist_hostname?' do
    it 'successfully' do
      first_employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                        password: '123456')
      second_employee = Employee.create!(email: 'gilberto@google.com', 
                                         password: '123456')
      
      company = Company.create!(name: 'Campus Code', 
                                cnpj: '33.222.111/0050-46', 
                                site: 'campuscode.com.br',
                                company_history: 'Vem crescendo bastante')
      company_employee = CompanyEmployee.create!(
        company: company, 
        employee: first_employee, 
        hostname: '@campuscode.com.br'
      )
      
      expect(first_employee.exist_hostname?).to eq true
      expect(second_employee.exist_hostname?).to eq false
    end
  end
end