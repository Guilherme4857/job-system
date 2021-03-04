require 'rails_helper'

feature 'Employer register jobs' do
  scenario 'successfully' do
    employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                password: '123456')
    login_as employee, scope: :employee
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'http://www.campuscode.com.br',
                              company_history: 'Vem crescendo bastante')    
    address = CompanyAddress.create!(company: company,
                                     public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo', 
                                     zip_code: '41002-241')
    CompanyEmployee.create!(company: company, 
                            employee: employee, 
                            hostname: '@campuscode.com.br')
    Level.create!(name: 'júnior')
    Level.create!(name: 'pleno')
    Level.create!(name: 'sênior')
    job = {title: 'Desenvolvedor Ruby', 
           description: 'Vai desenvolver aplicações utilizando ruby',
           pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby',
           expiration_date: '23/04/2024',job_openings: 4}

    visit employees_root_path
    click_on 'Ver sua empresa'
    click_on 'Anuncie sua vaga'
    within('form') do
      fill_in 'Título', with: job[:title]
      fill_in 'Descrição Detalhada', with: job[:description]
      fill_in 'Faixa Salarial', with: job[:pay_scale]
      choose 'júnior'
      fill_in 'Requisitos Obrigatórios', with: job[:requirements]
      fill_in 'Data Limite', with: job[:expiration_date]
      fill_in 'Total de Vagas', with: job[:job_openings]
      click_on 'Criar Vaga'        
    end
  
    expect(current_path).to eq employees_company_job_path(Job.last, company)
    within('h1'){expect(page).to have_content 'Campus Code'}
    within('div#job') do
      expect(page).to have_content("Título: Desenvolvedor Ruby")
      expect(page).to have_content(
        "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      )
      expect(page).to have_content("Nível: júnior")
      expect(page).to have_content("Requisitos Obrigatórios: Saber ruby")
      expect(page).to have_content("Total de Vagas: 4")
      expect(page).to have_content("Data Limite: 23/04/2024")
      expect(page).to have_content("Faixa Salarial: R$2000 - R$2600")
      expect(page).to have_link('Deletar Vaga')
      expect(page).to have_link('Editar Vaga')      
    end
    expect(page).to have_link("Voltar", 
                              href: employees_company_jobs_path(company))
  end

  scenario 'and must fill all gaps' do
    employee = Employee.create!(email: 'joao@campuscode.com', 
                                password: '123456')
    login_as employee, scope: :employee
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com.br',
                              company_history: 'Vem crescendo bastante')    
    address = CompanyAddress.create!(company: company,
                                     public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo',
                                     zip_code: '41002-241')
    employee.company = company
    Level.create!(name: 'júnior')
    Level.create!(name: 'pleno')
    Level.create!(name: 'sênior')
    job = {title: 'Desenvolvedor Ruby',
           description: 'Vai desenvolver aplicações utilizando ruby',
           pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby',
           expiration_date: '23/04/2024',job_openings: 4}

    visit new_employees_company_job_path(company)
    within('form') do
      fill_in 'Título', with: ''
      fill_in 'Descrição Detalhada', with: ''
      fill_in 'Faixa Salarial', with: ''
      fill_in 'Requisitos Obrigatórios', with: ''
      fill_in 'Data Limite', with: ''
      fill_in 'Total de Vagas', with: ''
      click_on 'Criar Vaga'        
    end

    expect(current_path).to eq employees_company_jobs_path(company)
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content("Descrição Detalhada não pode ficar em branco")
    expect(page).to have_content(
      "Requisitos Obrigatórios não pode ficar em branco"
    )
    expect(page).to have_content("Total de Vagas não pode ficar em branco")
    expect(page).to have_content("Data Limite não pode ficar em branco")
    expect(page).to have_content("Faixa Salarial não pode ficar em branco")
    expect(page).to have_link("Voltar", href: employees_company_path(company))
 
  end
end