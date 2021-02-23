require 'rails_helper'

feature 'Visit see app' do
  scenario 'since root path' do
    visit root_path

    within('h1'){expect(page).to have_content 'Balcão de Empregos'}
    within('h3#jobs'){expect(page).to have_content 'Busque Vagas ou Empresas'}
    within('form') do
      expect(page).to have_content 'Busca:'
      expect(page).to have_button 'Pesquisar'
    end
    within('div'){expect(page).to have_link 'Vagas Abertas'}
  end

  scenario 'searching for company' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    first_job = Job.create!(company: company, title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby',
                      expiration_date: '23/04/2024', job_openings: 4, levels:[level])
    second_job = Job.create!(company: company, title: 'Analista de sistemas',
                      description: 'Vai análisar sistema todo dia',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber programar',
                      expiration_date: '23/04/2024', job_openings: 2, levels:[level])

    visit root_path
    fill_in 'Busca:', with: 'Campus Code'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    within('h1'){expect(page).to have_content "Resultados de pesquisa"}
    within('div#info') do
      expect(page).to have_link "Campus Code", href: company_path(company)
      expect(page).to have_link 'Desenvolvedor Ruby', href: job_path(first_job)
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Data Limite: 23/04/2024"
      expect(page).to have_link "Analista de sistemas", href: job_path(second_job)
      expect(page).to have_content "Requisitos Obrigatórios: Saber programar"
      expect(page).to have_content "Data Limite: 23/04/2024"
    end
    within('div#root'){expect(page).to have_link 'Voltar', href: root_path}
  end

  scenario 'searching for job' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    first_job = Job.create!(company: company, title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby',
                      expiration_date: '23/04/2024', job_openings: 4, levels:[level])
    second_job = Job.create!(company: company, title: 'Analista de sistemas',
                      description: 'Vai análisar sistema todo dia',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber programar',
                      expiration_date: '23/04/2024', job_openings: 2, levels:[level])

    visit root_path
    fill_in 'Busca:', with: 'Desenvolvedor Ruby'
    click_on 'Pesquisar'

    expect(current_path).to eq search_path
    within('h1'){expect(page).to have_content "Resultados de pesquisa"}
    within('div#info') do
      expect(page).to have_link 'Campus Code', href: company_path(company)
      expect(page).to have_link 'Desenvolvedor Ruby', href: job_path(first_job)
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Data Limite: 23/04/2024"
    end
    within('div#root'){expect(page).to have_link 'Voltar', href: root_path}
  end
  
  scenario 'and all jobs' do
    first_company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com.br', company_history: 'Vem crescendo bastante')
    second_company = Company.create!(name: 'Google', cnpj: '44.333.222/0111-020', 
                              site: 'google.com', company_history: 'Cresceu bastante')
    level = Level.create!(name: 'júnior')
    first_job = Job.create!(company: first_company, title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby',
                      expiration_date: '23/04/2024', job_openings: 4, levels:[level])
    second_job = Job.create!(company: second_company, title: 'Analista de sistemas',
                      description: 'Vai análisar sistema todo dia',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber programar',
                      expiration_date: '23/04/2024', job_openings: 2, levels:[level])

    visit root_path
    click_on 'Vagas Abertas'

    expect(current_path).to eq jobs_path
    within('div#info') do
      expect(page).to have_content 'Empresa: '
      expect(page).to have_link 'Campus Code', href: company_path(first_company)
      expect(page).to have_content 'Título: '
      expect(page).to have_link 'Desenvolvedor Ruby', href: job_path(first_job)
      expect(page).to have_content 'Requisitos Obrigatórios: Saber ruby'
      expect(page).to have_content 'Data Limite: 23/04/2024'
      expect(page).to have_link 'Google', href: company_path(second_company)
      expect(page).to have_link 'Analista de sistemas', href: job_path(second_job)
      expect(page).to have_content 'Requisitos Obrigatórios: Saber programar'
      expect(page).to have_content 'Data Limite: 23/04/2024'
    end
    expect(page).to have_link 'Voltar', href: root_path
  end

  scenario 'and company datails' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'http://www.campuscode.com.br', company_history: 'Vem crescendo bastante')
    social_web_one = CompanySocialWeb.create!(company: company, address_web: 'http://www.linkedin.com/school/campus-code/')
    social_web_two = CompanySocialWeb.create!(company: company, address_web: 'http://www.facebook.com/CampusCodeBr/') 
    social_web_three = CompanySocialWeb.create!(company: company, address_web:'http://www.twitter.com/campuscodebr')
    address = CompanyAddress.create!(company: company, public_place: 'Rua Cícero, 41', 
                                     district: 'Anhembi', city: 'São Paulo', zip_code: '41002-241')
    company.company_picture.attach(io: File.open(
    'app/assets/images/logomarcas/campuscode.png'), filename: 'campuscode.png')
    company.employees << employee

    visit company_path(company)

    expect(page).to have_css('img[src*="campuscode.png"]')
    within('h1'){expect(page).to have_content 'Campus Code'}
    within('h2#header'){expect(page).to have_content 'Informações'}
    within('div#company') do
      expect(page).to have_content 'CNPJ: 33.222.111/0050-46'
      expect(page).to have_content 'Número de funcionários: 1'
      expect(page).to have_link 'http://www.campuscode.com.br', href: "http://www.campuscode.com.br"
      expect(page).to have_content 'Redes Sociais'
      expect(page).to have_link 'http://www.linkedin.com/school/campus-code/', 
      href: "http://www.linkedin.com/school/campus-code/"
      
      expect(page).to have_link 'http://www.facebook.com/CampusCodeBr/', 
      href: "http://www.facebook.com/CampusCodeBr/"
      
      expect(page).to have_link 'http://www.twitter.com/campuscodebr',
       href: "http://www.twitter.com/campuscodebr"
      expect(page).to have_content 'Endereço da Empresa'
      expect(page).to have_content 'Logradouro: Rua Cícero, 41'
      expect(page).to have_content 'Bairro: Anhembi'
      expect(page).to have_content 'Cidade: São Paulo'
      expect(page).to have_content 'CEP: 41002-241'
      expect(page).to have_content 'História da Empresa'
      expect(page).to have_content 'Vem crescendo bastante'
    end
    expect(page).to have_link 'Voltar', href: jobs_path
  end

  scenario 'and jobs datails' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby',
                      expiration_date: '23/04/2024', job_openings: 4, levels:[level])

    visit job_path(job)

    within('h1'){expect(page).to have_content "Campus Code"}
    within('div#job') do
      expect(page).to have_content "Título: Desenvolvedor Ruby"
      expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      expect(page).to have_content "Nível: júnior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Total de Vagas: 4"
      expect(page).to have_content "Data Limite: 23/04/2024"
      expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"      
    end
    expect(page).to have_link "Voltar", href: jobs_path
  end
  
  scenario 'without registered job' do
    
    visit jobs_path

    within('h2#without'){expect(page).to have_content 'Sem anúncio de vaga'}
    expect(page).to have_link  'Voltar', href: root_path    
  end
end