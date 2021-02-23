require 'rails_helper'

RSpec.describe JobSeeker, type: :model do
  describe 'Job Seeker' do
    context '#job_seeker_attributes' do
      it 'successfully' do
        job_seeker = JobSeeker.create!(email: 'guilherme@gmail.com', password: '123456',
                                       social_name: 'Guilherme', cpf:'22.333.444/5', 
                                       phone: '+55 11 98904-8658', cv: 'Experiêcia com
                                       desenvolvimento de software.')
        job_seeker.profile_picture.attach(io: File.open(
        'app/assets/images/logomarcas/konduto.png'), filename: 'konduto.png')

        email = job_seeker.job_seeker_attributes(0)
        profile_picture = job_seeker.job_seeker_attributes(1)
        social_name = job_seeker.job_seeker_attributes(2)
        cpf = job_seeker.job_seeker_attributes(3)
        phone = job_seeker.job_seeker_attributes(4)
        cv = job_seeker.job_seeker_attributes(5)

        expect(email).to eq 'E-mail'
        expect(profile_picture).to eq 'Foto de Perfíl'
        expect(social_name).to eq 'Nome Social'
        expect(cpf).to eq 'CPF'
        expect(phone).to eq 'Telefone'
        expect(cv).to eq 'Currículo'
      end
    end
  end
end
