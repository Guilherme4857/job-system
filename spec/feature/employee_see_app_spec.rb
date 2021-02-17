require 'rails_helper'

feature 'Employee see app' do

  scenario 'successfully' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')  
    login_as employee, scope: :employee
    job = Job.create!(title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

    visit root_path
    click_on 'Vagas de emprego'

    expect(current_path).to eq employees_jobs_path
    within('h1'){expect(page).to have_content "Vagas Abertas"}
    within('div#info') do
      expect(page).to have_link 'Desenvolvedor Ruby', href: employees_job_path(job)
      expect(page).to have_content "Nível: Junior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Data Limite: 23/04/2024"
    end
    expect(page).to have_link 'Anuncie sua vaga', href: new_employees_job_path
    expect(page).to have_link  'Voltar', href: root_path
  end

  scenario 'and see details aboult job' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')  
    login_as employee, scope: :employee
    job = Job.create!(title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

    visit employees_job_path(job)

    within('h1'){expect(page).to have_content 'Desenvolvedor Ruby'}
    within('div#job') do
      expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      expect(page).to have_content "Nível: Junior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Total de Vagas: 4"
      expect(page).to have_content "Data Limite: 23/04/2024"
      expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"      
      expect(page).to have_button 'Deletar Vaga'
      expect(page).to have_link 'Editar Vaga'
    end
    expect(page).to have_link "Voltar", href: employees_jobs_path

    
  end

  scenario 'without registered job' do
    employee =  Employee.create!(email: 'henrique@campuscode.com.br', password: '123456')  
    login_as employee, scope: :employee
    
    visit employees_jobs_path

    within('h2#without'){expect(page).to have_content 'Sem anúncio de vaga'}
    expect(page).to have_link 'Anuncie sua vaga', href: new_employees_job_path
    expect(page).to have_link  'Voltar', href: root_path    
  end
end