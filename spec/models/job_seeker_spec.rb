require 'rails_helper'

RSpec.describe JobSeeker, type: :model do
  describe 'Job Seeker' do
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
        job_seeker.reload

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
        job_seeker.reload

        expect(job_seeker.applied_to?(first_job)).to eq false
        expect(job_seeker.applied_to?(second_job)).to eq true
      end
    end
    
    context '.all_applied_job_seekers' do
      it 'successfully' do
        first_company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                        site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        second_company = Company.create!(name: 'Google', cnpj: '44.333.222/0111-020', 
                                         site: 'google.com', company_history: 'Cresceu bastante')
        first_level = Level.create!(name: 'júnior')
        second_level = Level.create!(name: 'pleno')
        first_job = Job.create!(company: first_company, title: 'Desenvolvedor Ruby', 
                                description: 'Vai desenvolver aplicações utilizando ruby',
                                pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2024',job_openings: 4, levels:[first_level])
        second_job = Job.create!(company: second_company, title: 'Analista de software', 
                                 description: 'Vai analisar bastante software',
                                 pay_scale: 'R$3000 - R$4000' , requirements: 'Experiêcia no ramo', 
                                 expiration_date: '25/06/2025', job_openings: 4, levels:[first_level])
        third_job = Job.create!(company: first_company, title: 'Desenvolvedor Ruby', 
                                description: 'Vai desenvolver aplicações utilizando ruby',
                                pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2024',job_openings: 4, levels:[second_level])
        fourth_job = Job.create!(company: second_company, title: 'Analista de software', 
                                 description: 'Vai analisar bastante software',
                                 pay_scale: 'R$3000 - R$4000' , requirements: 'Experiêcia no ramo', 
                                 expiration_date: '25/06/2025', job_openings: 4, levels:[second_level])
        first_job_seeker = JobSeeker.create!(email: 'guilherme@gmail.com', password: '123456', 
                                       social_name: 'Guilherme', cpf: '33.222.111/4',
                                       phone: '+55 11 989048658', cv: 'Experiência em
                                       programar')
        second_job_seeker = JobSeeker.create!(email: 'bruna@yahoo.com', password: '123456', 
                                              social_name: 'Bruna', cpf: '44.333.222/1',
                                              phone: '+55 11 93925-8796', cv: 'Experiência em
                                              programar')
        third_job_seeker = JobSeeker.create!(email: 'vanessa@gmail.com', password: '123456', 
                                             social_name: 'Vanessa', cpf: '55.444.333/2',
                                             phone: '+55 11 99388-9300', cv: 'Experiência em
                                             programar')
        fourth_job_seeker = JobSeeker.create!(email: 'camilla@gmail.com', password: '123456', 
                                              social_name: 'Camilla', cpf: '66.555.444/3',
                                              phone: '+55 19 94485-7601', cv: 'Experiência em
                                              programar')
        first_job_seeker.apply_to!(first_job)
        second_job_seeker.apply_to!(second_job)        
        third_job_seeker.apply_to!(third_job)        
        fourth_job_seeker.apply_to!(fourth_job)        
        first_job_seeker.reload        
        second_job_seeker.reload        
        third_job_seeker.reload        
        fourth_job_seeker.reload        

        first_company_job_seekers = JobSeeker.all_applied_job_seekers(first_company).count
        second_company_job_seekers = JobSeeker.all_applied_job_seekers(second_company).count

        expect(first_company_job_seekers).to eq 2
        expect(second_company_job_seekers).to eq 2
      end

      scenario 'Has just one per job seeker occurrence' do
        first_company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                        site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        second_company = Company.create!(name: 'Google', cnpj: '44.333.222/0111-020', 
                                         site: 'google.com', company_history: 'Cresceu bastante')
        first_level = Level.create!(name: 'júnior')
        second_level = Level.create!(name: 'pleno')
        first_job = Job.create!(company: first_company, title: 'Desenvolvedor Ruby', 
                                description: 'Vai desenvolver aplicações utilizando ruby',
                                pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2024',job_openings: 4, levels:[first_level])
        second_job = Job.create!(company: second_company, title: 'Analista de software', 
                                 description: 'Vai analisar bastante software',
                                 pay_scale: 'R$3000 - R$4000' , requirements: 'Experiêcia no ramo', 
                                 expiration_date: '25/06/2025', job_openings: 4, levels:[first_level])
        third_job = Job.create!(company: first_company, title: 'Desenvolvedor Ruby', 
                                description: 'Vai desenvolver aplicações utilizando ruby',
                                pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2024',job_openings: 4, levels:[second_level])
        fourth_job = Job.create!(company: second_company, title: 'Analista de software', 
                                 description: 'Vai analisar bastante software',
                                 pay_scale: 'R$3000 - R$4000' , requirements: 'Experiêcia no ramo', 
                                 expiration_date: '25/06/2025', job_openings: 4, levels:[second_level])
        first_job_seeker = JobSeeker.create!(email: 'guilherme@gmail.com', password: '123456', 
                                       social_name: 'Guilherme', cpf: '33.222.111/4',
                                       phone: '+55 11 989048658', cv: 'Experiência em
                                       programar')
        second_job_seeker = JobSeeker.create!(email: 'bruna@yahoo.com', password: '123456', 
                                              social_name: 'Bruna', cpf: '44.333.222/1',
                                              phone: '+55 11 93925-8796', cv: 'Experiência em
                                              programar')
        first_job_seeker.apply_to!(first_job)                
        first_job_seeker.apply_to!(second_job)                
        first_job_seeker.apply_to!(third_job)                
        first_job_seeker.apply_to!(fourth_job)                
        second_job_seeker.apply_to!(first_job)                
        second_job_seeker.apply_to!(second_job)                
        second_job_seeker.apply_to!(third_job)                
        second_job_seeker.apply_to!(fourth_job)
        first_job_seeker.reload
        second_job_seeker.reload

        first_company_job_seekers = JobSeeker.all_applied_job_seekers(first_company).count
        second_company_job_seekers = JobSeeker.all_applied_job_seekers(second_company).count

        expect(first_company_job_seekers).to eq 2
        expect(second_company_job_seekers).to eq 2
      end
    end
  end
end
