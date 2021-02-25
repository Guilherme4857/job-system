require 'rails_helper'

feature 'Job Seeker apply yorself to job' do
  scenario 'since root path' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                      expiration_date: '23/04/2024',job_openings: 4, levels:[level])
    
    visit root_path
    click_on 'Vagas Abertas'
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
      expect(page).to have_link "Candidatar-se a vaga", href: apply_to_job_path(job)      
      expect(page).not_to have_link "Cancelar candidatura", href: unapply_to_job_path(job)      
    end
    expect(page).to have_link "Voltar", href: jobs_path
  end

  scenario 'must be signed in' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                      expiration_date: '23/04/2024',job_openings: 4, levels:[level])
    
    visit job_path(job)
    click_on "Candidatar-se a vaga"

    expect(current_path).to eq new_job_seeker_session_path
  end

  scenario 'successfully' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                      expiration_date: '23/04/2024',job_openings: 4, levels:[level])
    job_seeker = JobSeeker.create!(email: 'guilherme@gmail.com', password: '123456',
                                   social_name: 'Guilherme', cpf:'22.333.444/5', 
                                   phone: '+55 11 98904-8658', cv: 'Experiêcia com
                                   desenvolvimento de software.')
    login_as job_seeker, scope: :job_seeker

    visit job_path(job)
    click_on "Candidatar-se a vaga"

    expect(current_path).to eq job_path(job)
    expect(page).to have_content "Candidatura feita com sucesso"
    within('h1'){expect(page).to have_content "Campus Code"}
    within('div#job') do
      expect(page).to have_content "Já está candidatado"
      expect(page).to have_content "Título: Desenvolvedor Ruby"
      expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      expect(page).to have_content "Nível: júnior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Total de Vagas: 4"
      expect(page).to have_content "Data Limite: 23/04/2024"
      expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"
      expect(page).to have_link "Cancelar candidatura", href: unapply_to_job_path(job)      
      expect(page).not_to have_link "Candidatar-se a vaga", href: apply_to_job_path(job)      
    end
    expect(page).to have_link "Voltar", href: jobs_path
  end

  scenario 'and unaply' do
    company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                              site: 'campuscode.com', company_history: 'Vem crescendo bastante')
    level = Level.create!(name: 'júnior')
    job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                      expiration_date: '23/04/2024',job_openings: 4, levels:[level])
    job_seeker = JobSeeker.create!(email: 'guilherme@gmail.com', password: '123456',
                                   social_name: 'Guilherme', cpf:'22.333.444/5', 
                                   phone: '+55 11 98904-8658', cv: 'Experiêcia com
                                   desenvolvimento de software.')
    job_seeker.apply_to!(job)
    login_as job_seeker, scope: :job_seeker

    visit job_path(job)
    click_on "Cancelar candidatura"

    expect(current_path).to eq job_path(job)
    expect(page).to have_content "Candidatura desfeita com sucesso"
    within('h1'){expect(page).to have_content "Campus Code"}
    within('div#job') do
      expect(page).to have_content "Título: Desenvolvedor Ruby"
      expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      expect(page).to have_content "Nível: júnior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Total de Vagas: 4"
      expect(page).to have_content "Data Limite: 23/04/2024"
      expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"
      expect(page).to have_link "Candidatar-se a vaga", href: apply_to_job_path(job)      
      expect(page).not_to have_link "Cancelar candidatura", href: unapply_to_job_path(job)      
    end
    expect(page).to have_link "Voltar", href: jobs_path 
  end
end