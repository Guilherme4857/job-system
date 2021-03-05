require 'rails_helper'

feature 'Employee see applied job seekers' do
  scenario 'when has none' do
    employee =  Employee.create!(
      email: 'henrique@campuscode.com.br', password: '123456',
      cpf: '12.345.678/9'
    )  
    login_as employee, scope: :employee
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'http://www.campuscode.com.br',
      company_history: 'Vem crescendo bastante'
    )    
    social_web_one = CompanySocialWeb.create!(
      company: company, 
      address_web: 'http://www.linkedin.com/school/campus-code/'
    )
    social_web_two = CompanySocialWeb.create!(
      company: company, 
      address_web: 'http://www.facebook.com/CampusCodeBr/'
    )
    social_web_three = CompanySocialWeb.create!(
      company: company, 
      address_web:'http://www.twitter.com/campuscodebr'
    )
    address = CompanyAddress.create!(
      company: company, public_place: 'Rua Cícero, 41', 
      district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241'
    )
    CompanyEmployee.create!(company: company, 
                            employee: employee, 
                            hostname: '@campuscode.com.br')

    visit employees_root_path
    click_on 'Ver sua empresa'
    click_on 'Candidaturas às vagas'

    expect(current_path).to eq employees_company_job_seekers_path(company)
    within('h1#header'){expect(page).to have_content 'Candidatos'}
    within('div#body'){expect(page).to have_content 'Nenhum candidato às vagas'}
    expect(page).to have_link 'Voltar',
      href: employees_company_path(company)
  end

  scenario 'successfully' do
    employee =  Employee.create!(
      email: 'henrique@campuscode.com.br', password: '123456',
      cpf: '12.345.678/9'
    )  
    login_as employee, scope: :employee
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'http://www.campuscode.com.br', 
      company_history: 'Vem crescendo bastante'
    )    
    social_web_one = CompanySocialWeb.create!(
      company: company, 
      address_web: 'http://www.linkedin.com/school/campus-code/'
    )
    social_web_two = CompanySocialWeb.create!(
      company: company, 
      address_web: 'http://www.facebook.com/CampusCodeBr/'
    ) 
    social_web_three = CompanySocialWeb.create!(
      company: company, 
      address_web:'http://www.twitter.com/campuscodebr'
    )
    address = CompanyAddress.create!(
      company: company, public_place: 'Rua Cícero, 41', 
      district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241'
    )
    CompanyEmployee.create!(company: company, 
                            employee: employee, 
                            hostname: '@campuscode.com.br')
    level = Level.create!(name: 'júnior')
    job = Job.create!(
      company: company, title: 'Desenvolvedor Ruby', 
      description: 'Vai desenvolver aplicações utilizando ruby',
      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
      expiration_date: '23/04/2024',job_openings: 4, levels:[level]
    )
    first_job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com', password: '123456',
      social_name: 'Guilherme', cpf:'22.333.444/5', 
      phone: '+55 11 98904-8658', 
      cv: 'Experiêcia com desenvolvimento de software.'
    )
    second_job_seeker = JobSeeker.create!(
      email: 'bruna@yahoo.com', password: '123456', 
      social_name: 'Bruna', cpf: '44.333.222/1',
      phone: '+55 11 93925-8796', 
      cv: 'Experiência em programar'
    )
    third_job_seeker = JobSeeker.create!(
      email: 'vanessa@gmail.com', password: '123456', 
      social_name: 'Vanessa', cpf: '55.444.333/2',
      phone: '+55 11 99388-9300', 
      cv: 'Experiência com desenvolvimento ruby'
    )
    first_job_seeker.apply_to!(job)
    third_job_seeker.apply_to!(job)
    first_job_seeker.reload
    third_job_seeker.reload

    visit employees_root_path
    click_on 'Ver sua empresa'
    click_on 'Candidaturas às vagas'
    
    expect(current_path).to eq employees_company_job_seekers_path(company)
    within('h1#header'){expect(page).to have_content 'Candidatos'}
    within('div#body') do
      expect(page).to have_content 'Pendente de avaliação', count: 2
      expect(page).to have_content 'Nome Social: ', count: 2
      expect(page).to have_link 'Guilherme', 
        href: employees_company_job_job_seeker_path(
          company, job, first_job_seeker
        )
      expect(page).to have_content 'E-mail: guilherme@gmail.com'
      expect(page).to have_content 'Telefone: +55 11 98904-8658'
      expect(page).to have_link 'Vanessa', 
        href: employees_company_job_job_seeker_path(
          company, job, third_job_seeker
        )
      expect(page).to have_content 'E-mail: vanessa@gmail.com'
      expect(page).to have_content 'Telefone: +55 11 99388-9300'
      expect(page).not_to have_content 'Nenhum candidato às vagas'
    end
    expect(page).to have_link 'Voltar',
      href: employees_company_path(company)    
  end

  scenario 'detailed informations' do
    employee =  Employee.create!(
      email: 'henrique@campuscode.com.br', password: '123456',
      cpf: '12.345.678/9'
    )  
    login_as employee, scope: :employee
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'campuscode.com.br', company_history: 'Vem crescendo bastante'
    )    
    social_web_one = CompanySocialWeb.create!(
      company: company, 
      address_web: 'http://www.linkedin.com/school/campus-code/'
    )
    social_web_two = CompanySocialWeb.create!(
      company: company, 
      address_web: 'http://www.facebook.com/CampusCodeBr/'
    ) 
    social_web_three = CompanySocialWeb.create!(
      company: company, 
      address_web:'http://www.twitter.com/campuscodebr'
    )
    address = CompanyAddress.create!(
      company: company, public_place: 'Rua Cícero, 41', 
      district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241'
    )
    employee.company = company
    level = Level.create!(name: 'júnior')
    first_job = Job.create!(
      company: company, title: 'Desenvolvedor Ruby', 
      description: 'Vai desenvolver aplicações utilizando ruby',
      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
      expiration_date: '23/04/2024',job_openings: 4, levels:[level]
    )
    second_job = Job.create!(
      company: company, title: 'Analista de software', 
      description: 'Vai analisar bastante software',
      pay_scale: 'R$2000 - R$3000' , requirements: 'Experiêcia no ramo', 
      expiration_date: '25/06/2025', job_openings: 4, levels:[level]
    )
    third_job = Job.create!(
      company: company, title: 'Desenvolvedor C#', 
      description: 'Vai desenvolver aplicações utilizando C#',
      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber C#', 
      expiration_date: '23/03/2030',job_openings: 4, levels:[level]
    )
    job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com', password: '123456',
      social_name: 'Guilherme', cpf:'22.333.444/5', 
      phone: '+55 11 98904-8658', 
      cv: 'Experiêcia com desenvolvimento de software.'
    )
    job_seeker.profile_picture.attach(
      io: File.open(
        'app/assets/images/logomarcas/konduto.png'
      ), filename: 'konduto.png'
    )
    job_seeker.apply_to!(first_job)
    job_seeker.apply_to!(second_job)
    job_seeker.reload

    visit employees_company_job_seekers_path(company)
    click_on 'Guilherme'
    
    expect(current_path).to eq(
      employees_company_job_job_seeker_path(company, first_job, job_seeker)
    )
    within('header#pendi'){expect(page).to have_content 'Pendente de avaliação'}
    expect(page).to have_css('img[src*="konduto.png"]')
    within('h1#name'){expect(page).to have_content 'Guilherme'}
    within('div#body') do
      expect(page).to have_content 'E-mail: guilherme@gmail.com'
      expect(page).to have_content 'Telefone: +55 11 98904-8658'
      expect(page).to have_content 'CPF: 22.333.444/5'
      expect(page).to have_content 'Currículo'
      expect(page).to have_content 'Experiêcia com desenvolvimento de software.'
    end
    within('h1#header') do 
      expect(page).to have_content 'Vagas que está concorrendo'
    end
    within('div.jobs#informations') do
      expect(page).to have_content 'Título: ', count: 2
      expect(page).to have_link 'Desenvolvedor Ruby',
        href: employees_company_job_path(company, first_job)
      expect(page).to have_content 'Nível: júnior'
      expect(page).to have_link 'Analista de software',
        href: employees_company_job_path(company, second_job)
      expect(page).to have_content 'Nível: júnior'      
    end

    expect(page).to have_link 'Voltar',
      href: employees_company_job_seekers_path(company)    
  end
end