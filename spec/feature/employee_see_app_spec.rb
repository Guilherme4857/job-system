require 'rails_helper'

feature 'Employee see app' do
  scenario 'root_path' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')  
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com.br', company_history: 'Vem crescendo bastante')    
    employee.company = company

    login_as employee, scope: :employee
    visit employees_root_path
      
    expect(page).to have_link 'Ver sua empresa', href: employees_company_path(company)
    expect(page).not_to have_link 'Vagas de emprego'
  end

  scenario 'company informations' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')  
    login_as employee, scope: :employee
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com.br', company_history: 'Vem crescendo bastante')    
    social_web_one = CompanySocialWeb.create!(company: company, address_web: 'linkedin.com/school/campus-code/')
    social_web_two = CompanySocialWeb.create!(company: company, address_web: 'facebook.com/CampusCodeBr/') 
    social_web_three = CompanySocialWeb.create!(company: company, address_web:'twitter.com/campuscodebr')
    address = CompanyAddress.create!(company: company, public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241')
    employee.company = company
    
    visit employees_root_path
    click_on 'Ver sua empresa'
    
    expect(current_path).to eq employees_company_path(company)
    within('h1#name'){expect(page).to have_content 'Campus Code'}
    expect(page).to have_link 'Anuncie sua vaga', href: new_employees_company_job_path(company)
    expect(page).to have_link 'Suas vagas anunciadas', href: employees_company_jobs_path(company)
    within('h2#header'){expect(page).to have_content 'Informações'}
    within('div#info') do
      expect(page).to have_content 'CNPJ: 33.222.111/0050-46'
      expect(page).to have_link 'campuscode.com.br'
      expect(page).to have_content 'Redes Sociais'
      expect(page).to have_link 'linkedin.com/school/campus-code/'
      expect(page).to have_link 'facebook.com/CampusCodeBr/'
      expect(page).to have_link 'twitter.com/campuscodebr'
      expect(page).to have_content 'Endereço'
      expect(page).to have_content 'Logradouro: Rua Cícero, 41'
      expect(page).to have_content 'Bairro: Anhembi'
      expect(page).to have_content 'Cidade: São Paulo'
      expect(page).to have_content 'CEP: 41002-241'
      expect(page).to have_content 'História da Empresa'
      expect(page).to have_content 'Vem crescendo bastante'
    end
    expect(page).to have_link 'Voltar', href: employees_root_path
  end

  scenario 'company registered jobs' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')  
    login_as employee, scope: :employee
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby',
                      expiration_date: '23/04/2024', job_openings: 4, levels:[level])
    address = CompanyAddress.create!(company: company, public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241')
    employee.company = company

    visit employees_company_path(company)
    click_on 'Suas vagas anunciadas'

    expect(current_path).to eq employees_company_jobs_path(company)
    within('h1'){expect(page).to have_content "Campus Code Vagas Abertas"}
    within('div#info') do
      expect(page).to have_link 'Desenvolvedor Ruby', href: employees_company_job_path(job, company)
      expect(page).to have_content "Nível: júnior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Data Limite: 23/04/2024"
    end
    expect(page).to have_link  'Voltar', href: employees_company_path(company)
  end

  scenario 'details aboult job' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')  
    login_as employee, scope: :employee
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby',
                      expiration_date: '23/04/2024', job_openings: 4, levels:[level])
    employee.company = company

    visit employees_company_job_path(job, company)

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

  scenario 'without registered job' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')  
    login_as employee, scope: :employee
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    employee.company = company

    visit employees_company_jobs_path(company)

    within('h1'){expect(page).to have_content "Campus Code Vagas Abertas"}
    within('h2#without'){expect(page).to have_content 'Sem anúncio de vaga'}
    expect(page).to have_link  'Voltar', href: employees_company_path(company)    
  end
end