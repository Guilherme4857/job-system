require 'rails_helper'

feature 'Employer edit jobs' do
  scenario 'must be signed in' do
    job = Job.create!(title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

    visit root_path
    click_on 'Vagas de emprego'
    click_on job.title
    click_on 'Editar Vaga'

    expect(current_path).to eq new_employee_session_path
  end

  scenario 'from root path' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    job = Job.create!(title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)
    login_as employee, scope: :employee

    visit root_path
    click_on 'Vagas de emprego'
    click_on job.title
    click_on 'Editar Vaga'

    expect(current_path).to eq edit_job_path job
  end

  scenario 'successfully' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    job = Job.create!(title: 'Desenvolvedor Java',
                      description: 'Vai desenvolver aplicações utilizando java',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber java',expiration_date: '23/04/2024',job_openings: 4)
    login_as employee, scope: :employee
  
    edited_job = {title: 'Desenvolvedor Ruby', description: 'Vai desenvolver 
                  aplicações utilizando ruby', pay_scale: 'R$2000 - R$2600' ,
                  level: 'Junior', requirements: 'Saber ruby', 
                  expiration_date: '23/04/2024',job_openings: 4}

    visit edit_job_path job
    
    fill_in 'Título', with: edited_job[:title]
    fill_in 'Descrição Detalhada', with: edited_job[:description]
    fill_in 'Faixa Salarial', with: edited_job[:pay_scale]
    fill_in 'Nível', with: edited_job[:level]
    fill_in 'Requisitos Obrigatórios', with: edited_job[:requirements]
    fill_in 'Data Limite', with: edited_job[:expiration_date]
    fill_in 'Total de Vagas', with: edited_job[:job_openings]
    click_on 'Atualizar Vaga'

    expect(current_path).to eq job_path Job.last
    within('h1'){expect(page).to have_content 'Desenvolvedor Ruby'}
    expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
    expect(page).to have_content "Nível: Junior"
    expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
    expect(page).to have_content "Total de Vagas: 4"
    expect(page).to have_content "Data Limite: 23/04/2024"
    expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"
    expect(page).to have_link "Voltar", href: jobs_path
  end

  scenario "and can't let blank gaps" do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    job = Job.create!(title: 'Desenvolvedor Java',
                      description: 'Vai desenvolver aplicações utilizando java',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber java',expiration_date: '23/04/2024',job_openings: 4)
    login_as employee, scope: :employee
 
    visit edit_job_path job
    
    fill_in 'Título', with: ''
    fill_in 'Descrição Detalhada', with: ''
    fill_in 'Faixa Salarial', with: ''
    fill_in 'Nível', with: ''
    fill_in 'Requisitos Obrigatórios', with: ''
    fill_in 'Data Limite', with: ''
    fill_in 'Total de Vagas', with: ''
    click_on 'Atualizar Vaga'

    expect(current_path).to eq job_path(job)
    expect(page).to have_content 'Título não pode ficar em branco'
    expect(page).to have_content "Descrição Detalhada não pode ficar em branco"
    expect(page).to have_content "Nível não pode ficar em branco"
    expect(page).to have_content "Requisitos Obrigatórios não pode ficar em branco"
    expect(page).to have_content "Total de Vagas não pode ficar em branco"
    expect(page).to have_content "Data Limite não pode ficar em branco"
    expect(page).to have_content "Faixa Salarial não pode ficar em branco"
    expect(page).to have_link "Voltar", href: job_path(job)
  end
end