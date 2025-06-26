use db_ecommerce;

INSERT INTO categoria (id, nome)
VALUES (7, "Alimentari");

INSERT INTO categoria (id, nome) VALUES
(8, "Sport e Tempo Libero"),
(9, "Salute e Bellezza"),
(10, "Giocattoli"),
(11, "Auto e Moto"),
(12, "Informatica"),
(13, "Libri"),
(14, "Musica e Film"),
(15, "Gioielli e Orologi"),
(16, "Telefonia e Accessori"),
(17, "Animali"),
(18, "Giardinaggio"),
(19, "Bricolage e Fai da te"),
(20, "Strumenti Musicali"),
(21, "Videogiochi");

use db_ecommerce;

INSERT INTO marca (id, nome)
VALUES (7, "Nokia");

INSERT INTO marca (id, nome) VALUES
(8, "Sony"),              -- Elettronica, Musica, Videogiochi
(9, "Microsoft"),         -- Informatica, Videogiochi, Software
(10, "Nike"),             -- Abbigliamento, Sport e Tempo Libero
(11, "HP"),               -- Informatica, Stampanti
(12, "Canon"),            -- Fotografia, Elettronica
(13, "Lego"),             -- Giocattoli
(14, "Bosch"),            -- Bricolage e Fai da Te, Elettrodomestici
(15, "Philips"),          -- Elettronica, Salute e Bellezza
(16, "Panasonic"),        -- Elettronica
(17, "Nestlé"),           -- Food, Alimentari
(18, "Barilla"),          -- Food
(19, "Amazon Basics"),    -- Casa, Informatica, Elettronica
(20, "Zara"),             -- Abbigliamento
(21, "L'Oréal"),          -- Salute e Bellezza
(22, "PlayStation"),      -- Videogiochi
(23, "Nintendo"),         -- Videogiochi
(24, "Breil"),            -- Gioielli e Orologi
(25, "Garmin"),           -- Sport e Tempo Libero, Auto e Moto
(26, "Thrustmaster"),     -- Gaming, Auto e Moto
(27, "PetSafe"),          -- Animali
(28, "Black+Decker"),     -- Fai da te, Giardinaggio
(29, "Mondadori"),        -- Libri
(30, "Sony Music");       -- Musica e Fi

INSERT INTO prodotto (nome, descrizione, marca_id, categoria_id, prezzo, quantita, data_produzione) VALUES
-- Elettronica (id categoria 1)
('Sony WH-1000XM4', 'Cuffie wireless con cancellazione del rumore', 8, 1, 299.99, 50, '2024-11-15'),
-- Informatica (categoria 12)
('Microsoft Surface Laptop 5', 'Ultrabook touchscreen leggero con Windows 11', 9, 12, 1249.00, 20, '2025-03-10'),
-- Sport e Tempo Libero (categoria 8)
('Nike Air Zoom Pegasus', 'Scarpe da running versatili per allenamenti quotidiani', 10, 8, 129.99, 35, '2025-01-22'),
-- Giocattoli (categoria 10)
('LEGO Star Wars X-Wing', 'Set da costruzione per bambini 9+ anni', 13, 10, 89.90, 60, '2024-12-05'),
-- Fai da Te (categoria 18)
('Trapano Avvitatore Bosch PSR 18', 'Trapano a batteria per lavori domestici', 14, 18, 89.99, 25, '2023-09-30'),
-- Salute e Bellezza (categoria 9)
('Spazzolino Elettrico Philips Sonicare', 'Tecnologia sonica per una pulizia profonda', 15, 9, 59.99, 100, '2024-10-12'),
-- Alimentari (categoria 7)
('Barilla Pasta Penne Rigate 500g', 'Pasta di semola di grano duro', 18, 7, 1.19, 500, '2025-05-01'),
-- Gioielli e Orologi (categoria 14)
('Orologio Breil Tribe Uomo', 'Orologio cronografo in acciaio', 24, 14, 129.00, 15, '2024-06-25'),
-- Auto e Moto (categoria 11)
('Garmin Dash Cam 57', 'Videocamera per auto compatta con controllo vocale', 25, 11, 179.99, 12, '2025-02-01'),
-- Animali (categoria 16)
('Fontanella per Gatti PetSafe', 'Dispenser d’acqua automatico 1.5L', 27, 16, 32.99, 40, '2025-04-20'),
-- Libri (categoria 13)
('Il Nome della Rosa', 'Romanzo storico di Umberto Eco, ed. Mondadori', 29, 13, 14.90, 100, '2024-09-10'),
-- Musica e Film (categoria 14)
('Vinile - Thriller di Michael Jackson', 'Ristampa in vinile dell’album leggendario', 30, 14, 25.00, 80, '2024-08-01'),
-- Videogiochi (categoria 20)
('The Legend of Zelda: Tears of the Kingdom', 'Gioco per Nintendo Switch', 23, 20, 69.99, 40, '2023-05-12');




INSERT INTO Ordini (data_ordine, prezzo_totale)
VALUES 
('2025-06-19', 47.98),
('2025-06-18', 149.90),
('2025-06-17', 87.00),
('2025-06-16', 29.99),
('2025-06-15', 0.00);



INSERT INTO ordine_prodotto (ordine_id, prodotto_id) VALUES
(1, 1),
(1, 2);


INSERT INTO ordine_prodotto (ordine_id, prodotto_id) VALUES
(2, 2),
(2, 8),
(2, 6);


INSERT INTO ordine_prodotto (ordine_id, prodotto_id) VALUES
(3, 9),
(3, 10);

INSERT INTO ordine_prodotto (ordine_id, prodotto_id) VALUES
(4, 4);









INSERT INTO marca (id, nome) VALUES
(8, 'Sony'),              -- Elettronica
(9, 'Xiaomi'),            -- Elettronica
(10, 'HP'),               -- Elettronica (notebook, stampanti)
(11, 'Zara'),             -- Moda
(12, 'Nike'),             -- Moda / Accessori
(13, 'Adidas'),           -- Moda / Accessori
(14, 'Fossil'),           -- Accessori (orologi, borse)
(15, 'Garmin'),           -- Elettronica / Accessori sportivi
(16, 'Fitbit'),           -- Health / wearables
(17, 'Suunto'),           -- Health / Sport tech
(18, 'Swisse'),           -- Health (integratori)
(19, 'BioTechUSA'),       -- Health / sport
(20, 'L’Oréal'),          -- Cura della persona
(21, 'Nivea'),            -- Cura della persona
(22, 'Gillette');   


INSERT INTO prodotto (nome, descrizione, marca_id, categoria_id, prezzo, quantita, data_produzione) VALUES
('Red Bull Energy Drink 250ml', 'Bevanda energetica per sportivi e studenti', 4, 4, 1.50, 120, '2024-04-10'),
('Sony WH-1000XM5 Headphones', 'Cuffie wireless con cancellazione del rumore avanzata', 8, 1, 349.99, 15, '2024-03-01'),
('Xiaomi Mi Band 8', 'Smartband con monitoraggio attivita e sonno', 9, 1, 49.99, 40, '2024-05-20'),
('HP Envy x360 Laptop', 'Notebook convertibile con touchscreen e AMD Ryzen', 10, 1, 899.00, 10, '2024-01-05'),
('Nokia G21 Smartphone', 'Smartphone economico con batteria a lunga durata', 8, 1, 179.99, 25, '2024-04-18'),  -- cambio marca_id da 7 a 8 (Sony)
('Garmin Forerunner 255', 'Smartwatch sportivo con GPS avanzato', 15, 1, 299.99, 20, '2024-03-30'),
('Fitbit Charge 6', 'Fitness tracker con sensori salute integrati', 16, 1, 149.99, 30, '2024-05-01'),
('Suunto 9 Peak Pro', 'Orologio multisport resistente e preciso', 17, 1, 499.99, 12, '2024-02-22'),
('Sony PlayStation 5', 'Console di nuova generazione per gaming immersivo', 8, 1, 549.00, 7, '2024-01-15'),
('HP Monitor 27 Full HD', 'Monitor con risoluzione 1080p e pannello IPS', 10, 1, 179.90, 18, '2024-02-10'),
('Xiaomi Robot Vacuum S10', 'Aspirapolvere intelligente con mappatura laser', 9, 1, 229.90, 14, '2024-03-08'),
('Zara Giacca Uomo', 'Giacca elegante in tessuto tecnico', 11, 2, 89.90, 25, '2024-03-12'),
('Nike Air Max 270', 'Sneaker iconiche con ammortizzazione Air', 12, 2, 139.99, 20, '2024-04-05'),
('Adidas Hoodie Essentials', 'Felpa comoda con logo frontale', 3, 2, 59.99, 30, '2024-03-22'),
('Zara Pantaloni Cargo Donna', 'Pantaloni versatili con tasche multiple', 11, 2, 49.90, 18, '2024-05-15'),
('Fossil Borsa Messenger Uomo', 'Borsa in pelle per uso quotidiano o lavoro', 14, 3, 129.00, 10, '2024-02-01'),
('Garmin Vivomove Trend', 'Orologio ibrido elegante con funzionalita smart', 15, 3, 299.00, 8, '2024-04-22'),
('Fossil Orologio Smartwatch Gen 6', 'Smartwatch con Wear OS e funzioni fitness', 14, 3, 269.00, 9, '2024-03-28'),
('Adidas Zaino Classic', 'Zaino sportivo ideale per scuola o tempo libero', 3, 3, 39.99, 22, '2024-04-11'),
('Nike Cappello Pro Dri-FIT', 'Cappellino traspirante per allenamento', 12, 3, 24.99, 50, '2024-05-04'),
('Swisse Multivitaminico Uomo', 'Integratore completo per il benessere maschile', 18, 4, 14.90, 60, '2024-02-18'),
('Swisse Magnesio e Potassio', 'Supporto per muscoli e sistema nervoso', 18, 4, 12.50, 75, '2024-03-20'),
('BioTechUSA Iso Whey Zero 908g', 'Proteine isolate senza zuccheri aggiunti', 19, 4, 29.90, 40, '2024-04-02'),
('BioTechUSA BCAA 8-1-1', 'Aminoacidi ramificati per recupero muscolare', 19, 4, 24.50, 35, '2024-03-25'),
('Nivea Crema Soft 300ml', 'Crema idratante per viso corpo e mani', 21, 5, 3.99, 100, '2024-05-05'),
('Gillette Fusion5 Rasoio', 'Rasoio manuale con 5 lame e testina flessibile', 22, 5, 11.99, 60, '2024-03-30'),
('LOreal Shampoo Elvive Dream Long', 'Shampoo nutriente per capelli lunghi', 20, 5, 4.50, 80, '2024-04-14'),
('Nivea Deo Roll-on Black and White', 'Deodorante antialoni con protezione 48h', 21, 5, 2.99, 90, '2024-03-18'),
('Gillette Gel da Barba Sensitive', 'Gel da barba lenitivo per pelli sensibili', 22, 5, 3.49, 85, '2024-05-10');


INSERT INTO user (id, name, email, username, password, photo, sesso) VALUES
(2, 'Onorato Mirko', 'mirko.onorato@gmail.com', 'mirko.onorato', '{noop}pass', 'profile2.png', 'M'),
(3, 'Visciano Gino', 'gino.visciano@gmail.com', 'gino.visciano', '{noop}pass', 'profile3.png', 'M'),
(4, 'Milone Amelia', 'amelia.milone@gmail.com', 'amelia.milone', '{noop}pass', 'profile4.png', 'F'),
(5, 'Armarolo Luigi', 'luigi.armarolo@gmail.com', 'luigi.armarolo', '{noop}pass', 'profile5.png', 'M'),
(6, 'Dangelo Nicola', 'nicola.dangelo@gmail.com', 'nicola.dangelo', '{noop}pass', 'profile6.png', 'M'),
(7, 'Daniele Marcello', 'marcello.daniele@gmail.com', 'marcello.daniele', '{noop}pass', 'profile7.png', 'M'),
(8, 'Di Roberto Antonio Joseph', 'antoniojoseph.diroberto@gmail.com', 'antoniojoseph.diroberto', '{noop}pass', 'profile8.png', 'M'),
(9, 'Esposito Christian', 'christian.esposito@gmail.com', 'christian.esposito', '{noop}pass', 'profile9.png', 'M'),
(10, 'Granata Marco', 'marco.granata@gmail.com', 'marco.granata', '{noop}pass', 'profile10.png', 'M'),
(11, 'Iovino Tommaso', 'tommaso.iovino@gmail.com', 'tommaso.iovino', '{noop}pass', 'profile11.png', 'M'),
(12, 'Lettieri Fabrizio', 'fabrizio.lettieri@gmail.com', 'fabrizio.lettieri', '{noop}pass', 'profile12.png', 'M'),
(13, 'Mariani Paolo', 'paolo.mariani@gmail.com', 'paolo.mariani', '{noop}pass', 'profile13.png', 'M'),
(14, 'Pelli Fiorella', 'fiorella.pelli@gmail.com', 'fiorella.pelli', '{noop}pass', 'profile14.png', 'F'),
(15, 'Saldamarco Sabrina', 'sabrina.saldamarco@gmail.com', 'sabrina.saldamarco', '{noop}pass', 'profile15.png', 'F'),
(16, 'Scuotto Giovanna', 'giovanna.scuotto@gmail.com', 'giovanna.scuotto', '{noop}pass', 'profile16.png', 'F'),
(17, 'Tozio Gerardo', 'gerardo.tozio@gmail.com', 'gerardo.tozio', '{noop}pass', 'profile17.png', 'M');


ALTER TABLE `user` DROP INDEX UKa3imlf41l37utmxiquukk8ajc;

 SHOW INDEX FROM `user`;
 

INSERT INTO user_roles (user_id, roles_id) VALUES
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2);

INSERT INTO ordini (id, data_ordine, prezzo_totale, user_id) VALUES
(1, '2024-04-15', 351.49, 2),
(2, '2024-04-16', 229.90, 3),
(3, '2024-04-18', 179.99, 4),
(4, '2024-04-20', 499.99, 5),
(5, '2024-05-01', 89.90, 6),
(6, '2024-05-03', 29.90, 7),
(7, '2024-05-05', 139.99, 8),
(8, '2024-05-06', 179.90, 9),
(9, '2024-05-07', 299.00, 10),
(10,'2024-05-10', 3.99, 11);


INSERT INTO ordine_prodotto (ordine_id, prodotto_id) VALUES
(1, 82), -- Sony WH-1000XM5 Headphones
(1, 93), -- Nike Air Max 270
(2, 91), -- Xiaomi Robot Vacuum S10
(3, 85), -- Nokia G21 Smartphone
(4, 88), -- Suunto 9 Peak Pro
(4, 89), -- Sony PlayStation 5
(5, 92), -- Zara Giacca Uomo
(5, 94), -- Adidas Hoodie Essentials
(6, 103),-- BioTechUSA Iso Whey Zero 908g
(7, 93), -- Nike Air Max 270
(7, 95), -- Zara Pantaloni Cargo Donna
(8, 90), -- HP Monitor 27 Full HD
(9, 97), -- Garmin Vivomove Trend
(10,105); -- Nivea Crema Soft 300ml