 - Sistema de Controle de Contas.

* A função da aplicação é o gerenciamento de valores entre contas.

- O sistema possui 4 Módulos:
- Cadastro de Clientes(Que podem ser Pessoa Física ou Jurídica);
- Cadastro de Contas(Que podem ser filiais ou matrizes);
- Realização de Transferências,Aportes e Estorno;
- Visualização de Histórico de Transferências e Aportes; 

* A aplicação foi desenvolvida utilizando Ruby on Rails com banco de dados SQLITE3;
* As validações do Frontend são feitas em JQuery;
* As validações de regras de negócio estão sendo feitas no Backend;

* Para execução do projeto, devem ser executados os seguintes comandos:

- bundle install
- bundle exec rake db:create db:migrate
- rails server

* Considerações sobre funcionalidades do sistema:

- Para acessar o Sistemam, com o servidor rodando, acessa através de: http://localhost:3000/clientes;
- Todos as telas podem ser acessadas pelos Menus que se encontram na parte superior das telas; (Cliente, Conta, Histórico, Transferência)
- Tenha em mente que Toda conta deve ter um Cliente;(Que pode ser uma Pessoa Física ou Pessoa Jurídica)
- O fluxo de uso é: Cadastrar os Clientes, Cadastrar as Contas, Realizar a Transferência entre contas e Visualizar as operações de Transferência ou Estornar as mesmas pela tela de históricos;



