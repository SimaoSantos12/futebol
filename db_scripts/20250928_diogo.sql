--/////////////////////////////////////////////////////////

--      CRIAR UMA BASE DE DADOS COM O NOME futebol

--/////////////////////////////////////////////////////////


CREATE TABLE utilizador (
    gid SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    "password" TEXT NOT NULL,
    createdon DATETIME DEFAULT CURRENT_TIMESTAMP,
    updateon DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tipo_posicao (
    gid SERIAL PRIMARY KEY,
    abreviatura VARCHAR(5) UNIQUE NOT NULL,
    descricao TEXT,
    estado VARCHAR(1) NOT NULL DEFAULT 'A' CHECK (estado IN ('A', 'Y', 'Z'))
);

INSERT INTO tipo_posicao (gid, abreviatura, descricao) VALUES
(1, 'GK', 'Jogador responsável por defender a baliza e evitar golos.'),
(2, 'CB', 'Jogador que atua no centro da defesa, protegendo a área contra ataques.'),
(3, 'LB', 'Jogador que defende pelo lado esquerdo e apoia o ataque pelas alas.'),
(4, 'RB', 'Jogador que defende pelo lado direito e pode apoiar ofensivamente.'),
(5, 'CDM', 'Jogador que atua à frente da defesa, recuperando bolas e protegendo a linha defensiva.'),
(6, 'CM', 'Jogador que organiza o jogo no meio-campo, ligando defesa e ataque.'),
(7, 'CAM', 'Jogador criativo que atua atrás dos avançados, criando oportunidades de golo.'),
(8, 'LM', 'Jogador que atua no meio-campo pelo lado esquerdo, com funções defensivas e ofensivas.'),
(9, 'RM', 'Jogador que atua no meio-campo pelo lado direito, apoiando defesa e ataque.'),
(10, 'LW', 'Jogador ofensivo que atua pelas alas, especialmente pelo lado esquerdo.'),
(11, 'RW', 'Jogador ofensivo que atua pelas alas, especialmente pelo lado direito.'),
(12, 'CF', 'Jogador ofensivo que atua no centro do ataque, com mobilidade e finalização.'),
(13, 'ST', 'Principal finalizador da equipa, com foco em marcar golos.');

SELECT setval('tipo_posicao_gid_seq', (SELECT MAX(gid) FROM tipo_posicao));

CREATE TABLE jogador_futebol (
    gid SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    id_tipo_posicao VARCHAR(50),
    createdon DATETIME DEFAULT CURRENT_TIMESTAMP,
    updateon DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO jogador_futebol (nome, id_tipo_posicao) VALUES
('Nicolás Otamendi', 2),
('Bruma', 10),
('Fredrik Aursnes', 6),
('Evangelos Pavlidis', 13),
('Florentino Luís', 5),
('Kerem Aktürkoğlu', 10),
('Alexander Bah', 4),
('Leandro Martins', 5),
('Anatolii Trubin', 1),
('Tiago Gouveia', 11),
('Amar Dedić', 4),
('Samuel Dahl', 3),
('Samuel Soares', 1),
('Tomás Araújo', 2),
('Enzo Barrenechea', 6),
('Henrique Araújo', 13),
('António Silva', 2),
('Richard Rios', 6),
('Andreas Schjelderup', 10),
('Rafael Obrador', 3),
('Manu Silva', 6),
('Franjo Ivanovic', 12),
('Joshua Wynder', 2),
('Gianluca Prestianni', 11),
('Diogo Prioste', 7),
('João Veloso', 6),
('Diogo Ferreira', 1),
('João Pedro Rego', 13),
('Gonçalo Calisto Oliveira', 2),
('Leandro', 2),
('Gonçalo Sobral', 1);

