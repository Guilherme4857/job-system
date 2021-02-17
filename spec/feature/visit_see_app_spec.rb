require 'rails_helper'

feature 'Employee see app' do
  scenario 'since root path' do
    visit root_path

    within('h1'){expect(page).to have_content 'Balcão de Empregos'}
    expect(page).to have_link 'Vagas de emprego', href: jobs_path
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
    within('div#info') do
      expect(page).to have_link 'Desenvolvedor Ruby', href: job_path(job)
      expect(page).to have_content "Nível: Junior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Data Limite: 23/04/2024"
    end
    expect(page).not_to have_link 'Anuncie sua vaga'
    expect(page).to have_link  'Voltar', href: root_path
  end

  scenario 'and see jobs datails' do
    job = Job.create!(title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

    visit job_path(job)

    within('h1'){expect(page).to have_content 'Desenvolvedor Ruby'}
    within('div#job') do
      expect(page).to have_content "Descrição Detalhada: Vai desenvolver aplicações utilizando ruby"
      expect(page).to have_content "Nível: Junior"
      expect(page).to have_content "Requisitos Obrigatórios: Saber ruby"
      expect(page).to have_content "Total de Vagas: 4"
      expect(page).to have_content "Data Limite: 23/04/2024"
      expect(page).to have_content "Faixa Salarial: R$2000 - R$2600"      
    end
    expect(page).not_to have_link 'Deletar Vaga'
    expect(page).not_to have_link 'Editar Vaga'
    expect(page).to have_link "Voltar", href: jobs_path
  end
  
  scenario 'without registered job' do
    
    visit jobs_path

    within('h2#without'){expect(page).to have_content 'Sem anúncio de vaga'}
    expect(page).not_to have_link 'Anuncie sua vaga'
    expect(page).to have_link  'Voltar', href: root_path    
  end
end