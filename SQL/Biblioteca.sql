create database Biblioteca
default character set utf8
default collate utf8_general_ci;
SET default_storage_engine = InnoDB;

/*---------------------- Tabela Biblioteca----------------------*/
create table biblioteca(
id_bibioteca int primary key auto_increment,
nome varchar(30) default "Santra Business",
NIF varchar(20) not null default "220LA488",
Email varchar(100) not null Default "santrasampaio@gmail.com",
Endereço varchar(100) not null default "Angola-Luanda, Luanda, Largo da Maianga",
Telefone varchar(20) not null unique default "+244999999999"
);

/*---------------------- Tabela Estante----------------------*/
create table estante (
id_estante int primary key auto_increment,
nome varchar(30),
cap_total int,
id_biblioteca int,
foreign key (id_biblioteca) references biblioteca(id_biblioteca)
);

/*---------------------- Tabela Prateleira----------------------*/
create table prateleira(
id_prateleira int primary key auto_increment,
nome varchar(30),
cap_total int,
id_estante int,
foreign key (id_estante) references estante (id_estante)
);

/*---------------------- Tabela Fornecedor----------------------*/
create table  fornecedor(
id_fornecedor int primary key auto_increment,
nome varchar(30) not null,
NIF int Unique not null,
telefone varchar(15) not null unique,
email varchar(50) not null unique
);

/*---------------------- Tabela Livro----------------------*/
create table livro(
id_livro int primary key auto_increment ,
nome varchar(50) not null ,
categoria varchar(50),
descricao text,
ano year,
autor varchar(50),
idioma varchar (20),
preco_venda decimal (10,2),
preco_compra decimal(10,2),
paginas int

);


/*---------------------- Tabela entrada----------------------*/
CREATE TABLE entrada (
  id_entrada int primary key AUTO_INCREMENT,
  recibo varchar(20) DEFAULT NULL,
  data_entrada timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  notas text,
  id_biblioteca int,
  id_fornecedor int,
  
FOREIGN KEY (id_biblioteca) REFERENCES biblioteca (id_biblioteca),
FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*---------------------- Tabela Item entrada----------------------*/
CREATE TABLE item_entrada (
  id_item_entrada int primary key AUTO_INCREMENT,
  id_entrada int,
  id_livro int,
  quantidade_adquirida int DEFAULT NULL,
  preco_unitario decimal(10,2) DEFAULT NULL,

FOREIGN KEY (id_entrada) REFERENCES entrada (id_entrada),
FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*---------------------- Tabela Cliente----------------------*/
CREATE TABLE cliente (
  id_cliente int primary key AUTO_INCREMENT,
  nome varchar(50) NOT NULL,
  telefone varchar(15) NOT NULL,
  email varchar(50) NOT NULL,
  endereco varchar(50) NOT NULL,
  data_nascimento date NOT NULL,
  data_cadastro timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
tipo_cliente varchar(10) default "fixo"

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*---------------------- Tabela Estoque----------------------*/
CREATE TABLE estoque (
  id_estoque int primary key AUTO_INCREMENT,
  quantidade_total int NOT NULL,
  quantidade_disponivel int NOT NULL,
  id_livro int,
  id_prateleira int,
  id_estante int,


FOREIGN KEY (id_estante) REFERENCES estante (id_estante),
FOREIGN KEY (id_prateleira) REFERENCES prateleira (id_prateleira),
FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


/*---------------------- Tabela Venda----------------------*/
create table venda(
id_venda int primary key auto_increment,
id_biblioteca int,
id_cliente int,
data_venda timestamp NULL DEFAULT CURRENT_TIMESTAMP,
notas text,
status_venda ENUM('aberta', 'concluida', 'cancelada') default "Concluída",
total_venda decimal(10,2),

foreign key (id_biblioteca) references biblioteca (Id_biblioteca),
foreign key (id_cliente) references cliente (id_cliente)

);


/*---------------------- Tabela Item Venda----------------------*/
create table item_venda(
id_item_venda int primary key auto_increment,
id_livro int,
id_venda int,
quantidade int,
preco_unitario decimal(10,2),

foreign key (id_livro) references livro (id_livro),
foreign key(id_venda) references venda (id_venda)

);
/*---------------------- Tabela emprestimo----------------------*/
create table emprestimo(
id_emprestimo int primary key auto_increment,
id_biblioteca int,
id_cliente int,
data_emprestimo timestamp Not NULL DEFAULT CURRENT_TIMESTAMP,
data_prev_devolucao date not null,
data_devolucao date null,
notas text,
status_emprestimo ENUM('aberto', 'atrasado', 'concluido') default "aberto",
valor_multa DECIMAL(10,2) NULL,
status_pagamento_multa ENUM ("Ativo","Não aplicável") DEFAULT 'Não Aplicável',

foreign key (id_biblioteca) references biblioteca (Id_biblioteca),
foreign key (id_cliente) references cliente (id_cliente)
);


/*---------------------- Tabela Item_Empréstimo----------------------*/
create table item_emprestimo(
id_item_emprestimo int primary key auto_increment,
id_emprestimo int,
id_livro int,
status_item_emprestimo ENUM('emprestado', 'devolvido') default "emprestado",
foreign key (id_livro) references livro (id_livro),
foreign key (id_emprestimo) references emprestimo (id_emprestimo)
);



/*
select * from estoque;
ALTER table estoque
change id_estoque id_estoque int primary key auto_increment;

ALTER TABLE estoque
ADD CONSTRAINT id_estante
FOREIGN KEY (id_estante) REFERENCES estante (id_estante);

ALTER TABLE estoque
add column id_estante int after id_livro;


select * from estoque;
*/

alter table estoque 
drop id_estante;

select * from estoque;
