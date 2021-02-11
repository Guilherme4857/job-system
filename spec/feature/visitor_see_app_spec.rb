require 'rails_helper'

feature 'Visitor see app' do
  scenario 'since root path' do
    visit root_path

    within('h1'){expect(page).to have_content 'Balcão de Empregos'}
    within('p'){expect(page).to have_link 'Vagas de emprego'}
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
    within('h3'){expect(page).to have_content job.title}
    expect(page).to have_content "Nível: #{job.level}"
    expect(page).to have_content "Requisitos obrigatórios: #{job.requirements}"
    expect(page).to have_content "Data limite: #{job.expiration_date}"
    expect(page).to have_link 'Anuncie sua vaga'
  end

  scenario 'without registered job' do
    
    visit jobs_path

    within('h2'){expect(page).to have_content 'Sem anúncio de vaga'}
    expect(page).to have_link 'Anuncie sua vaga'
  end
end