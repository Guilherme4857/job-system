require 'rails_helper'

feature 'Accessing the app' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content 'Balcão de Empregos'
    expect(page).to have_link 'Vagas de emprego'
  end

  scenario 'going to jobs page' do
    job = Job.create!(title: 'Desenvolvedor Ruby',
                      description: 'Vai desenvolver aplicações utilizando ruby',
                      pay_scale: 'R$2000 - R$2600' ,level: 'Junior',
                      requirements: 'Saber ruby',expiration_date: '23/04/2024',job_openings: 4)

    visit root_path
    click_on 'Vagas de emprego'

    expect(current_path).to eq jobs_path
    expect(page).to have_content "Título: #{job.title}"
    expect(page).to have_content "Nível: #{job.level}"
    expect(page).to have_content "Data limite: #{job.expiration_date}"
  end
end