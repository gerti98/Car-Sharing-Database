
CALL Iscrizione_Utente('ntne', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397E');
CALL Iscrizione_Utente('ntnf', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397F');
CALL Iscrizione_Utente('ntng', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397G');
CALL Iscrizione_Utente('ntnh', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397H');
CALL Iscrizione_Utente('ntni', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397I');
CALL Iscrizione_Utente('ntnl', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397L');
CALL Iscrizione_Utente('ntnm', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397M');
CALL Iscrizione_Utente('ntnn', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397N');
CALL Iscrizione_Utente('ntno', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397O');
CALL Iscrizione_Utente('ntnp', '123456', 'Nome migliore amico', 'Antonio', 'NTNSVN27D12C397P');


CALL Registrazione_Autovettura('M001', 'AK', 'Renault', '2011', '400', '10', '10', '220', '15', '10000', '3', '30','2', '1', 'Benzina', '50', '300', 1, 1, 0, 'ntne');
CALL Registrazione_Autovettura('M002', 'AK', 'Renault', '2011', '400', '10', '10', '220', '15', '10000', '3', '30','2', '1', 'Benzina', '50', '300', 1, 1, 1, 'ntnf');

CALL registra_fruibilita('M001', '0', '11:00:00', '23:00:00');
CALL registra_fruibilita('M001', '1', '11:00:00', '23:00:00');
CALL registra_fruibilita('M001', '2', '11:00:00', '23:00:00');
CALL registra_fruibilita('M001', '3', '11:00:00', '23:00:00');
CALL registra_fruibilita('M001', '4', '11:00:00', '23:00:00');
CALL registra_fruibilita('M002', '0', '11:00:00', '23:00:00');
CALL registra_fruibilita('M002', '1', '11:00:00', '23:00:00');
CALL registra_fruibilita('M002', '6', '11:00:00', '23:00:00');
CALL registra_fruibilita('M002', '4', '11:00:00', '23:00:00');
CALL registra_fruibilita('M002', '5', '11:00:00', '23:00:00');


-- CALL prenotazione_noleggio('ntng', '0001', current_date(), '2018-07-31');



CALL Registra_Sinistro('ntng', '0001', 'E001', 'Ford', 'XK3', '23:59:59', '2018-07-12', 'Frontale', 1, '000001');

CALL Car_Pooling_Proponente('ntne', '2018-09-30', '08:00:00', NULL ,'alta', '2018-09-27 08:00:00', 1, 'M001', 'T1');

CALL Car_Pooling_Fruitore('ntne', '2018-09-30', '08:00:00', 'P001', 'ntng', 'V001', 18, 19, 'T03'); 

-- CALL accetta_prenotazione('ntne', '2018-09-30', '08:00:00', 'P001');


CALL recensione_fruitore('Car Pooling', 'V03', 'T2', 5, 'ntne', 'ntnf', 'Affidabile');
CALL recensione_proponente('Car Pooling', 'V04', 'T2', 1, 'ntne', 'ntnf', 'Non affidabile');

CALL open_ride_sharing('2018-09-12 12:00:00', 'ntnf', 'T2', 'M002');

CALL open_chiamata('CH001', 'ntne', 1, 1, '000001', '000002');
