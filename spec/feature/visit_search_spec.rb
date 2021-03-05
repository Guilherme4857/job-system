require 'rails_helper'

feature 'Visit search' do
  scenario 'without results' do
    visit root_path
    fill_in 'Busca:', with: 'Campus Code'
    click_on 'Pesquisar'
  
    expect(current_path).to eq search_path
    within('h1') { expect(page).to have_content 'Resultados de pesquisa' }
    expect(page).to have_content 'Nenhum resultado encontrado'
    within('div#root') do
      expect(page).to have_link 'Voltar', href: root_path
    end        
  end

  scenario 'for company' do
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'campuscode.com', company_history: 'Vem crescendo bastante'
    )
    level = Level.create!(name: 'júnior')
    first_job = Job.create!(
      company: company, title: 'Desenvolvedor Ruby',
      description: 'Vai desenvolver aplicações utilizando ruby',
      pay_scale: 'R$2000 - R$2600', requirements: 'Saber ruby',
      expiration_date: '23/04/2024', job_openings: 4, levels:[level]
    )
    second_job = Job.create!(
      company: company, title: 'Analista de sistemas',
      description: 'Vai análisar sistema todo dia',
      pay_scale: 'R$2000 - R$2600', requirements: 'Saber programar',
      expiration_date: '23/04/2024', job_openings: 2, levels:[level]
    )
  
    visit root_path
    fill_in 'Busca:', with: 'Campus Code'
    click_on 'Pesquisar'
  
    expect(current_path).to eq search_path
    within('h1') { expect(page).to have_content 'Resultados de pesquisa' }
    within('div#info') do
      expect(page).to have_link 'Campus Code', href: company_path(company)
      expect(page).to have_link 'Desenvolvedor Ruby', href: job_path(first_job)
      expect(page).to have_content 'Requisitos Obrigatórios: Saber ruby'
      expect(page).to have_content 'Data Limite: 23/04/2024'
      expect(page).to have_link 'Analista de sistemas',
                                href: job_path(second_job)
      expect(page).to have_content 'Requisitos Obrigatórios: Saber programar'
      expect(page).to have_content 'Data Limite: 23/04/2024'
    end
    within('div#root') { expect(page).to have_link 'Voltar', href: root_path }
  end
  
  scenario 'for job' do
    company = Company.create!(
      name: 'Campus Code', cnpj: '33.222.111/0050-46', 
      site: 'campuscode.com', company_history: 'Vem crescendo bastante'
    )
    level = Level.create!(name: 'júnior')
    first_job = Job.create!(
      company: company, title: 'Desenvolvedor Ruby',
      description: 'Vai desenvolver aplicações utilizando ruby',
      pay_scale: 'R$2000 - R$2600', requirements: 'Saber ruby',
      expiration_date: '23/04/2024', job_openings: 4, levels:[level]
    )
    second_job = Job.create!(
      company: company, title: 'Analista de sistemas',
      description: 'Vai análisar sistema todo dia',
      pay_scale: 'R$2000 - R$2600', requirements: 'Saber programar',
      expiration_date: '25/09/2026', job_openings: 2, levels:[level]
    )
  
    visit root_path
    fill_in 'Busca:', with: 'Desenvolvedor Ruby'
    click_on 'Pesquisar'
  
    expect(current_path).to eq search_path
    within('h1') { expect(page).to have_content 'Resultados de pesquisa' }
    within('div#info') do
      expect(page).to have_link('Campus Code', href: company_path(company),
                                               count: 1)
      expect(page).to have_content('Título: ', count: 1)
      expect(page).to have_link('Desenvolvedor Ruby', href: job_path(first_job))
      expect(page).to have_content('Requisitos Obrigatórios: Saber ruby')
      expect(page).to have_content('Data Limite: 23/04/2024')
      expect(page).not_to have_link('Analista de sistemas', 
                                    href: job_path(second_job))
      expect(page).not_to have_content(
        'Requisitos Obrigatórios: Saber programar'
      )
      expect(page).not_to have_content('Data Limite: 25/09/2026')
    end
    within('div#root') { expect(page).to have_link 'Voltar', href: root_path }
  end  
end