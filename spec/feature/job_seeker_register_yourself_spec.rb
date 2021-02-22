require 'rails_helper'

feature 'Job seeker register yourself' do
  scenario 'since root path' do

    visit root_path
    click_on 'Entrar para candidatar-se'
    click_on 'Inscrever-se'

    expect(current_path).to eq new_job_seeker_registration_path
    within('h2'){expect(page).to have_content 'Formulário de inscrição para se candidatar'}
    within('form') do
      expect(page).to have_content 'E-mail'
      expect(page).to have_content 'Senha'
      expect(page).to have_content 'Nome Social'
      expect(page).to have_content 'CPF'
      expect(page).to have_content 'Telefone'
      expect(page).to have_content 'Currículo'
      expect(page).to have_button 'Inscrever-se'
    end
    expect(page).to have_link 'Entrar'
  end
  
  scenario 'successfully' do
    job_seeker = {email: 'guilherme@gmail.com', password: '123456',
                  social_name: 'Guilherme', cpf:'22.333.444/5', 
                  phone: '+55 11 98904-8658', cv: 'Experiêcia com
                  desenvolvimento de software.'}

    visit root_path
    click_on 'Entrar para candidatar-se'
    click_on 'Inscrever-se'
    within('form') do
      fill_in 'E-mail', with: job_seeker[:email]
      fill_in 'Senha', with: job_seeker[:password]
      fill_in 'Confirme sua senha', with: job_seeker[:password]
      fill_in 'Nome Social', with: job_seeker[:social_name]
      fill_in 'CPF', with: job_seeker[:cpf]
      fill_in 'Telefone', with: job_seeker[:phone]
      fill_in 'Currículo', with: job_seeker[:cv]
      click_on 'Inscrever-se'
    end

    expect(current_path).to eq root_path
  end
end