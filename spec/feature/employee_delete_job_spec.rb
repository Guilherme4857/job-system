require 'rails_helper'

feature 'Employer delete job' do
  scenario 'successfully' do
    employee = Employee.create!(email: 'joao@campuscode.com.br', 
                                password: '123456',
                                cpf: '12.345.678/9')
    login_as employee, scope: :employee
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'http://www.campuscode.com.br', 
      company_history: 'Vem crescendo bastante'
    )
    social_web_one = CompanySocialWeb.create!(
      company: company, 
      address_web: 'linkedin.com/school/campus-code/'
    )
    social_web_two = CompanySocialWeb.create!(
      company: company,
      address_web: 'facebook.com/CampusCodeBr/'
    ) 
    social_web_three = CompanySocialWeb.create!(
      company: company,
      address_web: 'twitter.com/campuscodebr'
    )
    address = CompanyAddress.create!(
      company: company, public_place: 'Rua Cícero, 41', 
      district: 'Anhembi', 
      city: 'São Paulo', zip_code: '41002-241'
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
    
    visit employees_root_path
    click_on 'Ver sua empresa'
    click_on 'Suas vagas anunciadas'
    click_on 'Desenvolvedor Ruby'
    click_on 'Deletar Vaga'
    
    expect(current_path).to eq employees_company_jobs_path company
    expect(page).to have_content 'Vaga deletada com sucesso'
    within('h1'){expect(page).to have_content "Campus Code Vagas Abertas"}
    within('h2#without'){expect(page).to have_content 'Sem anúncio de vaga'}
    expect(page).to have_link  'Voltar', href: employees_company_path(company)
  end
end