<h1 align="center">Balcão de Negócios</h1>

<h2> Descrição do projeto</h2>
<p align="justify">
Esse projeto tem o intuito de criar uma plataforma 
para que empresas possam publicar suas vagas e
pessoas possam procurar por elas.
</p>

> Status do Projeto: Em desenvolvimento :warning:

<h2>Funcionalidades básicas</h2>

- [x] Colaborador cria uma conta usando e-mail da empresa;
- [x] Colaborador preenche dados da empresa, caso seja a primeira pessoa da empresa a se
      cadastrar;
- [x] Colaborador cadastra uma nova vaga de emprego;
- [x] Visitante navega pelo site e vê as empresas cadastradas;
- [x] Visitante decide se inscrever para uma vaga;
- [x] Visitante cria sua conta e preenche um perfil para confirmar sua candidatura;
- [x] Colaborador da empresa visualiza as candidaturas recebidas;
- [ ] Colaborador da empresa faz uma proposta para um candidato; 
- [ ] Candidato (agora autenticado) visualiza as propostas recebidas;
- [ ] Colaborador ou candidato podem aceitar/reprovar uma candidatura.

<h2>Funcionalidades adicionais</h2>

- [ ] Empresa possui banco de currículos;
- [ ] Colaborador configura características das vagas;

- [ ] Modo Administrativo:

  - [ ] Bloquear usuários
  - [ ] Gerenciar Empresas
  - [ ] Desativar Empresa

<h2>Pré-requisitos</h2>

:heavy_check_mark: Ruby: versão 2.7.2 <br>
:heavy_check_mark: [node.js](https://github.com/nodesource/distributions/blob/master/README.md): versão 10.19.0 <br>
:heavy_check_mark: [yarn](https://classic.yarnpkg.com/en/docs/usage): versão 1.22.5 <br>

Para instalar os pré-requisitos basta seguir as informações de documentação delas.

<h2>Dependências

:heavy_check_mark: [rspec-rails](https://github.com/rspec/rspec-rails): versão 4.0.2 <br>
:heavy_check_mark: [capybara](https://github.com/teamcapybara/capybara) <br>
:heavy_check_mark: [devise](https://github.com/heartcombo/devise)<br>
:heavy_check_mark: [rubocop](https://github.com/teamcapybara/capybara)<br>


<h2>Como rodar a aplicação</h2>

No terminal clone o projeto:

```
git clone https://github.com/Guilherme4857/job-system
```

Instale as dependências:

```
bundle exec bin/setup
```

Carregue as informações do seeds no banco de dados:

```
rails db:seed
```

<h2>Informações importantes carregadas pelo seeds</h2>

Empresas:

|name|cnpj|site|company_history|
| -------- | -------- | -------- | -------- |
|Campus Code|33.222.111/0050-46|http://www.campuscode.com.br|Vem crescendo bastante|
|Rebase|44.333.222/0200-50|https://www.rebase.com.br/|Evoluíu a cada dia|

Colaboradores:

|email|password|company|status|
| -------- | -------- | -------- | -------- |
|joao@campuscode.com.br|123456|Campus Code|admin|
|henrique@campuscode.com.br|123456|Campus Code|common|
|leticia@rebase.com.br|123456|Rebase|admin|
|andre@rebase.com.br|123456|Rebase|common|

Vagas:

|company|title|expiration_date|
| -------- | -------- | -------- |
|Campus Code|Desenvolvedor Ruby|23/04/2024|
|Rebase|Analista de software|25/06/2025|

Visitantes/Candidatos

|email|password|applied to Desenvolvedor Ruby|applied to Analista de software|
| -------- | -------- | -------- | -------- |
|guilherme@gmail.com|123456|false|false|
|bruna@yahoo.com|123456|false|false|
|vanessa@gmail.com|123456|false|false|
|camilla@gmail.com|123456|false|false|

Use o seguinte comando para rodar os testes:

```
rspec
```