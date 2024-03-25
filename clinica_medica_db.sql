CREATE DATABASE db_clinica1;
USE db_clinica1;

CREATE TABLE tbl_cliente(
  CPF_cliente varchar(11) not null primary key,
  telefone_cliente varchar(11),
  nome_cliente varchar(50) not null,
  endereco_cliente varchar(60),
  email_cliente varchar(30)
);

CREATE TABLE tbl_medico(
  CRM_medico varchar(9) primary key not null,
  especialidade_medico varchar(20) not null,
  nome_medico varchar(35) not null
);

INSERT INTO tbl_cliente (CPF_cliente, telefone_cliente, nome_cliente, endereco_cliente, email_cliente)
VALUES
  ('66672891572', '11983018866', 'Fernanda Machado', 'rua Barril', 'fernanda76@outlook.com'),
  ('99954886754', '21986743356', 'Lebron Silva', 'rua James', 'lebron6@outlook.com'),
  ('88854867572', '75991675563', 'Cristiano Aveiro', 'rua Kobe', 'cristiano7@yahoo.com'),
  ('77745806972', '75983416685', 'Neymar Junior', 'rua Pelé', 'neymar10@gmail.com'),
  ('44454891572', '21980135566', 'Vinicius Junior', 'rua Nazario', 'vinijr20@outlook.com');

INSERT INTO tbl_medico (CRM_medico, especialidade_medico, nome_medico)
VALUES
  ('923456789', 'Generalista', 'Paulo Muzy'),
  ('456789123','Ortopedista', 'Gabriel Junior'),
  ('789123456','Cardiologista', 'Davi Cunha');

CREATE TABLE IF NOT EXISTS relatorio_medico(
  ID_relatorio smallint not null primary key,
  data_relatorio date,
  diagnostico_relatorio varchar (30),
  medicacao_prescrita_relatorio varchar (40),
  CPF_cliente varchar(11) DEFAULT NULL,
  CRM_medico varchar(9) DEFAULT NULL,
  CONSTRAINT fk_CPF_cliente FOREIGN KEY (CPF_cliente) REFERENCES tbl_cliente (CPF_cliente) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_CRM_medico FOREIGN KEY (CRM_medico) REFERENCES tbl_medico (CRM_medico) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_convenio(
  matricula_convenio smallint primary key,
  nome_convenio varchar (15),
  CPF_cliente_convenio VARCHAR(11) ,
  CONSTRAINT fk_CPF_cliente_convenio FOREIGN KEY (CPF_cliente_convenio) REFERENCES tbl_cliente(CPF_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO tbl_convenio (matricula_convenio, nome_convenio, CPF_cliente_convenio) 
VALUES
('111','flamed', '66672891572'),
('112','bamed', '99954886754');

CREATE TABLE tbl_particular(
  ID_particular smallint primary key auto_increment,
  valor_particular varchar(8),
  CPF_cliente_particular VARCHAR(11) NOT NULL,
  CONSTRAINT fk_CPF_cliente_particular FOREIGN KEY (CPF_cliente_particular) REFERENCES tbl_cliente(CPF_cliente) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO tbl_particular (ID_particular, valor_particular, CPF_cliente_particular)
VALUES 
('201', 325.00, '77745806972'),
('202', 369.00, '44454891572'),
('203', 375.00, '88854867572');

CREATE TABLE tbl_consulta(
  ID_consulta smallint primary key not null,
  data_consulta date,
  procedimento varchar(50),
  CRM_medico_consulta VARCHAR(9) NOT NULL,
  CONSTRAINT fk_CRM_medico_consulta FOREIGN KEY (CRM_medico_consulta) REFERENCES tbl_medico (CRM_medico) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO relatorio_medico (ID_relatorio, data_relatorio,diagnostico_relatorio, medicacao_prescrita_relatorio, CPF_cliente, CRM_medico)
VALUES
  (10, '2022-12-31','gripe', 'benegrip','66672891572', '923456789'),
  (11, '2022-07-29', 'fratura', 'cronidor','99954886754', '456789123'),
  (12, '2023-01-23', 'covid-19', 'cloroquina','77745806972', '923456789'),
  (13, '2022-12-31', 'arritmia', 'atenolol','88854867572', '789123456'),
  (14, '2022-05-25', 'virose', 'benegrip','44454891572', '923456789');

SELECT nome_cliente AS Clientes_Gmail, CPF_cliente 
FROM tbl_cliente
WHERE email_cliente  like '%gmail.com';

SELECT nome_cliente  AS Clientes_sem_Gmail, CPF_cliente
FROM tbl_cliente
WHERE email_cliente not like '%gmail.com';

SELECT nome_cliente, telefone_cliente
FROM tbl_cliente
WHERE CPF_cliente BETWEEN '77700000000' AND '99999999999';

SELECT AVG(valor_particular) AS Media__Valores_Particular
FROM tbl_particular;

SELECT nome_medico AS Medicos
FROM tbl_medico
WHERE CRM_medico BETWEEN '600000000' AND '999999999';

SELECT SUM(valor_particular) AS Valor_Total_Particular
FROM tbl_particular;

SELECT nome_cliente AS Clientes, telefone_cliente AS Telefone
FROM tbl_cliente
WHERE telefone_cliente NOT LIKE '75%';

SELECT tbl_particular.ID_particular, tbl_particular.CPF_cliente_particular, tbl_cliente.nome_cliente
FROM tbl_particular
INNER JOIN tbl_cliente
ON tbl_particular.CPF_cliente_particular = tbl_cliente.CPF_cliente
WHERE tbl_particular.valor_particular < '375.00';

SELECT tbl_particular.ID_particular, tbl_cliente.nome_cliente
FROM tbl_particular
INNER JOIN tbl_cliente
ON tbl_particular.CPF_cliente_particular = tbl_cliente.CPF_cliente
WHERE tbl_particular.CPF_cliente_particular < '99000000000';

SELECT data_relatorio, diagnostico_relatorio
FROM relatorio_medico
WHERE data_relatorio between '2022-06-09' AND '2022-12-31'
ORDER BY data_relatorio;

SELECT relatorio_medico.diagnostico_relatorio, tbl_cliente.nome_cliente
FROM relatorio_medico
INNER JOIN tbl_cliente
ON relatorio_medico.CPF_cliente = tbl_cliente.CPF_cliente;