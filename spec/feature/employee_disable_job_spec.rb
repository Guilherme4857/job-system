require 'rails_helper'

feature 'Employee disable job' do
  scenario 'since root_path' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                      expiration_date: '23/04/2024',job_openings: 4, levels:[level])
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
      expect(page).to have_link 'Desativar Vaga', href: job_disable_employees_job_path(job)
      expect(page).not_to have_link 'Ativar Vaga', href: job_enable_employees_job_path(job)
    end
    expect(page).to have_link "Voltar", href: employees_company_jobs_path(company)
  end

  scenario 'successfully' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                      expiration_date: '23/04/2024',job_openings: 4, levels:[level])
    employee.company = company
    login_as employee, scope: :employee
    social_web_one = CompanySocialWeb.create!(company: company, address_web: 'linkedin.com/school/campus-code/')
    social_web_two = CompanySocialWeb.create!(company: company, address_web: 'facebook.com/CampusCodeBr/') 
    social_web_three = CompanySocialWeb.create!(company: company, address_web:'twitter.com/campuscodebr')
    address = CompanyAddress.create!(company: company, public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241')
     
    visit employees_company_job_path(job, company)
    click_on 'Desativar Vaga'
   
    expect(current_path).to eq employees_company_job_path(job, company)
    within('h1'){expect(page).to have_content "Campus Code"}
    within('div#job') do
      expect(page).to have_content "[Desabilitado] Título: Desenvolvedor Ruby"
      expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      expect(page).to have_content "Nível: júnior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Total de Vagas: 4"
      expect(page).to have_content "Data Limite: 23/04/2024"
      expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"      
      expect(page).to have_link 'Deletar Vaga'
      expect(page).to have_link 'Editar Vaga'
      expect(page).not_to have_link 'Desativar Vaga', href: job_disable_employees_job_path(job)
      expect(page).to have_link 'Ativar Vaga', href: job_enable_employees_job_path(job)
    end
    expect(page).to have_link "Voltar", href: employees_company_jobs_path(company)
  end

  scenario 'and enable again' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                      expiration_date: '23/04/2024',job_openings: 4, levels:[level])
    employee.company = company
    login_as employee, scope: :employee
    social_web_one = CompanySocialWeb.create!(company: company, address_web: 'linkedin.com/school/campus-code/')
    social_web_two = CompanySocialWeb.create!(company: company, address_web: 'facebook.com/CampusCodeBr/') 
    social_web_three = CompanySocialWeb.create!(company: company, address_web:'twitter.com/campuscodebr')
    address = CompanyAddress.create!(company: company, public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241')
    job.disable!
     
    visit employees_company_job_path(job, company)
    click_on 'Ativar Vaga'
   
    expect(current_path).to eq employees_company_job_path(job, company)
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
      expect(page).to have_link 'Desativar Vaga', href: job_disable_employees_job_path(job)
      expect(page).not_to have_link 'Ativar Vaga', href: job_enable_employees_job_path(job)
    end
    expect(page).to have_link "Voltar", href: employees_company_jobs_path(company)
  end

  scenario 'and disable for date' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                      expiration_date: '23/04/2020',job_openings: 4, levels:[level])
    employee.company = company
    login_as employee, scope: :employee
    social_web_one = CompanySocialWeb.create!(company: company, address_web: 'linkedin.com/school/campus-code/')
    social_web_two = CompanySocialWeb.create!(company: company, address_web: 'facebook.com/CampusCodeBr/') 
    social_web_three = CompanySocialWeb.create!(company: company, address_web:'twitter.com/campuscodebr')
    address = CompanyAddress.create!(company: company, public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241')
     
    visit employees_company_job_path(job, company)
   
    expect(current_path).to eq employees_company_job_path(job, company)
    within('h1'){expect(page).to have_content "Campus Code"}
    within('div#job') do
      expect(page).to have_content "[Desabilitado] Título: Desenvolvedor Ruby"
      expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      expect(page).to have_content "Nível: júnior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Total de Vagas: 4"
      expect(page).to have_content "Data Limite: 23/04/2020"
      expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"      
      expect(page).to have_link 'Deletar Vaga'
      expect(page).to have_link 'Editar Vaga'
      expect(page).to have_link 'Ativar Vaga', href: job_enable_employees_job_path(job)
      expect(page).not_to have_link 'Desativar Vaga', href: job_disable_employees_job_path(job)
    end
    expect(page).to have_link "Voltar", href: employees_company_jobs_path(company)
  end
end