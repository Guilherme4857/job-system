require 'rails_helper'

feature 'Job seeker edit its profile' do  
  scenario 'successfully' do
    job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com', password: '123456',
      social_name: 'Guilherme', cpf:'22.333.444/5', 
      phone: '+55 11 98904-8658', 
      cv: 'Experiêcia com desenvolvimento de software.'
    )
    login_as job_seeker, scope: :job_seeker
    
    visit root_path
    click_on 'Guilherme'    
    click_on 'Alterar informações'
    
    within('form') do
      fill_in 'E-mail', with: 'gabriella@gmail.com'
      fill_in 'Nome Social', with: 'Gabriella'        
      fill_in 'CPF', with: '55.444.333/2'        
      fill_in 'Telefone', with: '+55 11 95442-8109'        
      fill_in 'Currículo', with: 'Experiência em software embarcado'
      click_on 'Atualizar Perfíl'
    end

    expect(current_path).to eq job_seeker_path(job_seeker)
    within('nav#principal'){expect(page).not_to have_link 'Gabriella'}
    within('header#picture') do
      expect(page).to have_link 'Colocar Foto', 
        href: new_profile_picture_job_seeker_path(job_seeker)
      expect(page).not_to have_link 'Trocar a foto' 
      expect(page).not_to have_link 'Tirar a foto' 
    end
    within('h1#name') { expect(page).to have_content 'Gabriella' }
    within('div#body') do
      expect(page).to have_content 'CPF: 55.444.333/2'
      expect(page).to have_content 'E-mail: gabriella@gmail.com'
      expect(page).to have_content 'Telefone: +55 11 95442-8109'
      expect(page).to have_content 'Currículo'
      expect(page).to have_content 'Experiência em software embarcado'
      expect(page).to have_link 'Alterar informações',
        href: edit_job_seeker_path(job_seeker)
    end
    expect(page).to have_link 'Voltar', href: root_path
  end

  scenario 'with empty gaps' do
    job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com', password: '123456',
      social_name: 'Guilherme', cpf:'22.333.444/5', 
      phone: '+55 11 98904-8658', 
      cv: 'Experiêcia com desenvolvimento de software.'
    )
    login_as job_seeker, scope: :job_seeker
    
    visit root_path
    click_on 'Guilherme'    
    click_on 'Alterar informações'
    
    within('form') do
      fill_in 'E-mail', with: ''
      fill_in 'Nome Social', with: ''        
      fill_in 'CPF', with: ''        
      fill_in 'Telefone', with: ''        
      fill_in 'Currículo', with: ''
      click_on 'Atualizar Perfíl'
    end

    expect(page).to have_content 'Não foi possível salvar candidato: 5 erros'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Nome Social não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'Currículo não pode ficar em branco'
        
  end

  scenario 'setting the picture' do
    job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com', password: '123456',
      social_name: 'Guilherme', cpf: '22.333.444/5',
      phone: '+55 11 98904-8658',
      cv: 'Experiêcia com desenvolvimento de software.'
    )
    login_as job_seeker, scope: :job_seeker

    visit job_seeker_path(job_seeker)
    click_on 'Colocar Foto'
    within('form') do
      attach_file 'Foto de Perfíl', Rails.root.join(
        'app', 'assets', 'images', 'logomarcas', 'konduto.png'
      )
      click_on 'Adicionar foto'
    end

    expect(current_path).to eq job_seeker_path(job_seeker)
    expect(page).not_to have_link 'Guilherme'
    expect(page).to have_css('img[src*="konduto.png"]')
    within('header#picture') do
      expect(page).to have_link 'Trocar a foto',
        href: edit_profile_picture_job_seeker_path(job_seeker)
      expect(page).to have_link 'Tirar a foto',
        href: destroy_profile_picture_job_seeker_path(job_seeker)
      expect(page).not_to have_link 'Colocar Foto' 
    end
    within('h1#name'){expect(page).to have_content 'Guilherme'}
    within('div#body') do      
      expect(page).to have_content 'CPF: 22.333.444/5'
      expect(page).to have_content 'E-mail: guilherme@gmail.com'
      expect(page).to have_content 'Telefone: +55 11 98904-8658'
      expect(page).to have_content 'Currículo'
      expect(page).to have_content(
        'Experiêcia com desenvolvimento de software'
      )
      expect(page).to have_link 'Alterar informações', 
        href: edit_job_seeker_path(job_seeker)
    end
    expect(page).to have_link 'Voltar', href: root_path
  end

  scenario 'changing the picture' do
    job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com', password: '123456',
      social_name: 'Guilherme', cpf:'22.333.444/5', 
      phone: '+55 11 98904-8658',
      cv: 'Experiêcia com desenvolvimento de software.'
    )
    job_seeker.profile_picture.attach(
      io: File.open(
        'app/assets/images/logomarcas/konduto.png'
      ),
      filename: 'konduto.png'
    )
    login_as job_seeker, scope: :job_seeker

    visit job_seeker_path(job_seeker)
    click_on 'Trocar a foto'
    within('form') do
      attach_file 'Foto de Perfíl', Rails.root.join(
        'app', 'assets', 'images', 'logomarcas', 'smartfit.png'
      )
      click_on 'Atualizar foto'      
    end

    expect(current_path).to eq job_seeker_path(job_seeker)
    expect(page).not_to have_link 'Guilherme'
    expect(page).to have_css('img[src*="smartfit.png"]')
    within('header#picture') do
      expect(page).to have_link 'Trocar a foto', 
      href: edit_profile_picture_job_seeker_path(job_seeker)
      expect(page).to have_link 'Tirar a foto',
      href: destroy_profile_picture_job_seeker_path(job_seeker)
      expect(page).not_to have_link 'Colocar Foto' 
    end
    within('h1#name'){expect(page).to have_content 'Guilherme'}
    within('div#body') do      
      expect(page).to have_content('CPF: 22.333.444/5')
      expect(page).to have_content('E-mail: guilherme@gmail.com')
      expect(page).to have_content('Telefone: +55 11 98904-8658')
      expect(page).to have_content('Currículo')
      expect(page).to have_content(
        'Experiêcia com desenvolvimento de software'
      )
      expect(page).to have_link('Alterar informações',
        href: edit_job_seeker_path(job_seeker))
    end
    expect(page).to have_link 'Voltar', href: root_path

  end

  scenario 'removing the picture' do
    job_seeker = JobSeeker.create!(
      email: 'guilherme@gmail.com', password: '123456',
      social_name: 'Guilherme', cpf:'22.333.444/5', 
      phone: '+55 11 98904-8658', cv: 'Experiêcia com
      desenvolvimento de software.'
    )
    job_seeker.profile_picture.attach(
      io: File.open(
        'app/assets/images/logomarcas/konduto.png'
      ),
      filename: 'konduto.png'
    )
    login_as job_seeker, scope: :job_seeker

    visit job_seeker_path(job_seeker)
    click_on 'Tirar a foto'

    expect(current_path).to eq job_seeker_path(job_seeker)
    expect(page).not_to have_css('img[src*="smartfit.png"]')
    within('header#picture') do
      expect(page).to have_link 'Colocar Foto' 
      expect(page).not_to have_link 'Trocar a foto', 
      href: edit_profile_picture_job_seeker_path(job_seeker)
      expect(page).not_to have_link 'Tirar a foto',
      href: destroy_profile_picture_job_seeker_path(job_seeker)
    end
    within('h1#name'){expect(page).to have_content 'Guilherme'}
    within('div#body') do      
      expect(page).to have_content('CPF: 22.333.444/5')
      expect(page).to have_content('E-mail: guilherme@gmail.com')
      expect(page).to have_content('Telefone: +55 11 98904-8658')
      expect(page).to have_content('Currículo')
      expect(page).to have_content(
        'Experiêcia com desenvolvimento de software'
      )
      expect(page).to have_link('Alterar informações',
        href: edit_job_seeker_path(job_seeker))
    end
    expect(page).to have_link 'Voltar', href: root_path
  end
end