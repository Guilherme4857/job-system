require 'rails_helper'

feature 'Employer sign in' do
  scenario 'succesfully' do
    employee = Employee.create!(
      email: 'joao@campuscode.com.br', password: '654321'
    )
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'campuscode.com.br', company_history: 'Vem crescendo bastante'
    )    
    CompanyEmployee.create!(company: company,
                            employee: employee,
                            hostname: '@campuscode.com.br')

    visit root_path
    click_on 'Entrar como funcionário de empresa'
    within('form') do
      fill_in 'E-mail', with: employee.email
      fill_in 'Senha', with: employee.password
      click_on 'Entrar'        
    end
    
    expect(current_path).to eq employees_root_path
    within('nav#principal') do
      expect(page).to have_link 'Sair', href: destroy_employee_session_path
      expect(page).to have_content employee.email
    end
    expect(page).not_to have_link 'Entrar como candidato',
                                  href: new_job_seeker_session_path
    expect(page).not_to have_link 'Entrar como funcionário de empresa',
                                  href: new_employee_session_path       
end

  scenario 'sing out' do
    employee = Employee.create!(
      email: 'joao@campuscode.com.br', password: '123456'
    )
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'campuscode.com.br', company_history: 'Vem crescendo bastante'
    )    
    CompanyEmployee.create!(company: company,
                            employee: employee,
                            hostname: '@campuscode.com.br')
    login_as employee, scope: :employee

    visit root_path
    click_on 'Sair'

    expect(current_path).to eq root_path
    within('nav#principal') do
      expect(page).to have_link 'Entrar como funcionário de empresa', 
                                href: new_employee_session_path
      expect(page).to have_link 'Entrar para candidatar-se', 
                                href: new_job_seeker_session_path
    end
    expect(page).not_to have_content employee.email
    expect(page).not_to have_link 'Sair'     
  end
end