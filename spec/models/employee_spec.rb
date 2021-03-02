require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'Employee' do
    context '#company?' do
      it 'false if first employee register' do
        employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                    password: '123456')
      
        result = employee.company?
      
        expect(result).to eq false
      end

      it "and false if first company's employee register" do
        first_employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                          password: '123456')
        second_employee = Employee.create!(email: 'gilberto@google.com', 
                                           password: '123456')
        company = Company.create!(name: 'Google', cnpj: '55.444.333/0100-56', 
                                  site: 'google.com', 
                                  company_history: 'Cresceu bastante')
        company_employee = CompanyEmployee.create!(company: company, 
                                                   employee: second_employee,
                                                   hostname: '@google.com')

        result = first_employee.company?
        
        expect(result).to eq false
      end

      it "true if not first company's employee registered" do
        
        first_employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                          password: '123456')
        second_employee =  Employee.create!(
          email: 'henrique@campuscode.com.br', password: '123456'
        )
        company = Company.create!(name: 'Campus Code', 
                                  cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com',
                                  company_history: 'Vem crescendo bastante')
        company_employee = CompanyEmployee.create!(
          company: company, 
          employee: first_employee, 
          hostname: '@campuscode.com.br'
        )

        result = second_employee.company?
        
        expect(result).to eq true
      end
    end
  end

  context '#separe_hostname' do
    it 'successfully' do
      first_employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                        password: '123456')
      second_employee = Employee.create!(email: 'gilberto@google.com', 
                                         password: '123456')
      
      first_name = first_employee.separe_hostname
      second_name = second_employee.separe_hostname
      
      expect(first_name).to eq '@campuscode.com.br'
      expect(second_name).to eq '@google.com'
    end    
  end
  
end
