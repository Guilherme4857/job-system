require 'rails_helper'

feature 'Employer delete job' do
  scenario 'successfully' do
    employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
    job = Job.create!(title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)
    login_as employee, scope: :employee
    
    visit root_path
    click_on 'Vagas de emprego'
    click_on job.title
    click_on 'Deletar Vaga'
    
    expect(current_path).to eq employees_jobs_path
    within('h1'){expect(page).to have_content "Vagas Abertas"}
    within('h2'){expect(page).to have_content 'Vaga deletada com sucesso'}
    expect(page).not_to have_link 'Desenvolvedor Ruby', href: job_path(job)
    expect(page).not_to have_content "Nível: Junior"
    expect(page).not_to have_content "Requisitos Obrigatórios: Saber ruby"
    expect(page).not_to have_content "Data Limite: 23/04/2024"
    expect(page).to have_link 'Anuncie sua vaga', href: new_employees_job_path
    expect(page).to have_link  'Voltar', href: root_path
  end
end