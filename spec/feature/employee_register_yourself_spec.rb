require 'rails_helper'

feature 'Employee register yourself' do
  scenario 'since root path' do

    visit root_path
    click_on 'Entrar como funcionário de empresa'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail', with: 'joao@campuscode.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'        
    end
    expect(current_path).to eq new_company_path
  end

  scenario 'and not first company employee registred' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    company_employee = CompanyEmployee.create!(company: company, employee: employee, hostname: '@campuscode.com.br')

    visit root_path
    click_on 'Entrar como funcionário de empresa'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail', with: 'joao@campuscode.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Inscrever-se'        
    end
    expect(current_path).to eq new_company_path
  end

end