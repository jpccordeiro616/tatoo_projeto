DROP DATABASE IF EXISTS tinta_viva;
CREATE DATABASE tinta_viva
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE tinta_viva;

-- Categorias de serviço
CREATE TABLE categorias (
  id        INT AUTO_INCREMENT PRIMARY KEY,
  nome      VARCHAR(60)  NOT NULL UNIQUE,
  descricao VARCHAR(255)
);

-- Serviços oferecidos pelo estúdio
CREATE TABLE servicos (
  id               INT AUTO_INCREMENT PRIMARY KEY,
  categoria_id     INT            NOT NULL,
  nome             VARCHAR(100)   NOT NULL,
  descricao        TEXT           NOT NULL,
  preco_a_partir   DECIMAL(10,2)  NOT NULL CHECK (preco_a_partir >= 0),
  duracao_estimada VARCHAR(40)    NOT NULL,
  imagem_url       VARCHAR(500),
  destaque         BOOLEAN        NOT NULL DEFAULT FALSE,
  criado_em        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_servicos_categoria
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Mensagens recebidas pelo formulário de contato
CREATE TABLE contatos (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  nome        VARCHAR(100) NOT NULL,
  email       VARCHAR(150) NOT NULL,
  telefone    VARCHAR(20)  NOT NULL,
  servico_id  INT NULL,
  mensagem    TEXT         NOT NULL,
  enviado_em  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_contatos_servico
    FOREIGN KEY (servico_id) REFERENCES servicos(id)
    ON UPDATE CASCADE ON DELETE SET NULL
);

--  Dados iniciais
INSERT INTO categorias (id, nome, descricao) VALUES
  (1, 'Tatuagem', 'Trabalhos autorais e personalizados em diversos estilos'),
  (2, 'Piercing', 'Perfurações com joias de titânio e material esterilizado'),
  (3, 'Cuidados', 'Retoques, cobertura e serviços complementares');

INSERT INTO servicos
  (categoria_id, nome, descricao, preco_a_partir, duracao_estimada, imagem_url, destaque)
VALUES
  (1, 'Fine Line',
   'Traços finos e delicados, ideais para desenhos minimalistas, botânicos e escritas pequenas.',
   250.00, '1 a 2 horas',
   NULL, TRUE),
  (1, 'Blackwork',
   'Preto sólido, contraste forte e composições geométricas ou ornamentais de grande impacto.',
   400.00, '2 a 4 horas',
   NULL, TRUE),
  (1, 'Realismo',
   'Retratos, animais e cenas com sombreamento suave e profundidade quase fotográfica.',
   900.00, 'Sessão de 5 a 6 horas',
   NULL, TRUE),
  (1, 'Old School',
   'Linhas grossas, cores sólidas e os clássicos do flash tradicional: andorinhas, rosas, âncoras.',
   350.00, '2 a 3 horas',
   NULL, FALSE),
  (1, 'Aquarela',
   'Manchas de cor e degradês que imitam pinceladas, com ou sem contorno em preto.',
   500.00, '3 a 4 horas',
   NULL, FALSE),
  (1, 'Lettering',
   'Frases e nomes com tipografia desenhada à mão: script, gótico, caligrafia e mais.',
   200.00, '1 a 2 horas',
   NULL, FALSE),
  (2, 'Piercing com joia de titânio',
   'Orelha, nariz, sobrancelha ou umbigo, com joia de titânio ASTM F136 inclusa.',
   120.00, '30 minutos',
   NULL, FALSE),
  (3, 'Cobertura (cover-up)',
   'Transformamos aquela tatuagem antiga em um trabalho novo, planejado sobre a pele marcada.',
   600.00, 'Sessão de 3 a 5 horas',
   NULL, FALSE);

INSERT INTO contatos (nome, email, telefone, servico_id, mensagem) VALUES
  ('Mariana Souza', 'mariana@exemplo.com', '(11) 98888-1234', 1,
   'Olá! Quero fazer um ramo de lavanda fine line no antebraço. Têm horário em dezembro?');
