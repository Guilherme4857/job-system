require 'rails_helper'

feature 'Job Seeker sign in' do  
  scenario 'successfully' do
    job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com',
      password: '123456', 
      social_name: 'Guilherme',
      cpf: '33.222.111/4',
      phone: '+55 11 989048658', 
      cv: 'Experiência em programar'
    )

    visit root_path
    click_on 'Entrar para candidatar-se'

    within('form') do
      fill_in 'E-mail', with: job_seeker.email
      fill_in 'Senha', with: job_seeker.password
      click_on 'Entrar'
    end

    expect(current_path).to eq root_path
    expect(page).to have_link 'Guilherme', href: job_seeker_path(job_seeker)
    within('nav#principal') do
      expect(page).to have_link 'Sair', href: destroy_job_seeker_session_path
    end
    expect(page).not_to have_link 'Entrar para candidatar-se'
    expect(page).not_to have_link 'Entrar como funcionário de empresa'
  end

  scenario 'and sign out' do
    job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com', password: '123456', 
      social_name: 'Guilherme', cpf:'22.333.444/5', 
      phone: '+55 11 98904-8658',
      cv: 'Experiêcia com desenvolvimento de software.'
    )
    login_as job_seeker, scope: :job_seeker

    visit root_path
    click_on 'Sair'

    expect(current_path).to eq root_path
    within('nav#principal') do
      expect(page).to have_link 'Entrar para candidatar-se', 
                                href: new_job_seeker_session_path
      expect(page).to have_link 'Entrar como funcionário de empresa', 
                                href: new_employee_session_path
    end
    expect(page).not_to have_link 'Guilherme'    
    expect(page).not_to have_link 'Sair'    
  end
end