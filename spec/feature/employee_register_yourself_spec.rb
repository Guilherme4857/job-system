require 'rails_helper'

feature 'Employee register yourself' do
  scenario 'as first employee' do
    visit root_path
    click_on 'Entrar como funcionário de empresa'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail', with: 'joao@campuscode.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      fill_in 'CPF', with: '41.325.984/9'
      click_on 'Inscrever-se'        
    end

    expect(current_path).to eq(new_employees_company_path)
    expect(Employee.last.admin?).to eq true
    expect(page).to have_content(
      'Bem vindo! Você realizou seu registro com sucesso.'
    )
  end

  scenario 'and not first company employee' do
    employee =  Employee.create!(
      email: 'henrique@campuscode.com.br', password: '123456',
      cpf: '12.345.678/9'
    )
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'http://www.campuscode.com.br',
      company_history: 'Vem crescendo bastante'
    )
    employee.admin!
    CompanyEmployee.create!(company: company, employee: employee,
                            hostname: '@campuscode.com.br')
    visit root_path
    click_on 'Entrar como funcionário de empresa'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail', with: 'joao@campuscode.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      fill_in 'CPF', with: '41.325.984/9'
      click_on 'Inscrever-se'        
    end
    expect(current_path).to eq employees_root_path
    expect(Employee.last.admin?).to eq false
    expect(Employee.last.company?).to eq true
    expect(page).to have_content(
      'Bem vindo! Você realizou seu registro com sucesso.'
    )
  end

  scenario 'and cpf must be uniqueness' do
    employee =  Employee.create!(
      email: 'henrique@campuscode.com.br', password: '123456',
      cpf: '12.345.678/9'
    )
    first_company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'http://www.campuscode.com.br',
      company_history: 'Vem crescendo bastante'
    )
    employee.admin!
    CompanyEmployee.create!(company: first_company, 
                            employee: employee,
                            hostname: '@campuscode.com.br')
    second_company = Company.create!(
      name: 'Google', cnpj: '44.333.222/0111-020', 
      site: 'google.com', company_history: 'Cresceu bastante'
    )

    visit root_path
    click_on 'Entrar como funcionário de empresa'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail', with: 'henrique@google.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      fill_in 'CPF', with: '12.345.678/9'
      click_on 'Inscrever-se'        
    end

    expect(page).to have_content('CPF já está em uso')
  end
end