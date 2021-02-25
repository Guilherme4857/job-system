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

    context '#apply_to!' do
      it 'successfully' do
        job_seeker = JobSeeker.create!(email: 'guilherme@gmail.com', password: '123456', 
                                       social_name: 'Guilherme', cpf: '33.222.111/4',
                                       phone: '+55 11 989048658', cv: 'Experiência em
                                       programar')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        level = Level.create!(name: 'júnior')
        first_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                                description: 'Vai desenvolver aplicações utilizando ruby',
                                pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2024',job_openings: 4, levels:[level])
        second_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                                 description: 'Vai desenvolver aplicações utilizando ruby',
                                 pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                 expiration_date: '23/04/2024',job_openings: 4, levels:[level])
        
        job_seeker.apply_to!(first_job)
        first_job.reload

        expect(job_seeker.applied_to?(first_job)).to eq true
        expect(job_seeker.applied_to?(second_job)).to eq false
      end
    end

    context '#unapply_to!' do
      it 'successfully' do
        job_seeker = JobSeeker.create!(email: 'guilherme@gmail.com', password: '123456', 
                                       social_name: 'Guilherme', cpf: '33.222.111/4',
                                       phone: '+55 11 989048658', cv: 'Experiência em
                                       programar')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        level = Level.create!(name: 'júnior')
        first_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                                description: 'Vai desenvolver aplicações utilizando ruby',
                                pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2024',job_openings: 4, levels:[level])
        second_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', 
                                 description: 'Vai desenvolver aplicações utilizando ruby',
                                 pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                 expiration_date: '23/04/2024',job_openings: 4, levels:[level])
        job_seeker.apply_to!(first_job)
        job_seeker.apply_to!(second_job)
        
        job_seeker.unapply_to!(first_job)
        first_job.reload

        expect(job_seeker.applied_to?(first_job)).to eq false
        expect(job_seeker.applied_to?(second_job)).to eq true
      end
    end

  end
end
