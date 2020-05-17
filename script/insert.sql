
BEGIN;
INSERT INTO Utente
VALUES 
('NTNSVN27D12C397E', 'Silvano', 'Antinucci', 3774860825, '1927-04-10', 'M'),
('NTNSVN27D12C397F', 'Antonio', 'Candreva', 3774860826, '1937-04-12', 'M'),
('NTNSVN27D12C397G', 'Salvatore', 'Giacomelli', 3774860827, '1947-04-11', 'M'),
('NTNSVN27D12C397H', 'Marco', 'Carta', 3744860828, '1957-04-12', 'M'),
('NTNSVN27D12C397I', 'Lorenzo', 'De Silvestri', 3774860829, '1967-03-12', 'M'),
('NTNSVN27D12C397L', 'Mara', 'Antinucci', 3774860820, '1977-04-12', 'F'),
('NTNSVN27D12C397M', 'Sara', 'Libecci', 37374860556, '1987-04-12', 'F'),
('NTNSVN27D12C397N', 'Rossana', 'Esposito', 3774860825, '1997-04-12', 'F'),
('NTNSVN27D12C397O', 'Antonella', 'Rubicante', 3724860865, '1989-04-12', 'F'),
('NTNSVN27D12C397P', 'Alice', 'Nesi', 3774823535, '1990-05-12', 'F');
COMMIT;

BEGIN;
INSERT INTO Documento
VALUES 
('NTNSVN27D12C397E', 'Carta Identità', 'CA00000AA', '2018-08-20', 'Comune di Caversacico'),
('NTNSVN27D12C397F', 'Carta Identità', 'CA00000BB', '2020-08-02', 'Comune di Montemurlo'),
('NTNSVN27D12C397G', 'Carta Identità', 'CA00000CC', '2020-08-20', 'Comune di Prato'),
('NTNSVN27D12C397H', 'Passaporto', 'CA00000DD', '2021-08-20', 'Comune di Pistoia'),
('NTNSVN27D12C397I', 'Carta Identità', 'CA00000EE', '2022-08-21', 'Comune di Montale'),
('NTNSVN27D12C397L', 'Carta Identità', 'CA00000FF', '2019-07-20', 'Comune di Quarrata'),
('NTNSVN27D12C397M', 'Carta Identità', 'CA00000GG', '2018-08-20', 'Comune di Prato'),
('NTNSVN27D12C397N', 'Carta Identità', 'CA00000HH', '2020-08-20', 'Comune di Montemurlo'),
('NTNSVN27D12C397O', 'Carta Identità', 'CA00000II', '2019-09-20', 'Comune di Montale'),
('NTNSVN27D12C397P', 'Patente', 'CA00000LL', '2018-08-20', 'Comune di Pistoia');
COMMIT;

BEGIN;
INSERT INTO Indirizzo
VALUES 
('NTNSVN27D12C397E', 'Via due Palme', '50123', '2','Como'),
('NTNSVN27D12C397F', 'Via due Giugno', '59013', '4','Prato'),
('NTNSVN27D12C397G', 'Via Cesare Battisti', '59013', '5','Prato'),
('NTNSVN27D12C397H', 'Via Ignazio Vian', '59013', '23','Pistoia'),
('NTNSVN27D12C397I', 'Via Marsala', '59013', '24','Pistoia'),
('NTNSVN27D12C397L', 'Via Quarto dei Mille', '59013', '2','Prato'),
('NTNSVN27D12C397M', 'Via Oste', '59013', '21','Prato'),
('NTNSVN27D12C397N', 'Viale Palarciano', '59013', '232','Prato'),
('NTNSVN27D12C397O', 'Via Aleramo', '59013', '20','Prato'),
('NTNSVN27D12C397P', 'Via Toti', '59013', '12','Prato');
COMMIT;

BEGIN;
INSERT INTO Tratto
VALUES 
(1, '000001', 100, 100.1, 80, NULL),
(2, '000001', 100, 100.2, 80, NULL),
(3,'000001', 100, 100.3, 80, NULL),
(4, '000001', 100, 100.4, 80, NULL),
(5, '000001', 100, 100.5, 80, NULL),
(6, '000001', 100, 100.6, 80, NULL),
(7, '000001', 100, 100.7, 80, NULL),
(8, '000001', 100, 100.8, 80, NULL),
(9, '000001', 100, 100.9, 80, NULL),
(10, '000001', 100, 101, 80, NULL),
(11, '000001', 100, 101.1, 80, NULL),
(12, '000001', 100, 101.2, 80, NULL),
(13, '000001', 100, 101.3, 80, NULL),
(14, '000001', 100, 101.4, 80, NULL),
(15, '000001', 100, 101.5, 80, NULL),
(1, '000002', 100.1, 100, 80, NULL),
(2, '000002', 100.2, 100, 80, NULL),
(3, '000002', 100.3, 100, 80, NULL),
(4, '000002', 100.4, 100, 80, NULL),
(5, '000002', 100.5, 100, 80, NULL),
(6, '000002', 100.6, 100, 80, NULL),
(7, '000002', 100.7, 100, 80, NULL),
(8, '000002', 100.8, 100, 80, NULL),
(9, '000002', 100.9, 100, 80, NULL),
(10, '000002', 101, 100, 80, NULL),
(11, '000002', 101.1, 100, 80, NULL),
(12, '000002', 101.2, 100, 80, NULL),
(13, '000002', 101.3, 100, 80, NULL),
(14, '000002', 101.4, 100, 80, NULL),
(15, '000002', 101.5, 100, 80, NULL),
(16, '000002', 101.6, 100, 80, NULL),
(17, '000002', 101.7, 100, 80, NULL),
(1, '000003', 90, 100, 130, 0.2),
(2, '000003', 90.1, 100, 130, 0.2),
(3, '000003', 90.2, 100, 130, 0.2),
(4, '000003', 90.3, 100, 130, 0.2),
(5, '000003', 90.4, 100, 130, 0.2),
(6, '000003', 90.5, 100, 130, 0.3),
(7, '000003', 90.6, 100, 130, 0.3),
(8, '000003', 90.7, 100, 130, 0.3),
(9, '000003', 90.8, 100, 130, 0.3),
(10, '000003', 90.9, 100, 130, 0.3),
(11, '000003', 91, 100, 130, 0.3),
(12, '000003', 91.1, 100, 130, 0.3),
(13, '000003', 91.2, 100, 130, 0.3),
(14, '000003', 91.3, 100, 130, 0.3),
(15, '000003', 91.4, 100, 130, 0.3),
(16, '000003', 91.5, 100, 130, 0.3),
(17, '000003', 91.6, 100, 130, 0.3),
(18, '000003', 91.7, 100, 130, 0.2),
(19, '000003', 91.8, 100, 130, 0.2),
(20, '000003', 91.9, 100, 130, 0.1),
(21, '000003', 92, 100, 130, 0.1),
(22, '000003', 92.1, 100, 130, 0.2),
(23, '000003', 92.2, 100, 130, 0.2),
(24, '000003', 92.3, 100, 130, 0.2),
(25, '000003', 92.4, 100, 130, 0.2),
(26, '000003', 92.5, 100, 130, 0.3),
(27, '000003', 92.6, 100, 130, 0.3),
(28, '000003', 92.7, 100, 130, 0.2),
(29, '000003', 92.8, 100, 130, 0.2),
(30, '000003', 92.9, 100, 130, 0.2),
(31, '000003', 93, 100, 130, 0.2),
(32, '000003', 93.1, 100, 130, 0.2),
(33, '000003', 93.2, 100, 130, 0.2),
(34, '000003', 93.3, 100, 130, 0.2),
(35, '000003', 93.4, 100, 130, 0.2),
(36, '000003', 93.5, 100, 130, 0.2),
(37, '000003', 93.6, 100, 130, 0.2),
(38, '000003', 93.7, 100, 130, 0.2),
(39, '000003', 93.8, 100, 130, 0.2),
(40, '000003', 93.9, 100, 130, 0.2),
(41, '000003', 94, 100, 130, 0.2),
(42, '000003', 94.1, 100, 130, 0.2),
(43, '000003', 94.1, 100.1, 130, 0.2),
(44, '000003', 94.2, 100.1, 130, 0.2),
(45, '000003', 94.3, 100.1, 130, 0.2),
(46, '000003', 94.4, 100.1, 130, 0.3),
(47, '000003', 94.5, 100.1, 130, 0.3),
(48, '000003', 94.6, 100, 130, 0.3),
(49, '000003', 94.7, 100, 130, 0.3),
(50, '000003', 94.8, 100, 130, 0.3),
(51, '000003', 94.9, 100, 130, 0.3),
(52, '000003', 95, 100, 120, 0.3),
(53, '000003', 95.1, 100, 120, 0.3),
(54, '000003', 95.2, 100, 120, 0.2),
(55, '000003', 95.3, 100, 120, 0.2),
(56, '000003', 95.4, 100, 120, 0.2),
(57, '000003', 95.5, 100, 120, 0.2),
(58, '000003', 95.6, 100, 120, 0.2),
(59, '000003', 95.7, 100, 120, 0.1),
(60, '000003', 95.8, 100, 120, 0.1),
(1, '000004', 80.1, 100, 130, 0.1),
(2, '000004', 80.2, 100, 130, 0.1),
(3, '000004', 80.3, 100, 130, 0.2),
(4, '000004', 80.4, 100, 130, 0.1),
(5, '000004', 80.5, 100, 130, 0.1),
(6, '000004', 80.6, 100, 130, 0.1),
(7, '000004', 80.7, 100, 130, 0.1),
(8, '000004', 80.8, 100, 130, 0.1),
(9, '000004', 80.9, 100, 130, 0.1),
(10, '000004', 81, 100, 130, 0.1),
(11, '000004', 81.1, 100, 130, 0.1),
(12, '000004', 81.2, 100, 130, 0.1),
(13, '000004', 81.3, 100, 130, 0.1),
(14, '000004', 81.4, 100, 130, 0.2),
(15, '000004', 81.5, 100, 130, 0.2),
(16, '000004', 81.6, 100, 130, 0.2),
(17, '000004', 81.7, 100, 130, 0.1),
(18, '000004', 81.8, 100, 130, 0.1),
(19, '000004', 81.9, 100, 130, 0.1),
(20, '000004', 82, 100, 110, 0.1),
(21, '000004', 82.1, 100, 110, 0.1),
(22, '000004', 82.2, 100, 110, 0.1),
(23, '000004', 82.3, 100, 130, 0.1),
(24, '000004', 82.4, 100, 130, 0.2),
(25, '000004', 82.5, 100, 130, 0.2),
(26, '000004', 82.6, 100, 130, 0.1),
(27, '000004', 82.7, 100, 130, 0.1),
(28, '000004', 82.8, 100, 130, 0.1),
(29, '000004', 82.9, 100, 130, 0.1),
(30, '000004', 83, 100, 130, 0.1),
(1, '000005', 60.1, 100, 70, NULL),
(2, '000005', 60.2, 100, 70, NULL),
(3, '000005', 60.3, 100, 70, NULL),
(4, '000005', 60.4, 100, 70, NULL),
(5, '000005', 60.5, 100, 70, NULL),
(6, '000005', 60.6, 100, 70, NULL),
(7, '000005', 60.7, 100, 70, NULL),
(8, '000005', 60.8, 100, 70, NULL),
(9, '000005', 60.9, 100, 70, NULL),
(10, '000005', 61, 100, 70, NULL),
(1, '000006', 50, 100, 70, NULL),
(2, '000006', 50.1, 100, 70, NULL),
(3, '000006', 50.2, 100, 70, NULL),
(4, '000006', 50.3, 100, 70, NULL),
(5, '000006', 50.4, 100, 70, NULL),
(6, '000006', 50.5, 100, 70, NULL),
(7, '000006', 50.6, 100, 70, NULL),
(8, '000006', 50.7, 100, 70, NULL),
(9, '000006', 50.8, 100, 70, NULL),
(10,'000006', 50.9, 100, 70, NULL),
(1, '000007', 40.1, 100, 80, NULL),
(2, '000007', 40.2, 100, 80, NULL),
(3, '000007', 40.3, 100, 80, NULL),
(4, '000007', 40.4, 100, 80, NULL),
(5, '000007', 40.5, 100, 80, NULL),
(6, '000007', 40.6, 100, 80, NULL),
(7, '000007', 40.7, 100, 80, NULL),
(8, '000007', 40.8, 100, 80, NULL),
(9, '000007', 40.9, 100, 80, NULL),
(10,'000007', 41, 100, 80, NULL),
(1, '000008', 30.1, 100, 80, NULL),
(2, '000008', 30.2, 100, 80, NULL),
(3, '000008', 30.3, 100, 80, NULL),
(4, '000008', 30.4, 100, 80, NULL),
(5, '000008', 30.5, 100, 80, NULL),
(6, '000008', 30.6, 100, 80, NULL),
(7, '000008', 30.7, 100, 80, NULL),
(8, '000008', 30.8, 100, 80, NULL),
(9, '000008', 30.9, 100, 80, NULL),
(10,'000008', 31, 100, 80, NULL),
(1, 'Via Due Giugno', 20.1, 100, 50, NULL),
(2, 'Via Due Giugno', 20.2, 100, 50, NULL),
(3, 'Via Due Giugno', 20.3, 100, 50, NULL),
(4, 'Via Due Giugno', 20.4, 100, 50, NULL),
(5, 'Via Due Giugno', 20.5, 100, 50, NULL),
(1, 'Via Cesare Battisti', 10.1, 100, 50, NULL),
(2, 'Via Cesare Battisti', 10.2, 100, 50, NULL),
(3, 'Via Cesare Battisti', 10.3, 100, 50, NULL),
(4, 'Via Cesare Battisti', 10.4, 100, 50, NULL),
(5, 'Via Cesare Battisti', 10.5, 100, 50, NULL),
(1, 'Via Oste', 10, 90.1, 50, NULL),
(2, 'Via Oste', 10, 90.2, 50, NULL),
(3, 'Via Oste', 10, 90.3, 50, NULL),
(4, 'Via Oste', 10, 90.4, 50, NULL),
(1, 'Via Palarciano', 5.1, 100, 50, NULL),
(2, 'Via Palarciano', 5.2, 100, 50, NULL),
(3, 'Via Palarciano', 5.3, 100, 50, NULL);
COMMIT;

BEGIN;
INSERT INTO Strada
VALUES 
('000001', NULL, 'SS', 'dir', NULL, 'Extraurbana Principale', 15),
('000002', NULL, 'SS', 'quater', NULL, 'Extraurbana Secondaria', 17),
('000003', 'Autostrada del Sole', 'SS', 'radd', 'A1', 'Autostrada', 60),
('000004', NULL, 'SS', 'dir', 'A2', 'Autostrada', 30),
('000005', NULL, 'SP', 'dir', NULL, 'Extraurbana Principale', 10),
('000006', NULL, 'SP', 'dir', NULL, 'Extraurbana Secondaria', 10),
('000007', NULL, 'SR', 'dir', NULL, 'Extraurbana Secondaria', 10),
('000008', NULL, 'SR', 'dir', NULL, 'Extraurbana Secondaria', 10),
('Via Due Giugno (PO)', NULL, 'SC', NULL, NULL, 'Urbana', 5),
('Via Cesare Battisti (PO)', NULL, 'SC', NULL, NULL, 'Urbana', 5),
('Via Oste (PO)', NULL, 'SC', NULL, NULL, 'Urbana', 4),
('Via Palarciano (PO)', NULL, 'SC', NULL, NULL, 'Urbana', 3);
COMMIT;

BEGIN;
INSERT INTO Composizione_strada
VALUES 
('000001', 2, 2, 2, NULL),
('000002', 2, 2, 2, NULL),
('000003', 2, 2, 3, NULL),
('000004', 2, 2, 3, NULL),
('000005', 2, 2, 2, NULL),
('000006', 2, 2, 2, NULL),
('000007', 2, 2, 2, NULL),
('000008', 2, 2, 2, NULL),
('Via Due Giugno (PO)', 1, 1, 1, 'crescente'),
('Via Cesare Battisti (PO)', 1, 1, 1, 'decrescente'),
('Via Oste (PO)', 2, 1, 2, NULL),
('Viale Palarciano (PO)', 2, 1, 2, NULL);
COMMIT;


BEGIN;
INSERT INTO Proponente
VALUES('ntne', NULL),
('ntnf', NULL);
COMMIT;

BEGIN;
INSERT INTO Fruitore
VALUES('ntne', NULL),
('ntng', NULL),
('ntnh', NULL);
COMMIT;

BEGIN;
INSERT INTO Valutazione
VALUES('V01', 5, 'Car Pooling', 'Affidabile', 'proponente', 'ntne', 'ntng'),
('V02', 5, 'Car Pooling', 'Affidabile', 'fruitore', 'ntne', 'ntng');
COMMIT;


BEGIN;
INSERT INTO luogo_servizio
VALUES('V01', 'T1'),
('V02', 'T1');
COMMIT;

BEGIN;
INSERT INTO Congiunzione
VALUES(5, '000003', 5, '000001'),
(15, '000003', 5, '000002'),
(25, '000003', 5, '000004'),
(35, '000003', 5, '000005'),
(45, '000003', 5, '000006'),
(55, '000003', 5, '000007'),
(15, '000004', 5, '000008'),
(7, '000001', 7, '000007'),
(2, '000005', 7, '000002'),
(6, '000005', 36, '000003'),
(1, '000005', 1, 'Via Palarciano (PO)'),
(3, 'Via Palarciano (PO)', 1, 'Via Oste (PO)'),
(4, 'Via Oste (PO)', 2, 'Via Cesare Battisti (PO)'),
(2, 'Via Due Giugno (PO)', 5, 'Via Cesare Battisti (PO)');
COMMIT;

BEGIN;
INSERT INTO tipologia_congiunzione
VALUES('000003', '000001', 'congiunzione'),
('000003', '000002', 'congiunzione'),
('000003', '000004', 'congiunzione'),
('000003', '000005', 'congiunzione'),
('000005', '000003', 'congiunzione'),
('000003', '000006', 'congiunzione'),
('000003', '000007', 'congiunzione'),
('000004', '000008', 'congiunzione'),
('000001', '000007', 'congiunzione'),
('000005', '000002', 'congiunzione'),
('000005', 'Via Palarciano (PO)', 'congiunzione'),
('Via Palarciano (PO)', 'Via Oste (PO)', 'congiunzione'),
('Via Oste (PO)', 'Via Cesare Battisti (PO)', 'congiunzione'),
('Via Due Giugno (PO)', 'Via Cesare Battisti (PO)', 'crescente');
COMMIT;

/*
('Via Due Giugno (PO)', 1, 1, 1, 'crescente'),
('Via Cesare Battisti (PO)', 1, 1, 1, 'decrescente'),
('Via Oste (PO)', 2, 1, 2, NULL),
('Viale Palarciano (PO)', 2, 1, 2, NULL);
COMMIT;
*/

BEGIN;
INSERT INTO tragitto
VALUES('T1', 1, 1, 'Via Due Giugno (PO)', 2, 'Via Cesare Battisti  (PO)'),
('T1', 3, 5, 'Via Cesare Battisti (PO)', 2, 'Via Oste (PO)'),
('T1', 7, 4, 'Via Oste (PO)', 1, 'Via Palarciano (PO)'),
('T1', 10, 3, 'Via Palarciano (PO)', 1, NULL),
('T2', 1, 1, 'Via Due Giugno (PO)', 2, 'Via Cesare Battisti  (PO)'),
('T2', 3, 5, 'Via Cesare Battisti (PO)', 2, 'Via Oste (PO)'),
('T2', 7, 4, 'Via Oste (PO)', 1, 'Via Palarciano (PO)'),
('T2', 10, 3, 'Via Palarciano (PO)', 1, '000005'),
('T2', 12, 1, '000005', 5, '000003'),
('T2', 16, 35, '000003', 5, '000001'),
('T2', 46, 5, '000001', 7, '000007'),
('T2', 48, 7, '000007', 5, '000003'),
('T2', 50, 55, '000003', 21, NULL),
('T3', 1, 5, '000005', 6, '000003'),
('T3', 3, 36, '000003', 35, NULL),
('T4', 1, 1, 'Via Due Giugno (PO)', 2, 'Via Cesare Battisti  (PO)'),
('T4', 3, 5, 'Via Cesare Battisti (PO)', 2, 'Via Oste (PO)'),
('T4', 7, 4, 'Via Oste (PO)', 1, 'Via Palarciano (PO)'),
('T4', 11, 3, 'Via Palarciano (PO)', 1, '000005'),
('T4', 14, 1, '000005', 5, '000003'),
('T4', 19, 35, '000003', 5, '000001'),
('T4', 50, 5, '000001', 7, '000007'),
('T4', 53, 7, '000007', 5, '000003'),
('T4', 56, 55, '000003', 21, NULL);
COMMIT;


BEGIN;
INSERT INTO tracking
VALUES(1, 1, 'Via Due Giugno (PO)','M001','2018-04-03 00:00:00','T1'),
(1, 1, 'Via Due Giugno (PO)','M001','2018-04-03 00:01:00','T1'),
(1, 1, 'Via Due Giugno (PO)','M001','2018-04-03 00:02:00','T1'),
(2, 1, 'Via Due Giugno (PO)','M001','2018-04-03 00:03:00','T1'),
(5, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:04:00','T1'),
(5, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:05:00','T1'),
(5, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:06:00','T1'),
(5, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:07:00','T1'),
(4, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:08:00','T1'),
(4, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:09:00','T1'),
(4, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:10:00','T1'),
(3, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:11:00','T1'),
(3, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:12:00','T1'),
(3, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:13:00','T1'),
(2, 2, 'Via Cesare Battisti (PO)','M001','2018-04-03 00:14:00','T1'),
(4, 5, 'Via Oste (PO)','M001','2018-04-03 00:15:00','T1'),
(4, 5, 'Via Oste (PO)','M001','2018-04-03 00:16:00','T1'),
(4, 5, 'Via Oste (PO)','M001','2018-04-03 00:17:00','T1'),
(3, 5, 'Via Oste (PO)','M001','2018-04-03 00:18:00','T1'),
(3, 5, 'Via Oste (PO)','M001','2018-04-03 00:19:00','T1'),
(3, 5, 'Via Oste (PO)','M001','2018-04-03 00:20:00','T1'),
(2, 5, 'Via Oste (PO)','M001','2018-04-03 00:21:00','T1'),
(2, 5, 'Via Oste (PO)','M001','2018-04-03 00:22:00','T1'),
(1, 5, 'Via Oste (PO)','M001','2018-04-03 00:23:00','T1'),
(3, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:24:00','T1'),
(3, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:25:00','T1'),
(3, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:26:00','T1'),
(2, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:27:00','T1'),
(2, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:28:00','T1'),
(2, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:29:00','T1'),
(1, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:30:00','T1'),
(1, 1, 'Via Due Giugno (PO)','M002','2018-04-03 00:00:00','T2'),
(1, 1, 'Via Due Giugno (PO)','M002','2018-04-03 00:01:00','T2'),
(1, 1, 'Via Due Giugno (PO)','M002','2018-04-03 00:02:00','T2'),
(2, 1, 'Via Due Giugno (PO)','M002','2018-04-03 00:03:00','T2'),
(5, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:04:00','T2'),
(5, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:05:00','T2'),
(5, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:06:00','T2'),
(5, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:07:00','T2'),
(4, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:08:00','T2'),
(4, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:09:00','T2'),
(4, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:10:00','T2'),
(3, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:11:00','T2'),
(3, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:12:00','T2'),
(3, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:13:00','T2'),
(2, 2, 'Via Cesare Battisti (PO)','M002','2018-04-03 00:14:00','T2'),
(4, 5, 'Via Oste (PO)','M002','2018-04-03 00:15:00','T2'),
(4, 5, 'Via Oste (PO)','M002','2018-04-03 00:16:00','T2'),
(4, 5, 'Via Oste (PO)','M002','2018-04-03 00:17:00','T2'),
(3, 5, 'Via Oste (PO)','M002','2018-04-03 00:18:00','T2'),
(3, 5, 'Via Oste (PO)','M002','2018-04-03 00:19:00','T2'),
(3, 5, 'Via Oste (PO)','M002','2018-04-03 00:20:00','T2'),
(2, 5, 'Via Oste (PO)','M002','2018-04-03 00:21:00','T2'),
(2, 5, 'Via Oste (PO)','M002','2018-04-03 00:22:00','T2'),
(1, 5, 'Via Oste (PO)','M002','2018-04-03 00:23:00','T2'),
(3, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:24:00','T2'),
(3, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:25:00','T2'),
(3, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:26:00','T2'),
(2, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:27:00','T2'),
(2, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:28:00','T2'),
(2, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:29:00','T2'),
(1, 8, 'Via Palarciano (PO)','M002','2018-04-03 00:30:00','T2'),
(1, 10, '000005','M002','2018-04-03 00:31:00','T2'),
(1, 10, '000005','M002','2018-04-03 00:32:00','T2'),
(2, 10, '000005','M002','2018-04-03 00:33:00','T2'),
(3, 10, '000005','M002','2018-04-03 00:34:00','T2'),
(4,  10, '000005','M002','2018-04-03 00:35:00','T2'),
(5, 10, '000005','M002','2018-04-03 00:36:00','T2'),
(5, 10, '000005','M002','2018-04-03 00:37:00','T2'),
(35, 14, '000003','M002','2018-04-03 00:38:00','T2'),
(34, 14, '000003','M002','2018-04-03 00:39:00','T2'),
(33, 14,'000003','M002','2018-04-03 00:40:00','T2'),
(32, 14, '000003','M002','2018-04-03 00:41:00','T2'),
(31, 14, '000003','M002','2018-04-03 00:42:00','T2'),
(29, 14, '000003','M002','2018-04-03 00:43:00','T2'),
(27, 14, '000003','M002','2018-04-03 00:44:00','T2'),
(26, 14, '000003','M002','2018-04-03 00:45:00','T2'),
(24, 14, '000003','M002','2018-04-03 00:46:00','T2'),
(23, 14, '000003','M002','2018-04-03 00:47:00','T2'),
(22, 14, '000003','M002','2018-04-03 00:48:00','T2'),
(21, 14, '000003','M002','2018-04-03 00:49:00','T2'),
(19, 14, '000003','M002','2018-04-03 00:50:00','T2'),
(18, 14, '000003','M002','2018-04-03 00:51:00','T2'),
(17, 14, '000003','M002','2018-04-03 00:52:00','T2'),
(15, 14, '000003','M002','2018-04-03 00:53:00','T2'),
(14, 14, '000003','M002','2018-04-03 00:54:00','T2'),
(13, 14, '000003','M002','2018-04-03 00:55:00','T2'),
(11, 14, '000003','M002','2018-04-03 00:56:00','T2'),
(10, 14, '000003','M002','2018-04-03 00:57:00','T2'),
(9, 14, '000003','M002','2018-04-03 00:58:00','T2'),
(7, 14, '000003','M002','2018-04-03 00:59:00','T2'),
(6, 14, '000003','M002','2018-04-03 01:00:00','T2'),
(5, 14, '000003','M002','2018-04-03 01:01:00','T2'),
(5, 44, '000001','M002','2018-04-03 01:02:00','T2'),
(6, 44, '000001','M002','2018-04-03 01:03:00','T2'),
(7, 44, '000001','M002','2018-04-03 01:04:00','T2'),
(7, 46, '000007','M002','2018-04-03 01:05:00','T2'),
(6, 46, '000007','M002','2018-04-03 01:06:00','T2'),
(5, 46, '000007','M002','2018-04-03 01:07:00','T2'),
(55, 48, '000003','M002','2018-04-03 01:08:00','T2'),
(54, 48, '000003','M002','2018-04-03 01:09:00','T2'),
(53, 48, '000003','M002','2018-04-03 01:10:00','T2'),
(52, 48, '000003','M002','2018-04-03 01:11:00','T2'),
(50, 48, '000003','M002','2018-04-03 01:12:00','T2'),
(49, 48, '000003','M002','2018-04-03 01:13:00','T2'),
(48, 48, '000003','M002','2018-04-03 01:14:00','T2'),
(47, 48, '000003','M002','2018-04-03 01:15:00','T2'),
(45, 48, '000003','M002','2018-04-03 01:16:00','T2'),
(44, 48, '000003','M002','2018-04-03 01:17:00','T2'),
(43, 48, '000003','M002','2018-04-03 01:18:00','T2'),
(42, 48, '000003','M002','2018-04-03 01:19:00','T2'),
(40, 48, '000003','M002','2018-04-03 01:20:00','T2'),
(39, 48, '000003','M002','2018-04-03 01:21:00','T2'),
(38, 48, '000003','M002','2018-04-03 01:22:00','T2'),
(37, 48, '000003','M002','2018-04-03 01:23:00','T2'),
(35, 48, '000003','M002','2018-04-03 01:24:00','T2'),
(34, 48, '000003','M002','2018-04-03 01:25:00','T2'),
(33, 48, '000003','M002','2018-04-03 01:26:00','T2'),
(31, 48, '000003','M002','2018-04-03 01:27:00','T2'),
(30, 48, '000003','M002','2018-04-03 01:28:00','T2'),
(29, 48, '000003','M002','2018-04-03 01:29:00','T2'),
(28, 48, '000003','M002','2018-04-03 01:30:00','T2'),
(26, 48, '000003','M002','2018-04-03 01:31:00','T2'),
(25, 48, '000003','M002','2018-04-03 01:32:00','T2'),
(24, 48, '000003','M002','2018-04-03 01:33:00','T2'),
(23, 48, '000003','M002','2018-04-03 01:34:00','T2'),
(21, 48, '000003','M002','2018-04-03 01:35:00','T2');
COMMIT;