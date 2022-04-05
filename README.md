O desafio consiste em popular duas tabelas no mysql com os estados e cidades do Brasil consumindo as API do IBGE:

'https://servicodados.ibge.gov.br/api/v1/localidades/estados'    -   Coleta informações do estado.
'https://servicodados.ibge.gov.br/api/v1/localidades/estados/ID_ESTADO/distritos'   -   Coleta as cidades conforme o ID_ESTADO;

Editar o arquivo database.dart com as informações da sua base de dados !!!!!!!!!!

Script de criação das tabelas:

CREATE TABLE estado (
  id int not null primary key auto_increment,
  uf varchar(2),
  nome varchar(255)
);


CREATE TABLE cidade (
  id int not null primary key auto_increment,
  id_uf int,
  nome varchar(255),
   FOREIGN KEY (id_uf)
      REFERENCES estado(id)
);​