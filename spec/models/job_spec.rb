require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'Job' do
    context '#disable!' do
      it 'successfully' do
        employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
        level = Level.create!(name: 'júnior')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                          utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                          expiration_date: '23/04/2024', job_openings: 4, levels:[level])

        job.disable!
        job.reload
        
        expect(job.disabled?).to eq true
      end
    end 

    context '#enable!' do
      it 'successfully' do
        employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
        level = Level.create!(name: 'júnior')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                          utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                          expiration_date: '23/04/2024', job_openings: 4, levels:[level])
        job.disable!
        
        job.enable!

        expect(job.disabled?).to eq false
      end
    end

    context '.all_enable' do
      it 'successfully' do
        employee = Employee.create!(email: 'joao@campuscode.com', password: '123456')
        company = Company.create!(name: 'Campus Code', cnpj: '33.222.111/0050-46', 
                                  site: 'campuscode.com', company_history: 'Vem crescendo bastante')
        level = Level.create!(name: 'júnior')
        first_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                                utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2024', job_openings: 4, levels:[level])
        second_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                                 utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                 expiration_date: '23/04/2024', job_openings: 4, levels:[level])
        third_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                                utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                expiration_date: '23/04/2020', job_openings: 4, levels:[level])
        fourth_job = Job.create!(company: company, title: 'Desenvolvedor Ruby', description: 'Vai desenvolver aplicações 
                                 utilizando ruby', pay_scale: 'R$2000 - R$2600' , requirements: 'Saber ruby', 
                                 expiration_date: '23/04/2024', job_openings: 4, levels:[level])
        fourth_job.disable!
        enables = Job.all_enable.count
        
        expect(enables).to eq 2
      end
    end
  end
end
