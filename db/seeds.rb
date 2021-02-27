employees = Employee.create!([{email: 'joao@campuscode.com.br', password: '123456', status: 'admin'}, 
                              {email: 'henrique@campuscode.com.br', password: '123456'},
                              {email: 'leticia@rebase.com.br', password: '123456', status: 'admin'},
                              {email: 'andre@rebase.com.br', password: '123456'}])

companies = Company.create!([{name: 'Campus Code', cnpj: '33.222.111/0050-46',
                              site: 'http://www.campuscode.com.br',
                              company_history: 'Vem crescendo bastante',
                              employees: [employees[0], employees[1]]},
                             {
                              name: 'Rebase', cnpj: '44.333.222/0200-50',
                              site: 'https://www.rebase.com.br/',
                              company_history:'Evoluiu a cada dia',
                              employees: [employees[2], employees[3]]}])

company_social_webs = CompanySocialWeb.create!([{company:companies[0], address_web:'http://www.linkedin.com/school/campus-code/'},
                                                {company:companies[0], address_web: 'http://www.facebook.com/CampusCodeBr/'},
                                                {company:companies[0], address_web: 'http://www.twitter.com/campuscodebr'}, 
                                                {company:companies[1], address_web:'https://www.linkedin.com/company/rebasebr/'},
                                                {company:companies[1], address_web:'https://twitter.com/rebasebr'}])
company_address = CompanyAddress.create!([{company:companies[0], public_place: 'Rua Cícero, 41',
                                           district: 'Anhembi', city: 'São Paulo', 
                                           zip_code: '41002-241'},
                                          {company:companies[1], public_place: 'Rua Albertino, 90',
                                           district: 'Itaim', city: 'São Paulo',
                                           zip_code: '39415-245'}])


levels = Level.create!([{name: 'júnior'}, {name: 'pleno'}, {name: 'sênior'}])

jobs = Job.create!([{company: companies[0], title: 'Desenvolvedor Ruby',
                     description: 'Vai desenvolver aplicações utilizando ruby',
                     pay_scale: 'R$2000 - R$2600', requirements: 'Saber ruby',
                     expiration_date: '23/04/2024', job_openings: 4, levels: [levels[0]]},
                    {
                     company: companies[1], title: 'Analista de software',
                     description: 'Vai analisar bastante software',
                     pay_scale: 'R$3000 - R$4000', requirements: 'Experiêcia no ramo',
                     expiration_date: '25/06/2025', job_openings: 4, levels:[levels[0]]}])

job_seekers = JobSeeker.create!([{email: 'guilherme@gmail.com', password: '123456', 
                                   social_name: 'Guilherme', cpf: '33.222.111/4',
                                   phone: '+55 11 989048658', cv: 'Experiência em programar'},
                                  {email: 'bruna@yahoo.com', password: '123456', 
                                   social_name: 'Bruna', cpf: '44.333.222/1',
                                   phone: '+55 11 93925-8796', cv: 'Experiência em programar'},
                                  {email: 'vanessa@gmail.com', password: '123456', 
                                   social_name: 'Vanessa', cpf: '55.444.333/2',
                                   phone: '+55 11 99388-9300', cv: 'Experiência em programar'},
                                  {email: 'camilla@gmail.com', password: '123456', 
                                  social_name: 'Camilla', cpf: '66.555.444/3',
                                  phone: '+55 19 94485-7601', cv: 'Experiência em programar'}])