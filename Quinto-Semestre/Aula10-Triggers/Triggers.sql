CREATE TABLE pessoa 
(id INT PRIMARY KEY,
nome VARCHAR(50),
email VARCHAR(50));


-- registrar os gatilhos
CREATE TABLE registro_log
(dt_op DATE,
hr_op TIME,
ds_op VARCHAR(100));


-- criando um gatilho
delimiter $
CREATE OR REPLACE TRIGGER tg_inserindo_pessoa
	AFTER INSERT ON pessoa FOR EACH ROW
BEGIN
	INSERT INTO registro_log (dt_op, hr_op, ds_op)
		VALUES (CURDATE(), CURTIME(), CONCAT('inserido row pessoa id: ', NEW.id));
END $
-- CURDATE retorna data instantãnea do servidor
-- CURTIME retorna a hora intantânea do servidor
-- CONCAT concatena loterais/string 

-- testando gatilho (inserindo dado em pessoa)
INSERT INTO pessoa (id, nome , email)
VALUES
(1, 'Pessoa 1', 'pessoa1@email');


delimiter $
CREATE OR REPLACE TRIGGER tg_inserindo_pessoa
	BEFORE UPDATE ON pessoa FOR EACH ROW
BEGIN
	INSERT INTO registro_log (dt_op, hr_op, ds_op)
		VALUES (CURDATE(), CURTIME(), CONCAT('inserido row pessoa id: ', OLD.id,'para: ', NEW.id));
END $


UPDATE pessoa SET id=11 WHERE id=1;


-- identificando rotinas criadas
SELECT 
FROM information_schema.routines r
WHERE r.routine_schema = 'base_pl_testes';


-- 1. Criação das Tabelas (Ordem correta para evitar erros de FK)

CREATE TABLE cliente (
    cd_cliente INTEGER NOT NULL AUTO_INCREMENT,
    nm_cliente VARCHAR(255) NOT NULL,
    nr_telefone VARCHAR(15) NULL,
    dt_nascimento DATE NULL,
    PRIMARY KEY (cd_cliente)
) ENGINE=InnoDB;

CREATE TABLE Medicamento (
    cd_medicamento INTEGER NOT NULL AUTO_INCREMENT,
    nm_medicamento VARCHAR(50) NOT NULL,
    ds_medicamento VARCHAR(200),
    vl_custo DECIMAL(8,2) DEFAULT 0,
    vl_venda DECIMAL(8,2) DEFAULT 0,
    qt_estoque INTEGER DEFAULT 0,
    PRIMARY KEY (cd_medicamento)
) ENGINE=InnoDB;

CREATE TABLE NotaFiscal (
    nr_notafiscal INTEGER NOT NULL AUTO_INCREMENT,
    cd_cliente INTEGER NOT NULL,
    dt_emissao DATE,
    vl_total DECIMAL(8,2) DEFAULT 0,
    PRIMARY KEY (nr_notafiscal),
    CONSTRAINT fk_nf_cliente FOREIGN KEY (cd_cliente) REFERENCES cliente(cd_cliente)
) ENGINE=InnoDB;

CREATE TABLE ItemNotaFiscal (
    nr_notafiscal INTEGER NOT NULL,
    cd_medicamento INTEGER NOT NULL,
    qt_vendida INTEGER DEFAULT 0,
    vl_venda DECIMAL(8,2) DEFAULT 0,
    PRIMARY KEY (nr_notafiscal, cd_medicamento),
    CONSTRAINT fk_item_nf FOREIGN KEY (nr_notafiscal) REFERENCES NotaFiscal(nr_notafiscal),
    CONSTRAINT fk_item_med FOREIGN KEY (cd_medicamento) REFERENCES Medicamento(cd_medicamento)
) ENGINE=InnoDB;

-- 2. Inserção de Dados: Clientes

INSERT INTO cliente (nm_cliente, nr_telefone, dt_nascimento) VALUES ('Ana Clara Mendes', '(11) 91234-5678', '1995-04-12');
INSERT INTO cliente (nm_cliente, nr_telefone, dt_nascimento) VALUES ('Bruno Alves', '(21) 99876-5432', '1988-11-03');
INSERT INTO cliente (nm_cliente, nr_telefone, dt_nascimento) VALUES ('Carlos Eduardo', NULL, '1979-07-22');
INSERT INTO cliente (nm_cliente, nr_telefone, dt_nascimento) VALUES ('Daniela Souza', '(31) 98765-4321', NULL);
INSERT INTO cliente (nm_cliente, nr_telefone, dt_nascimento) VALUES ('Eduarda Lima', '(41) 99123-4567', '2000-01-15');

-- 3. Inserção de Dados: Medicamentos

INSERT INTO Medicamento (nm_medicamento, ds_medicamento, vl_custo, vl_venda, qt_estoque) VALUES 
('Benegripe', 'Remédio pra gripe', 5.0, 10.0, 11),
('Aspirina C', 'Remédio pra aumentar a resistência', 7.0, 11.0, 22),
('Dermatos', 'Remédio pra dores', 20.0, 30.0, 33),
('Cataflan', 'Remédio pra dor de garganta', 10.0, 15.0, 44),
('Remédio 5', 'Remédio pra dores na barriga', 35.0, 50.0, 55),
('Benegripe Genérico', 'Remédio pra gripe genérico', 9.0, 15.0, 66),
('Dermatos Genérico', 'Remédio pra dores genérico', 50.0, 70.0, 77),
('Vodol 50mg', 'Remédio para micose', 21.20, 28.90, 30),
('Vick', 'Pastilha para garganta', 11.50, 17.50, 80),
('Doralgina', 'Remédio para dor de cabeça', 9.90, 15.0, 10);


delimiter $ 
create or replace trigger tg_venda_medicamento before insert 
	on itemnotafical for each row
begin
	declare v_valor_met decimal(8,2) default 0.0;
	declare v_estoque_med int default 0;
    -- obtendo a qntdd em estoque de medicamento
	select m.qt_estoque into v_estoque_med -- atribui ao estoque
	from medicamento m where m.cd_medicamneto = new.cd_medicamento;
   -- baixando a qntd do estoque
	if v_estoque_med < new.qt_vendida then
	signal sqlstate '45000' set message_text = 'Estoque insuficiente!'; -- tratamento
	end if;
    -- baixando a qntdd de estoque
	update medicamento m
		set m.qt_estoque = m.qt_estoque - NEW.qt_vendida
		where m.cd_medicamento = NEW.cd_medicamento;
		-- obtendo o valor do medicamento
		select m_vl_valor into v_valor_med from medicamento m 
		where m_cd_medicamento = new_cd_medicamento;
      -- ajustando o valor da venda
		set new.vl_venda = v_valor_med; -- atualiza valores
		-- atualizando o valor total da nf
		UPDATE notafiscal nf SET nf.vl_total = nf.vl_total + (NEW.qt-vendida * NEW  .vl_venda)
		WHERE nf.nr_notafiscal = NEW.nr_notafiscal;
end $


-- testando gatilho
INSERT INTO cliente (nm_cliente) VALUES ('Mariu');
INSERT INTO notafiscal (cd_cliente) VALUES ();
DELETE FROM 
INSERT INTO itemnotafiscal (nr_notafiscal, cd_medicamento, qt_vendida, vl_venda) VALUES (1, 1, 2, 0);

SELECT * FROM medicamento;
