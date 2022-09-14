
# Task list

## Sobre
Aplicação desenvolvida utilizando Ruby on Rails com o intuito auxiliar na gestão de atividades, permitindo o cadastro de projetos e tarefas. 
Projeto proposto pelo [desafio Artia](https://github.com/Artia/desafios-desevolvimento/blob/master/desafio-fullstack.md).

## Como rodar o projeto

Clone o repositório com o comando abaixo
```sh
git clone https://github.com/leandropp83/task-list-rails.git --config core.autocrlf=input
```

Acesse a pasta do projeto
```sh
cd task-list-rails/
```

Suba os containers
```sh
docker-compose up -d
```

Crie as tabelas do banco
```sh
docker-compose exec app rails db:migrate
```

Acesse o projeto
[http://localhost:3000](http://localhost:3000)


## Testes

Execute o comando abaixo para rodar os testes
```sh
docker-compose exec app bundle exec rspec
```
