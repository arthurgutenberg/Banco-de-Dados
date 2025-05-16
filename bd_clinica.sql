CREATE DATABASE clinica;

USE clinica;

CREATE TABLE paciente(
	idpaciente INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL, 
    cpf VARCHAR(11) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL
);

CREATE TABLE medico(
	idmedico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL, 
    especialidade VARCHAR(50) NOT NULL
);

CREATE TABLE atendimento(
	idatendimento INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    dataatendimento DATE,
    observacoes TEXT,
    FOREIGN KEY(id_paciente) REFERENCES paciente(idpaciente),
    FOREIGN KEY(id_medico) REFERENCES medico(idmedico)
);

CREATE TABLE exame(
	idexame INT PRIMARY KEY AUTO_INCREMENT,
    nomeexame VARCHAR(100) NOT NULL  
);

CREATE TABLE atendimento_exame(
	idatendimento_exame INT PRIMARY KEY AUTO_INCREMENT,
    id_exame INT NOT NULL,
    id_atendimento INT NOT NULL, 
    resultado TEXT,
    FOREIGN KEY(id_exame) REFERENCES exame(idexame),
    FOREIGN KEY (id_atendimento) REFERENCES atendimento(idatendimento)    
);

INSERT INTO paciente (nome, cpf, data_nascimento) VALUES
('João Silva', '12345678901', '1985-03-10'),
('Maria Oliveira', '23456789012', '1990-07-22'),
('Carlos Pereira', '34567890123', '1978-11-05'),
('Ana Souza', '45678901234', '2000-01-15'),
('Paulo Santos', '56789012345', '1995-06-30'),
('Juliana Lima', '67890123456', '1988-09-18'),
('Fernando Rocha', '78901234567', '1982-12-25'),
('Beatriz Mendes', '89012345678', '1993-04-08'),
('Ricardo Alves', '90123456789', '1997-08-12'),
('Larissa Costa', '01234567890', '2001-02-27');

INSERT INTO medico (nome, crm, especialidade) VALUES
('Dr. Pedro Martins', 'CRM12345SP', 'Cardiologia'),
('Dra. Helena Castro', 'CRM23456SP', 'Pediatria'),
('Dr. Lucas Ferreira', 'CRM34567SP', 'Ortopedia'),
('Dra. Renata Souza', 'CRM45678SP', 'Dermatologia'),
('Dr. André Lima', 'CRM56789SP', 'Neurologia'),
('Dra. Camila Torres', 'CRM67890SP', 'Ginecologia'),
('Dr. Marcelo Dias', 'CRM78901SP', 'Clínico Geral'),
('Dra. Fabiana Alves', 'CRM89012SP', 'Psiquiatria'),
('Dr. Rafael Mendes', 'CRM90123SP', 'Endocrinologia'),
('Dra. Patrícia Rocha', 'CRM01234SP', 'Reumatologia');

INSERT INTO atendimento (id_paciente, id_medico, dataatendimento, observacoes) VALUES
(1, 1, '2025-01-10', 'Paciente com pressão alta.'),
(2, 2, '2025-02-15', 'Consulta de rotina pediátrica.'),
(3, 3, '2025-03-05', 'Dor no joelho direito.'),
(4, 4, '2025-04-01', 'Alergia de pele.'),
(5, 5, '2025-01-22', 'Tontura frequente.'),
(6, 6, '2025-02-28', 'Consulta ginecológica anual.'),
(7, 7, '2025-03-18', 'Check-up geral.'),
(8, 8, '2025-04-05', 'Ansiedade e insônia.'),
(9, 9, '2025-05-10', 'Suspeita de diabetes.'),
(10, 10, '2025-05-14', 'Dores nas articulações.');

INSERT INTO exame (nomeexame) VALUES
('Hemograma completo'),
('Eletrocardiograma'),
('Raio-X de tórax'),
('Ultrassonografia abdominal'),
('Ressonância magnética'),
('Exame de glicemia'),
('Exame de urina'),
('Tomografia computadorizada'),
('Papanicolau'),
('Exame de colesterol');

INSERT INTO atendimento_exame (id_exame, id_atendimento, resultado) VALUES
(1, 1, 'Hemograma alterado, leucócitos elevados.'),
(2, 1, 'Eletro normal.'),
(3, 3, 'Fratura não detectada.'),
(4, 5, 'Órgãos abdominais normais.'),
(5, 5, 'Alterações cerebrais não encontradas.'),
(6, 9, 'Glicemia em 180 mg/dL.'),
(7, 7, 'Urina com sedimentos.'),
(8, 9, 'Tomografia normal.'),
(9, 6, 'Resultado normal.'),
(10, 10, 'Colesterol elevado.');

SELECT * FROM paciente;
SELECT * FROM medico;
SELECT * FROM atendimento;
SELECT * FROM paciente;

SELECT * FROM medico WHERE especialidade = 'Pediatria';

SELECT a.idatendimento, p.nome AS paciente, m.nome AS medico, a.dataatendimento
FROM atendimento a
JOIN paciente p ON a.id_paciente = p.idpaciente
JOIN medico m ON a.id_medico = m.idmedico;

SELECT id_medico , COUNT(*) AS 'Total Atendimento'
FROM atendimento
GROUP BY id_medico
HAVING COUNT(*) > 0;

SELECT nome FROM paciente
UNION
SELECT nome FROM medico; 