require 'rails_helper'

feature 'Employer register jobs' do
  scenario 'from root path' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    login_as employee, scope: :employee

    visit root_path
    click_on 'Vagas de emprego'
    click_on 'Anuncie sua vaga'

    expect(current_path).to eq new_employees_job_path
    within('h1'){expect(page).to have_content "Preencha todos os campos a seguir"}
  end

  scenario 'successfully' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    login_as employee, scope: :employee
    job = {title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações utilizando ruby',
          pay_scale: 'R$2000 - R$2600' ,level: 'Junior', requirements: 'Saber ruby',
          expiration_date: '23/04/2024',job_openings: 4}

    visit new_employees_job_path

    fill_in 'Título', with: job[:title]
    fill_in 'Descrição Detalhada', with: job[:description]
    fill_in 'Faixa Salarial', with: job[:pay_scale]
    fill_in 'Nível', with: job[:level]
    fill_in 'Requisitos Obrigatórios', with: job[:requirements]
    fill_in 'Data Limite', with: job[:expiration_date]
    fill_in 'Total de Vagas', with: job[:job_openings]
    click_on 'Criar Vaga'
  
    expect(current_path).to eq employees_job_path Job.last
    within('h1'){expect(page).to have_content 'Desenvolvedor Ruby'}
    expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
    expect(page).to have_content "Nível: Junior"
    expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
    expect(page).to have_content "Total de Vagas: 4"
    expect(page).to have_content "Data Limite: 23/04/2024"
    expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"
    expect(page).to have_link "Voltar", href: employees_jobs_path
  end

  scenario 'and must fill all gaps' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    login_as employee, scope: :employee

    visit new_employees_job_path

    fill_in 'Título', with: ''
    fill_in 'Descrição Detalhada', with: ''
    fill_in 'Faixa Salarial', with: ''
    fill_in 'Nível', with: ''
    fill_in 'Requisitos Obrigatórios', with: ''
    fill_in 'Data Limite', with: ''
    fill_in 'Total de Vagas', with: ''
    click_on 'Criar Vaga'

    expect(current_path).to eq employees_jobs_path
    expect(page).to have_content 'Título não pode ficar em branco'
    expect(page).to have_content "Descrição Detalhada não pode ficar em branco"
    expect(page).to have_content "Nível não pode ficar em branco"
    expect(page).to have_content "Requisitos Obrigatórios não pode ficar em branco"
    expect(page).to have_content "Total de Vagas não pode ficar em branco"
    expect(page).to have_content "Data Limite não pode ficar em branco"
    expect(page).to have_content "Faixa Salarial não pode ficar em branco"
    expect(page).to have_link "Voltar", href: employees_jobs_path
 
  end
end