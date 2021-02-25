require 'rails_helper'

feature 'Employer edit jobs' do
  scenario 'from root path' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', expiration_date: '23/04/2024',job_openings: 4, levels:[level])
    employee.company = company
    login_as employee, scope: :employee
    social_web_one = CompanySocialWeb.create!(company: company, address_web: 'linkedin.com/school/campus-code/')
    social_web_two = CompanySocialWeb.create!(company: company, address_web: 'facebook.com/CampusCodeBr/') 
    social_web_three = CompanySocialWeb.create!(company: company, address_web:'twitter.com/campuscodebr')
    address = CompanyAddress.create!(company: company, public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241')

    visit employees_root_path
    click_on 'Ver sua empresa'
    click_on 'Suas vagas anunciadas'
    click_on 'Desenvolvedor Ruby'
    click_on 'Editar Vaga'

    expect(current_path).to eq edit_employees_job_path job
    within('h1#header'){expect(page).to have_content 'Formulário de Edição da Vaga'}
  end

  scenario 'successfully' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Java',
                      description: 'Vai desenvolver aplicações utilizando java',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber java',
                      expiration_date: '23/04/2024', job_openings: 4, levels:[level])
    employee.company = company
    Level.create!(name: 'pleno')
    Level.create!(name: 'sênior')

    login_as employee, scope: :employee
  
    edited_job = {title: 'Desenvolvedor Ruby', pay_scale: 'R$2000 - R$2600',
                  description: 'Vai desenvolver aplicações utilizando ruby', 
                  requirements: 'Saber ruby', expiration_date: '23/04/2024',
                  job_openings: 4}

    visit edit_employees_job_path job
   
    within('form') do
      fill_in 'Título', with: edited_job[:title]
      fill_in 'Descrição Detalhada', with: edited_job[:description]
      fill_in 'Faixa Salarial', with: edited_job[:pay_scale]
      choose   'júnior'
      fill_in 'Requisitos Obrigatórios', with: edited_job[:requirements]
      fill_in 'Data Limite', with: edited_job[:expiration_date]
      fill_in 'Total de Vagas', with: edited_job[:job_openings]
      click_on 'Atualizar Vaga'        
    end

    expect(current_path).to eq employees_company_job_path(company, job)
    within('h1'){expect(page).to have_content "Campus Code"}
    within('div#job') do
      expect(page).to have_content "Título: Desenvolvedor Ruby"
      expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      expect(page).to have_content "Nível: júnior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Total de Vagas: 4"
      expect(page).to have_content "Data Limite: 23/04/2024"
      expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"      
      expect(page).to have_link 'Deletar Vaga'
      expect(page).to have_link 'Editar Vaga'
    end
    expect(page).to have_link "Voltar", href: employees_company_jobs_path(company)
  end

  scenario "and can't let blank gaps" do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Java',
                      description: 'Vai desenvolver aplicações utilizando java',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber java',
                      expiration_date: '23/04/2024', job_openings: 4, levels:[level])
    login_as employee, scope: :employee
    employee.company = company

    visit edit_employees_job_path job
    
    fill_in 'Título', with: ''
    fill_in 'Descrição Detalhada', with: ''
    fill_in 'Faixa Salarial', with: ''
    fill_in 'Requisitos Obrigatórios', with: ''
    fill_in 'Data Limite', with: ''
    fill_in 'Total de Vagas', with: ''
    click_on 'Atualizar Vaga'

    expect(current_path).to eq employees_job_path(job)
    expect(page).to have_content 'Título não pode ficar em branco'
    expect(page).to have_content "Descrição Detalhada não pode ficar em branco"
    expect(page).to have_content "Requisitos Obrigatórios não pode ficar em branco"
    expect(page).to have_content "Total de Vagas não pode ficar em branco"
    expect(page).to have_content "Data Limite não pode ficar em branco"
    expect(page).to have_content "Faixa Salarial não pode ficar em branco"
    expect(page).to have_link 'Voltar', href: employees_company_job_path(company, job)
  end
end