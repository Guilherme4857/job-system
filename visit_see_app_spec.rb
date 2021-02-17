require 'rails_helper'

feature 'Employee see app' do
  scenario 'since root path' do
    visit root_path

    within('h1'){expect(page).to have_content 'Balcão de Empregos'}
    expect(page).to have_link 'Vagas de emprego'
  end

  scenario 'successfully' do
    job = Job.create!(title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

    visit root_path
    click_on 'Vagas de emprego'

    expect(current_path).to eq jobs_path
    within('h1'){expect(page).to have_content "Vagas Abertas"}
    within('h3'){expect(page).to have_link 'Desenvolvedor Ruby', href: job_path(job)}
    expect(page).to have_content "Nível: Junior"
    expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
    expect(page).to have_content "Data Limite: 23/04/2024"
    expect(page).to have_link 'Anuncie sua vaga', href: new_job_path
    expect(page).to have_link  'Voltar', href: root_path
  end

  scenario 'without registered job' do
    
    visit jobs_path

    within('h2'){expect(page).to have_content 'Sem anúncio de vaga'}
    expect(page).to have_link 'Anuncie sua vaga', href: new_job_path
    expect(page).to have_link  'Voltar', href: root_path    
  end
end