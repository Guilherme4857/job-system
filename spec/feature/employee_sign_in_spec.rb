require 'rails_helper'

feature 'Employer sign in' do
  scenario 'sign in' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com.br', company_history: 'Vem crescendo bastante')    
    employee.company = company

    visit root_path
    click_on 'Entrar como funcionário de empresa'
    within('form') do
      fill_in 'E-mail', with: employee.email
      fill_in 'Senha', with: employee.password
      click_on 'Entrar'        
    end
    
    within('nav#principal') do
      expect(page).to have_link 'Sair'
      expect(page).to have_content employee.email
      expect(page).not_to have_content 'Entrar como funcionário de empresa'       
      expect(page).not_to have_content 'Entrar'
    end
  end

  scenario 'sing out' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    
    login_as employee, scope: :employee

    visit root_path
    click_on 'Sair'

    within('nav#principal') do
      expect(page).to have_link 'Entrar como funcionário de empresa'
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_content employee.email
      expect(page).not_to have_link 'Sair'        
    end
  end
end