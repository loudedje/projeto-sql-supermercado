market=# -- Lojas (1 a 15)
market=# INSERT INTO analytics.Stores (city, neighborhood) VALUES
market-# ('São Paulo', 'Pinheiros'), ('Rio de Janeiro', 'Copacabana'), ('Belo Horizonte', 'Savassi'),
market-# ('Curitiba', 'Batel'), ('Porto Alegre', 'Moinhos de Vento'), ('Florianópolis', 'Centro'),
market-# ('Brasília', 'Asa Sul'), ('Salvador', 'Barra'), ('Fortaleza', 'Meireles'),
market-# ('Recife', 'Boa Viagem'), ('Goiânia', 'Setor Bueno'), ('Manaus', 'Adrianópolis'),
market-# ('Belém', 'Nazaré'), ('São Paulo', 'Moema'), ('Rio de Janeiro', 'Ipanema');
INSERT 0 15
market=#
market=# -- Fornecedores (1 a 30)
market=# INSERT INTO analytics.Suppliers (name, contact_info) VALUES
market-# ('Laticínios Pura Vida', 'vendas@puravida.com'), ('Hortifruti Fazenda Feliz', 'contato@fazendafeliz.com.br'),
market-# ('Padaria Pão Dourado', 'pedidos@paodourado.com'), ('Açougue Carne Nobre', 'comercial@carnenobre.net'),
market-# ('Bebidas Refrescantes S.A.', 'contato@refrescantes.com'), ('Grãos do Brasil Ltda', 'compras@graosbrasil.com'),
market-# ('Massas da Nona', 'vendas@massasdanona.it'), ('Limpeza Total Indústria', 'contato@limpezatotal.com'),
market-# ('Higiene Pessoal Bem-Estar', 'comercial@bemestarhigiene.com'), ('Congelados Práticos', 'pedidos@congeladospraticos.com'),
market-# ('Doces e Balas Fantasia', 'contato@docesfantasia.com'), ('Importados do Mundo', 'imports@mundo.com'),
market-# ('Frios e Embutidos Serrano', 'vendas@serranofrios.com'), ('Orgânicos Terra Viva', 'contato@terravivaorganicos.com'),
market-# ('Pet Food Amigo Fiel', 'comercial@amigofielpet.com'), ('Utensílios de Cozinha Casa & Cia', 'vendas@casacia.com'),
market-# ('Frangos & Aves Granja do Sol', 'pedidos@granjadosol.com'), ('Peixaria Mar Azul', 'contato@marazulpescados.com'),
market-# ('Conservas da Vovó', 'vendas@conservasdavovo.com'), ('Biscoitos Crocantes', 'comercial@crocantes.com'),
market-# ('Chás e Cafés Aromas', 'contato@aromascafe.com'), ('Sorvetes Gelados Verão', 'pedidos@geladosverao.com'),
market-# ('Cereais Matinais Energia+', 'contato@energiaplus.com'), ('Molhos e Temperos Sabor Real', 'vendas@saborreal.com'),
market-# ('Ovos da Terra', 'comercial@ovosdaterra.com'), ('Farinhas e Fermentos Trigo Bom', 'contato@trigobom.com'),
market-# ('Azeites e Óleos Oliva Dourada', 'vendas@olivadourada.com'), ('Cosméticos Beleza Rara', 'contato@belezarara.com'),
market-# ('Vinhos & Destilados Adega Nobre', 'comercial@adeganobre.com'), ('Descartáveis Fácil Uso', 'vendas@faciluso.com');
INSERT 0 30
market=#
market=# -- Tabela de Datas
market=# INSERT INTO analytics.Dim_Date (date_key, full_date, year, month, day, day_of_week, is_weekend, is_holiday)
market-# SELECT TO_CHAR(d, 'YYYYMMDD')::INT, d::DATE, EXTRACT(YEAR FROM d), EXTRACT(MONTH FROM d), EXTRACT(DAY FROM d), TO_CHAR(d, 'TMDy'), CASE WHEN EXTRACT(ISODOW FROM d) IN (6, 7) THEN TRUE ELSE FALSE END, FALSE FROM generate_series('2023-01-01'::DATE, '2025-12-31'::DATE, '1 day'::INTERVAL) AS d;
INSERT 0 1096
market=#
market=# -- Funcionários (1 a 50)
market=# INSERT INTO analytics.Employees (name, region, store_id) VALUES
market-# ('João Silva', 'Capital', 1),('Maria Oliveira', 'Capital', 1),('Carlos Pereira', 'Metropolitana', 2),
market-# ('Ana Souza', 'Metropolitana', 2),('Pedro Costa', 'Central', 3),('Lúcia Martins', 'Central', 3),
market-# ('Ricardo Alves', 'Sul', 4), ('Fernanda Lima', 'Sul', 4), ('Juliano Barros', 'Sul', 4),
market-# ('Lucas Martins', 'Sul', 5), ('Patrícia Souza', 'Sul', 5), ('Vanessa Rocha', 'Sul', 6),
market-# ('Rodrigo Nunes', 'Sul', 6), ('Amanda Correia', 'Centro-Oeste', 7), ('Leandro Ferreira', 'Centro-Oeste', 7),
market-# ('Bruna Gomes', 'Centro-Oeste', 7), ('Vinícius Castro', 'Nordeste', 8), ('Tatiane Ribeiro', 'Nordeste', 8),
market-# ('Diego Azevedo', 'Nordeste', 9), ('Camila Dias', 'Nordeste', 9), ('Fábio Melo', 'Nordeste', 9),
market-# ('Gustavo Pinto', 'Nordeste', 10), ('Larissa Cunha', 'Nordeste', 10), ('Marcelo Campos', 'Norte', 11),
market-# ('Priscila Cardoso', 'Norte', 11), ('André Pires', 'Norte', 12), ('Renata Jesus', 'Norte', 12),
market-# ('Igor Ferreira', 'Norte', 12), ('Sérgio Lopes', 'Norte', 13), ('Cláudia Neves', 'Norte', 13),
market-# ('Paulo Sales', 'Sudeste', 14), ('Cristina Machado', 'Sudeste', 14), ('Eduardo Fogaça', 'Sudeste', 14),
market-# ('Roberto Santana', 'Sudeste', 15), ('Mônica Duarte', 'Sudeste', 15), ('Leonardo Moraes', 'Capital', 1),
market-# ('Carolina Reis', 'Capital', 1), ('Alexandre Borges', 'Metropolitana', 2), ('Elaine Viana', 'Metropolitana', 2),
market-# ('Daniel Chaves', 'Central', 3), ('Beatriz Macedo', 'Central', 3), ('Tiago Tavares', 'Sudeste', 14),
market-# ('Jéssica Henriques', 'Sudeste', 15), ('Otávio Vieira', 'Sul', 5), ('Gisele Costa', 'Sul', 6),
market-# ('Márcio Oliveira', 'Nordeste', 8), ('Sandra Pereira', 'Nordeste', 9), ('Felipe Almeida', 'Norte', 11),
market-# ('Adriana Nunes', 'Norte', 12);
INSERT 0 49
market=#
market=# -- Produtos (1 a 60)
market=# INSERT INTO analytics.Products (name, category, brand, price, stock_quantity, supplier_id) VALUES
market-# ('Leite Integral UHT 1L', 'Laticínios', 'Pura Vida', 5.50, 150, 1), ('Queijo Minas Frescal 500g', 'Laticínios', 'Pura Vida', 12.80, 80, 1),
market-# ('Alface Crespa (unidade)', 'Hortifruti', 'Fazenda Feliz', 3.20, 200, 2), ('Tomate Italiano (kg)', 'Hortifruti', 'Fazenda Feliz', 8.99, 120, 2),
market-# ('Pão Francês (unidade)', 'Padaria', 'Pão Dourado', 0.75, 300, 3), ('Baguete com Gergelim', 'Padaria', 'Pão Dourado', 6.50, 50, 3),
market-# ('Picanha Bovina (kg)', 'Açougue', 'Carne Nobre', 79.90, 40, 4), ('Filé de Frango (kg)', 'Açougue', 'Carne Nobre', 22.50, 90, 4),
market-# ('Refrigerante Cola 2L', 'Bebidas', 'Refrescantes S.A.', 9.80, 250, 5), ('Suco de Laranja 1L', 'Bebidas', 'Refrescantes S.A.', 7.20, 180, 5),
market-# ('Arroz Agulhinha Tipo 1 (5kg)', 'Mercearia', 'Grãos do Brasil', 28.90, 200, 6), ('Feijão Carioca (1kg)', 'Mercearia', 'Grãos do Brasil', 9.50, 300, 6),
market-# ('Macarrão Espaguete (500g)', 'Massas', 'Massas da Nona', 4.80, 400, 7), ('Molho de Tomate Tradicional (340g)', 'Mercearia', 'Sabor Real', 3.50, 500, 24),
market-# ('Detergente Líquido Neutro (500ml)', 'Limpeza', 'Limpeza Total', 2.99, 600, 8), ('Sabão em Pó (1kg)', 'Limpeza', 'Limpeza Total', 15.80, 250, 8),
market-# ('Shampoo Hidratante (350ml)', 'Higiene', 'Bem-Estar', 18.90, 150, 9), ('Creme Dental Menta Forte (90g)', 'Higiene', 'Bem-Estar', 4.50, 700, 9),
market-# ('Lasanha Bolonhesa Congelada (600g)', 'Congelados', 'Práticos', 22.50, 100, 10), ('Chocolate ao Leite (90g)', 'Doces', 'Fantasia', 6.99, 800, 11),
market-# ('Azeite Extra Virgem (500ml)', 'Mercearia', 'Oliva Dourada', 35.90, 120, 27), ('Salmão Fresco (kg)', 'Peixaria', 'Mar Azul', 99.90, 30, 18),
market-# ('Frango Inteiro Congelado (kg)', 'Açougue', 'Granja do Sol', 15.99, 150, 17), ('Ração para Cães Adultos (1kg)', 'Pet', 'Amigo Fiel', 25.00, 90, 15),
market-# ('Vinho Tinto Cabernet Sauvignon (750ml)', 'Bebidas', 'Adega Nobre', 45.00, 70, 29), ('Café em Pó Tradicional (500g)', 'Mercearia', 'Aromas', 14.90, 220, 21),
market-# ('Cereal Matinal de Milho (300g)', 'Mercearia', 'Energia+', 11.50, 180, 23), ('Biscoito Recheado Chocolate (120g)', 'Biscoitos', 'Crocantes', 3.80, 500, 20),
market-# ('Sorvete de Creme (2L)', 'Congelados', 'Gelados Verão', 29.90, 80, 22), ('Ovos Brancos (dúzia)', 'Mercearia', 'Ovos da Terra', 9.99, 150, 25),
market-# ('Farinha de Trigo (1kg)', 'Mercearia', 'Trigo Bom', 5.20, 300, 26), ('Óleo de Soja (900ml)', 'Mercearia', 'Oliva Dourada', 8.50, 400, 27),
market-# ('Creme de Avelã (350g)', 'Doces', 'Importados do Mundo', 28.00, 100, 12), ('Queijo Parmesão Ralado (50g)', 'Frios', 'Serrano', 7.50, 200, 13),
market-# ('Cenoura Orgânica (500g)', 'Hortifruti', 'Terra Viva', 6.90, 80, 14), ('Abobrinha Orgânica (unidade)', 'Hortifruti', 'Terra Viva', 4.50, 70, 14),
market-# ('Milho em Conserva (lata)', 'Mercearia', 'Conservas da Vovó', 3.80, 250, 19), ('Copo Descartável (100 un)', 'Descartáveis', 'Fácil Uso', 8.90, 150, 30),
market-# ('Guardanapo de Papel (50 un)', 'Descartáveis', 'Fácil Uso', 4.20, 200, 30), ('Hidratante Corporal (200ml)', 'Cosméticos', 'Beleza Rara', 25.90, 90, 28),
market-# ('Sabonete Líquido (250ml)', 'Higiene', 'Bem-Estar', 12.50, 180, 9), ('Amaciante de Roupas (2L)', 'Limpeza', 'Limpeza Total', 19.90, 160, 8),
market-# ('Pão de Forma Integral (500g)', 'Padaria', 'Pão Dourado', 9.80, 100, 3), ('Peito de Peru Fatiado (180g)', 'Frios', 'Serrano', 14.50, 80, 13),
market-# ('Iogurte Natural (170g)', 'Laticínios', 'Pura Vida', 3.50, 300, 1), ('Requeijão Cremoso (200g)', 'Laticínios', 'Pura Vida', 8.90, 150, 1),
market-# ('Batata Congelada Palito (1kg)', 'Congelados', 'Práticos', 18.90, 120, 10), ('Atum Sólido em Óleo (lata)', 'Mercearia', 'Mar Azul', 9.90, 180, 18),
market-# ('Maionese (500g)', 'Mercearia', 'Sabor Real', 7.80, 200, 24), ('Mostarda (200g)', 'Mercearia', 'Sabor Real', 5.50, 150, 24),
market-# ('Carvão Vegetal (3kg)', 'Utilidades', 'Casa & Cia', 15.00, 50, 16), ('Linguiça Toscana (kg)', 'Açougue', 'Carne Nobre', 25.90, 70, 4),
market-# ('Asa de Frango (kg)', 'Açougue', 'Granja do Sol', 19.90, 90, 17), ('Cerveja Pilsen (lata 350ml)', 'Bebidas', 'Refrescantes S.A.', 3.50, 1000, 5),
market-# ('Água Mineral sem Gás (1.5L)', 'Bebidas', 'Refrescantes S.A.', 2.80, 800, 5), ('Tira Manchas (500ml)', 'Limpeza', 'Limpeza Total', 17.50, 100, 8),
market-# ('Esponja de Aço (pacote c/ 8)', 'Limpeza', 'Casa & Cia', 5.90, 150, 16), ('Chá de Camomila (caixa c/ 10)', 'Mercearia', 'Aromas', 6.20, 120, 21),
market-# ('Adoçante Líquido (100ml)', 'Mercearia', 'Bem-Estar', 8.50, 130, 9), ('Gelatina em Pó (caixa)', 'Doces', 'Fantasia', 2.50, 400, 11);
INSERT 0 60
market=#
market=# -- Clientes (1 a 50 - AGORA COM 50 CLIENTES DE VERDADE)
market=# INSERT INTO analytics.Customers (FirstName, LastName, Email, Registration_date, city, birth_date) VALUES
market-# ('Ana', 'Silva', 'ana.silva@email.com', '2023-01-15 10:00:00', 'São Paulo', '1990-05-21'),('Bruno', 'Santos', 'bruno.santos@email.com', '2023-01-16 11:30:00', 'Rio de Janeiro', '1985-03-12'),
market-# ('Carla', 'Oliveira', 'carla.o@email.com', '2023-02-10 14:20:00', 'Belo Horizonte', '1992-11-30'),('Daniel', 'Pereira', 'daniel.p@email.com', '2023-02-20 09:00:00', 'São Paulo', '1988-07-07'),
market-# ('Eduarda', 'Costa', 'eduarda.costa@email.com', '2023-03-05 18:00:00', 'Rio de Janeiro', '2000-01-15'),('Felipe', 'Rodrigues', 'felipe.r@email.com', '2023-03-12 12:00:00', 'Belo Horizonte', '1995-09-10'),
market-# ('Gabriela', 'Almeida', 'gabriela.a@email.com', '2023-04-01 16:45:00', 'São Paulo', '1998-02-25'),('Heitor', 'Nunes', 'heitor.n@email.com', '2023-04-02 11:10:00', 'Rio de Janeiro', '1982-06-18'),
market-# ('Isabela', 'Lima', 'isabela.l@email.com', '2023-05-19 13:00:00', 'Belo Horizonte', '1993-04-03'),('Joaquim', 'Gomes', 'joaquim.g@email.com', '2023-05-25 15:00:00', 'São Paulo', '1979-12-22'),
market-# ('Laura', 'Mendes', 'laura.m@email.com', '2023-06-11 19:00:00', 'Rio de Janeiro', '1991-08-14'),('Miguel', 'Ribeiro', 'miguel.r@email.com', '2023-06-30 08:30:00', 'Belo Horizonte', '1996-10-05'),
market-# ('Natália', 'Carvalho', 'natalia.c@email.com', '2023-07-07 20:00:00', 'São Paulo', '1987-05-28'),('Otávio', 'Martins', 'otavio.m@email.com', '2023-07-15 17:00:00', 'Rio de Janeiro', '1994-03-17'),
market-# ('Paula', 'Araújo', 'paula.a@email.com', '2023-08-21 10:30:00', 'Belo Horizonte', '1999-11-09'),('Rafael', 'Barbosa', 'rafael.b@email.com', '2023-08-22 14:00:00', 'São Paulo', '1984-01-30'),
market-# ('Sofia', 'Fernandes', 'sofia.f@email.com', '2023-09-10 11:00:00', 'Rio de Janeiro', '2001-07-23'),('Thiago', 'Gonçalves', 'thiago.g@email.com', '2023-09-18 16:00:00', 'Belo Horizonte', '1990-02-11'),
market-# ('Valentina', 'Moreira', 'valentina.m@email.com', '2023-10-03 12:30:00', 'São Paulo', '1986-09-02'),('William', 'Correia', 'william.c@email.com', '2023-10-14 18:30:00', 'Rio de Janeiro', '1997-04-19'),
market-# ('Yasmin', 'Teixeira', 'yasmin.t@email.com', '2023-11-05 09:30:00', 'Belo Horizonte', '1992-12-08'),('Zeca', 'Melo', 'zeca.m@email.com', '2023-11-11 13:30:00', 'São Paulo', '1983-10-16'),
market-# ('Alice', 'Barros', 'alice.b@email.com', '2023-12-01 15:30:00', 'Rio de Janeiro', '1995-06-27'),('Bento', 'Freitas', 'bento.f@email.com', '2023-12-20 17:30:00', 'Belo Horizonte', '1989-03-04'),
market-# ('Cecília', 'Pinto', 'cecilia.p@email.com', '2024-01-09 10:00:00', 'São Paulo', '1998-11-13'),('Davi', 'Dias', 'davi.d@email.com', '2024-01-15 11:00:00', 'Rio de Janeiro', '1981-08-20'),
market-# ('Esther', 'Campos', 'esther.c@email.com', '2024-02-02 14:00:00', 'Belo Horizonte', '1993-02-09'),('Fábio', 'Cardoso', 'fabio.c@email.com', '2024-02-18 19:00:00', 'São Paulo', '1996-05-01'),
market-# ('Gael', 'Pires', 'gael.p@email.com', '2024-03-10 12:00:00', 'Rio de Janeiro', '2002-09-24'),('Heloísa', 'Jesus', 'heloisa.j@email.com', '2024-03-25 16:00:00', 'Belo Horizonte', '1987-12-14'),
market-# ('Ícaro', 'Ferreira', 'icaro.f@email.com', '2024-04-12 09:00:00', 'São Paulo', '1991-07-06'),('Júlia', 'Lopes', 'julia.l@email.com', '2024-04-20 18:00:00', 'Rio de Janeiro', '1999-01-26'),
market-# ('Kael', 'Neves', 'kael.n@email.com', '2024-05-03 11:30:00', 'Belo Horizonte', '1985-11-03'),('Liz', 'Cunha', 'liz.c@email.com', '2024-05-17 15:00:00', 'São Paulo', '1994-08-11'),
market-# ('Manuela', 'Sales', 'manuela.s@email.com', '2024-06-08 13:00:00', 'Rio de Janeiro', '1997-10-31'),('Noah', 'Machado', 'noah.m@email.com', '2024-06-22 17:00:00', 'Belo Horizonte', '1983-04-22'),
market-# ('Olívia', 'Fogaça', 'olivia.f@email.com', '2024-07-14 10:00:00', 'São Paulo', '2000-03-08'),('Pietro', 'Santana', 'pietro.s@email.com', '2024-07-29 14:30:00', 'Rio de Janeiro', '1992-09-12'),
market-# ('Quezia', 'Duarte', 'quezia.d@email.com', '2024-08-05 19:00:00', 'Belo Horizonte', '1988-06-15'),('Ravi', 'Moraes', 'ravi.m@email.com', '2024-08-19 12:30:00', 'São Paulo', '1995-12-04'),
market-# ('Sarah', 'Reis', 'sarah.r@email.com', '2024-09-01 16:30:00', 'Rio de Janeiro', '1998-05-20'),('Théo', 'Borges', 'theo.b@email.com', '2024-09-15 11:00:00', 'Belo Horizonte', '1980-02-28'),
market-# ('Uri', 'Viana', 'uri.v@email.com', '2024-10-10 15:00:00', 'São Paulo', '1993-09-06'),('Vicente', 'Chaves', 'vicente.c@email.com', '2024-10-25 10:00:00', 'Rio de Janeiro', '1996-07-18'),
market-# ('Xavier', 'Macedo', 'xavier.m@email.com', '2024-11-07 14:00:00', 'Belo Horizonte', '1984-01-02'),('Yuri', 'Tavares', 'yuri.t@email.com', '2024-11-21 18:00:00', 'São Paulo', '1999-08-29'),
market-# ('Zoe', 'Henriques', 'zoe.h@email.com', '2024-12-09 13:00:00', 'Rio de Janeiro', '1990-04-07'),('Augusto', 'Vieira', 'augusto.v@email.com', '2024-12-24 17:00:00', 'Belo Horizonte', '1982-11-23'),
market-# ('Bia', 'Ramos', 'bia.r@email.com', '2025-01-01 12:00:00', 'Curitiba', '1997-01-01'), ('Caio', 'Nogueira', 'caio.n@email.com', '2025-01-02 12:00:00', 'Porto Alegre', '1996-02-02');
INSERT 0 50
market=#
market=# -- Vendas (Headers e Itens)
market=# INSERT INTO analytics.Sales_Header (customer_id, employee_id, store_id, date_key, sale_timestamp, total_receipt_value) VALUES
market-# (1, 1, 1, 20240120, '2024-01-20 10:15:00', 18.30), (2, 3, 2, 20240121, '2024-01-21 11:05:00', 12.19),
market-# (3, 5, 3, 20240215, '2024-02-15 14:30:00', 8.25), (4, 2, 1, 20240222, '2024-02-22 09:10:00', 89.71),
market-# (5, 4, 2, 20240307, '2024-03-07 18:15:00', 32.35), (6, 6, 3, 20240315, '2024-03-15 12:20:00', 15.20),
market-# (7, 7, 4, 20240403, '2024-04-03 16:50:00', 22.50), (8, 18, 8, 20240405, '2024-04-05 11:15:00', 7.20),
market-# (9, 30, 13, 20240520, '2024-05-20 13:05:00', 16.00), (10, 40, 3, 20240528, '2024-05-28 15:10:00', 102.40),
market-# (11, 44, 5, 20240612, '2024-06-12 19:05:00', 5.50), (12, 45, 6, 20240701, '2024-07-01 08:35:00', 17.98),
market-# (13, 1, 1, 20240708, '2024-07-08 20:10:00', 19.60), (14, 3, 2, 20240718, '2024-07-18 17:05:00', 113.84),
market-# (15, 5, 3, 20240822, '2024-08-22 10:35:00', 10.40), (16, 2, 1, 20240825, '2024-08-25 14:10:00', 22.50),
market-# (17, 4, 2, 20240912, '2024-09-12 11:05:00', 13.00), (18, 6, 3, 20240920, '2024-09-20 16:15:00', 45.00),
market-# (19, 7, 4, 20241005, '2024-10-05 12:35:00', 14.15), (20, 18, 8, 20241016, '2024-10-16 18:40:00', 87.10),
market-# (21, 30, 13, 20241107, '2024-11-07 09:35:00', 16.19), (22, 40, 3, 20241114, '2024-11-14 13:40:00', 5.50),
market-# (23, 44, 5, 20241203, '2024-12-03 15:35:00', 25.60), (24, 45, 6, 20241222, '2024-12-22 17:45:00', 159.80),
market-# (25, 1, 1, 20250110, '2025-01-10 10:05:00', 3.20), (26, 3, 2, 20250118, '2025-01-18 11:10:00', 16.19),
market-# (27, 5, 3, 20250204, '2025-02-04 14:05:00', 16.25), (28, 2, 1, 20250220, '2025-02-20 19:15:00', 45.00),
market-# (29, 4, 2, 20250312, '2025-03-12 12:05:00', 17.00), (30, 6, 3, 20250328, '2025-03-28 16:10:00', 24.55),
market-# (31, 7, 4, 20250414, '2025-04-14 09:05:00', 14.40), (32, 18, 8, 20250422, '2024-04-22 18:15:00', 11.00),
market-# (33, 30, 13, 20250505, '2025-05-05 11:40:00', 17.75), (34, 40, 3, 20250519, '2025-05-19 15:05:00', 16.20),
market-# (35, 44, 5, 20250610, '2025-06-10 13:10:00', 79.90), (36, 45, 6, 20250625, '2025-06-25 17:05:00', 16.19),
market-# (37, 1, 1, 20250716, '2025-07-16 10:10:00', 15.30), (38, 3, 2, 20250731, '2025-07-31 14:35:00', 9.80),
market-# (39, 5, 3, 20250807, '2025-08-07 19:10:00', 21.79), (40, 2, 1, 20250821, '2025-08-21 12:40:00', 6.40),
market-# (41, 4, 2, 20250903, '2025-09-03 16:35:00', 22.50), (42, 6, 3, 20250918, '2025-09-18 11:05:00', 45.00),
market-# (43, 7, 4, 20251012, '2025-10-12 15:10:00', 11.00), (44, 18, 8, 20251028, '2025-10-28 10:05:00', 13.00),
market-# (45, 30, 13, 20251109, '2025-11-09 14:15:00', 9.74), (46, 40, 3, 20251123, '2025-11-23 18:05:00', 17.98),
market-# (47, 44, 5, 20251211, '2025-12-11 13:15:00', 167.79), (48, 45, 6, 20251226, '2025-12-26 17:10:00', 29.40),
market-# (49, 1, 1, 20251228, '2025-12-28 10:20:00', 11.00), (50, 3, 2, 20251230, '2025-12-30 11:30:00', 17.00);
INSERT 0 50
market=#
market=# INSERT INTO analytics.Sales_Items (sale_id, product_id, quantity, price_at_sale, total_item_value) VALUES
market-# (1, 1, 1, 5.50, 5.50), (1, 2, 1, 12.80, 12.80), (2, 3, 1, 3.20, 3.20), (2, 4, 1, 8.99, 8.99),
market-# (3, 5, 11, 0.75, 8.25), (4, 7, 1, 79.90, 79.90), (4, 4, 1, 8.99, 8.99), (4, 5, 1, 0.75, 0.82),
market-# (5, 9, 2, 9.80, 19.60), (5, 10, 1, 7.20, 7.20), (5, 5, 7, 0.75, 5.55), (6, 1, 1, 5.50, 5.50),
market-# (6, 6, 1, 6.50, 6.50), (6, 3, 1, 3.20, 3.20), (7, 8, 1, 22.50, 22.50), (8, 10, 1, 7.20, 7.20),
market-# (9, 2, 1, 12.80, 12.80), (9, 3, 1, 3.20, 3.20), (10, 7, 1, 79.90, 79.90), (10, 8, 1, 22.50, 22.50),
market-# (11, 1, 1, 5.50, 5.50), (12, 4, 2, 8.99, 17.98), (13, 9, 2, 9.80, 19.60), (14, 7, 1, 79.90, 79.90),
market-# (14, 10, 1, 7.20, 7.20), (14, 3, 1, 3.20, 3.20), (14, 5, 3, 0.75, 2.25), (14, 11, 1, 28.90, 28.90),
market-# (15, 3, 1, 3.20, 3.20), (15, 10, 1, 7.20, 7.20), (16, 8, 1, 22.50, 22.50), (17, 6, 2, 6.50, 13.00),
market-# (18, 8, 2, 22.50, 45.00), (19, 5, 5, 0.75, 3.75), (19, 3, 1, 3.20, 3.20), (19, 10, 1, 7.20, 7.20),
market-# (20, 7, 1, 79.90, 79.90), (20, 10, 1, 7.20, 7.20), (21, 4, 1, 8.99, 8.99), (21, 10, 1, 7.20, 7.20),
market-# (22, 1, 1, 5.50, 5.50), (23, 2, 2, 12.80, 25.60), (24, 7, 2, 79.90, 159.80), (25, 3, 1, 3.20, 3.20),
market-# (26, 4, 1, 8.99, 8.99), (26, 10, 1, 7.20, 7.20), (27, 5, 7, 0.75, 5.25), (27, 1, 2, 5.50, 11.00),
market-# (28, 8, 2, 22.50, 45.00), (29, 9, 1, 9.80, 9.80), (29, 10, 1, 7.20, 7.20), (30, 1, 2, 5.50, 11.00),
market-# (30, 2, 1, 12.80, 12.80), (30, 5, 1, 0.75, 0.75), (31, 10, 2, 7.20, 14.40), (32, 1, 2, 5.50, 11.00),
market-# (33, 5, 9, 0.75, 6.75), (33, 1, 2, 5.50, 11.00), (34, 3, 1, 3.20, 3.20), (34, 6, 2, 6.50, 13.00),
 (35, 7, 1, 79.90, 79.90), (36, 4, 1, 8.99, 8.99), (36, 10, 1, 7.20, 7.20), (37, 9, 1, 9.80, 9.80),
market-# (37, 1, 1, 5.50, 5.50), (38, 9, 1, 9.80, 9.80), (39, 4, 1, 8.99, 8.99), (39, 2, 1, 12.80, 12.80),
market-# (40, 3, 2, 3.20, 6.40), (41, 8, 1, 22.50, 22.50), (42, 8, 2, 22.50, 45.00), (43, 1, 2, 5.50, 11.00),
market-# (44, 6, 2, 6.50, 13.00), (45, 4, 1, 8.99, 8.99), (45, 5, 1, 0.75, 0.75), (46, 4, 2, 8.99, 17.98),
market-# (47, 7, 2, 79.90, 159.80), (47, 4, 1, 8.99, 8.99), (48, 9, 3, 9.80, 29.40), (49, 1, 2, 5.50, 11.00),
market-# (50, 9, 1, 9.80, 9.80), (50, 10, 1, 7.20, 7.20);