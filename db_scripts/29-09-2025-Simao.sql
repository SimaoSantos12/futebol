
-- Não é datetime, é timestamp

CREATE TABLE utilizador (
    gid SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    "password" TEXT NOT NULL,
    createdon timestamp DEFAULT CURRENT_TIMESTAMP,
    updateon timestamp DEFAULT CURRENT_TIMESTAMP
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


-- id_tipo_posicao tem de ser inteiro
CREATE TABLE jogador_futebol (
    gid SERIAL PRIMARY KEY,
    denominacao VARCHAR(150) NOT NULL,
    id_tipo_posicao INT,
    createdon timestamp DEFAULT CURRENT_TIMESTAMP,
    updateon timestamp DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tipo_posicao)
        REFERENCES tipo_posicao(gid)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);

INSERT INTO jogador_futebol (denominacao, id_tipo_posicao) VALUES
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


--É mais interessnte por liga, que a cidade
CREATE TABLE clube_futebol (
    gid SERIAL PRIMARY KEY,
    denominacao VARCHAR(100) NOT NULL,
    liga VARCHAR(100),
    pais VARCHAR(100),
    funcadao DATE,
    estado VARCHAR(1) NOT NULL DEFAULT 'A' CHECK (estado IN ('A', 'Y', 'Z')),
    createdon timestamp DEFAULT CURRENT_TIMESTAMP,
    updateon timestamp DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO clube_futebol (denominacao, liga, pais, funcadao) VALUES
('SL Benfica', 'Liga Portugal Betclic', 'Portugal', '1904-02-28'),
('FC Porto', 'Liga Portugal Betclic', 'Portugal', '1893-09-28'),
('Sporting CP', 'Liga Portugal Betclic', 'Portugal', '1906-07-01'),
('SC Braga', 'Liga Portugal Betclic', 'Portugal', '1921-01-19'),
('Vitória SC', 'Liga Portugal Betclic', 'Portugal', '1922-09-22'),
('Boavista FC', 'Liga Portugal Betclic', 'Portugal', '1903-08-01'),
('FC Famalicão', 'Liga Portugal Betclic', 'Portugal', '1931-08-21'),
('Rio Ave FC', 'Liga Portugal Betclic', 'Portugal', '1939-05-10'),
('GD Estoril Praia', 'Liga Portugal Betclic', 'Portugal', '1939-05-17'),
('Casa Pia AC', 'Liga Portugal Betclic', 'Portugal', '1920-07-03'),
('Moreirense FC', 'Liga Portugal Betclic', 'Portugal', '1938-11-01'),
('FC Vizela', 'Liga Portugal Betclic', 'Portugal', '1939-01-01'),
('Gil Vicente FC', 'Liga Portugal Betclic', 'Portugal', '1924-05-03'),
('Portimonense SC', 'Liga Portugal Betclic', 'Portugal', '1914-08-14'),
('FC Arouca', 'Liga Portugal Betclic', 'Portugal', '1951-12-25'),
('Estrela da Amadora', 'Liga Portugal Betclic', 'Portugal', '1932-01-01'),
('AVS Futebol SAD', 'Liga Portugal 2', 'Portugal', '1930-01-01'),
('FC Alverca', 'Liga Portugal 2', 'Portugal', '1939-01-01'),
('CD Nacional', 'Liga Portugal 2', 'Portugal', '1910-12-08');

ALTER TABLE jogador_futebol
ADD COLUMN id_clube INTEGER,
ADD CONSTRAINT fk_jogador_clube
    FOREIGN KEY (id_clube)
    REFERENCES clube_futebol(gid)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

UPDATE jogador_futebol
SET id_clube = 1;


delete from jogador_futebol
where denominacao = 'Leandro';

CREATE OR REPLACE VIEW view_jogadores_clubes AS
SELECT 
    j.denominacao AS jogador,
    j.id_tipo_posicao,
    p.abreviatura AS posicao,
    j.id_clube,
    c.denominacao AS clube,
    c.liga
FROM jogador_futebol j
JOIN clube_futebol c ON j.id_clube = c.gid
JOIN tipo_posicao p ON j.id_tipo_posicao = p.gid;

INSERT INTO jogador_futebol (denominacao, id_tipo_posicao, id_clube) VALUES
('Diogo Costa', 1, 2),
('Luuk de Jong', 13, 2),
('Jan Bednarek', 2, 2),
('Zaidu', 3, 2),
('Alan Varela', 5, 2);
