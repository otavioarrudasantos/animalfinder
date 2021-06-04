# README

Animal Finder, sistema para publicar e encontrar um animal perdido.

## Como Funciona

- Na Home já irá ser listado todos os animais perdidos
- Caso você encontre um animal, você poderá clicar em "Encontrei!" e informar seus dados de contato para que o dono possa contatar você
- Se seu animal se perdeu de você, "Cadastre-se" e informe os dados de seu animal para que ele seja exibido na listagem.
- Todo comunicado aparecerá quando você clicar no botão Editar.
- Caso queira cancelar sua conta, basta ir em "Perfil" e clicar em "Cancelar".

## Instalação

Ubuntu 20.04

Install: Yarn, NodeJs, Npm, SQLite3

ruby: versão 2.7.0

`sudo apt-get install ruby-full`

Rails 6.1.3.2

`gem install rails`

Ruby Bundler

`sudo apt install ruby-bundler`


- `git clone https://github.com/otavioarrudasantos/animalfinder.git`
- `bundle install`
- `rails db:migrate`
- `rails webpacker:install`
- Rodar servidor de desenvolvimento: `rails s`
- Acessar no browser `http://127.0.0.1:3000/`


Além da instalação padrão do rails, foram instalados os pacotes (todos instalados automaticamente quando o comando `bundle install` é executado):
- `gem 'devise', '~> 4.8'` para autenticação, cadastro e gerenciamento de usuário
- `gem 'will_paginate', '~> 3.1'` para realizar a paginação da lista de animais.


## Estrutura

### Models

- `pet.rb`: Dados do animal
- `seen.rb`: Dados dos comunicados
- `user.rb`: Dados do usuário

OBS: Para armazenar as fotos dos animais, foi utilizado ActiveStorage [Active Storage Doc](https://guides.rubyonrails.org/active_storage_overview.html)

### API REST

API Rest retorna uma lista json de todos os animais cadastrados

- `app/controllers/api/v1/pet_controller.rb`
  - `GET /api/v1/pet` 
    - __Pet#index__: Lista os animais.
  - `GET /api/v1/pet/:id`
    - __Pet#show__: Retorna um animal específico e o link de sua foto.

### WEB

- Página inicial pública
  - `app/controllers/home_controller.rb`
    - Home#index: Retorna os animais
  - Views
    - _partial_ `_header.html.erb` e `_nosession_header.html.erb`: NavBar
    - `index.html.erb`: Home Page. Lista de animais perdidos

- Usuário
  - `app/views/devise/registrations/new.html.erb`: Cadastro de Novo Usuário
  - `app/views/devise/registrations/edit.html.erb`: Editar perfil do usuário

- Pets
  - `app/views/pets/_form.html.erb`: partial utilizado para o formulário.
  - `app/controllers/pets_controller.rb`
    - __Pets#index__: retorna os animais cadastrados pelo usuário logado.
      - `app/views/pets/index.html.erb`
    - __Pets#new__: Formulário para cadastro do animal
      - app/views/pets/new.html.erb
    - __Pets#show__: Exibe detalhes do animal. Habilita botão para editar
       - `app/views/pets/show.html.erb`
    - __Pets#edit__: Exibe formulário para editar informações e também a lista de comunicados
       -  `app/views/pets/edit.html.erb`
    - __Pets#create__: Cadastra o animal.
    - __Pets#update__: Atualiza o animal.
    - __Pets#destroy__: Deleta

- Seen (Comunicados)
  - `/app/views/seen/_form.html.erb`: Partial utilizado para o formulário
  - __Seen#new__: Formulário para cadastrar o comunicado. Retorna informações do animal
    - `app/views/seen/new.html.erb`
  - __Seen#create__: Cria o Comunicado
  - __Seen#destroy__: Deleta o Comunicado. Possui uma lógica if. Enquanto houver um comunicado, o status fica como "comunicado", a não ser que o usuário altere pelo formulário.


## OBS
Desenvolvido utilizando Ubuntu 20.10
Por alguma razão ocorreu este erro:
`[WARNING] Could not load command "rails/commands/application/application_command". Error: superclass mismatch for class Command.`

Foi resolvido desinstalando o pacote _ruby-thor_ e instalando novamente:

`sudo dpkg -r --force-depends  ruby-thor`

`gem install thor`



