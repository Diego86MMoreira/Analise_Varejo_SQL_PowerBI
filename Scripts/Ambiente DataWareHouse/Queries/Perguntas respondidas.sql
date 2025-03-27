
--Perguntas a serem respondidas pelo Datawarehouse


--Quem são os melhores clientes? Os melhores clientes podem ser definidos como aqueles que mais compraram em valor total.

SELECT TOP 10 C.NOME, C.IDCLIENTE, SUM(F.TOTAL_ITEM) AS TOTAL_GASTO
FROM FATO F
JOIN DIM_CLIENTE C
ON F.IDCLIENTE = C.IDSK
GROUP BY C.NOME, C.IDCLIENTE
ORDER BY TOTAL_GASTO DESC


NOME						IDCLIENTE	TOTAL_GASTO
Victor Rodrigues			667			167651.00
Enzo Carvalho				571			155429.00
Kauã Fernandes				989			154899.00
Breno Correia				919			152806.00
Felipe Gomes				63			148702.00
Thaís Oliveira				969			147715.00
Beatriz Correia				73			146404.00
Luis Araujo					867			143775.00
Isabella Gomes				295			143608.00
Carolina Ribeiro			826			140175.00


--Quem são os melhores vendedores? Os melhores vendedores podem ser medidos pelo total de vendas realizadas.

SELECT TOP 10 V.NOME, V.IDVENDEDOR, SUM(F.TOTAL_ITEM) AS TOTAL_VENDIDO
FROM FATO F
JOIN DIM_VENDEDOR V 
ON F.IDVENDEDOR = V.IDSK
GROUP BY V.NOME, V.IDVENDEDOR
ORDER BY TOTAL_VENDIDO DESC


NOME					IDVENDEDOR	TOTAL_VENDIDO
PEDRO NUNES				24			3277987.00
MARCELO WITEMBERG		9			3266290.00
TERESA CRISTINA			17			3259813.00
CLARA MAFRA				4			3213195.00
PILAR SANCHES			8			3187588.00
RODRIGO MARQUES			18			3177790.00
HERMES MACEDO			13			3131093.00
RODRIGO BIO				6			3112727.00
GERALDO FRANCISCO		5			3112334.00
CARLOS SENRA			19			3046888.00



--Qual categoria rende mais? Aqui, consideramos a categoria que gerou mais receita.

SELECT TOP 10 C.NOME AS CATEGORIA, SUM(F.TOTAL_ITEM) AS RECEITA_TOTAL
FROM FATO F
JOIN DIM_PRODUTO P 
ON F.IDPRODUTO = P.IDSK
JOIN CATEGORIA C 
ON P.ID_CATEGORIA = C.IDCATEGORIA
GROUP BY C.NOME
ORDER BY RECEITA_TOTAL DESC

CATEGORIA				RECEITA_TOTAL
INFORMATICA				23853136.00
TV E AUDIO				19217739.00
ELETRODOMESTICOS		8958741.00
PASSAGENS				7859940.00
CELULARES				6906620.00
MOVEIS					3988500.00
GAMES					1604442.00
DVDS					592304.00
LIVROS					374769.00


--Qual a minha relação com os fornecedores? Podemos verificar o total de compras feitas com cada fornecedor.

SELECT TOP 10 F.NOME AS FORNECEDOR, SUM(FT.CUSTO_TOTAL) AS TOTAL_COMPRADO
FROM FATO FT
JOIN DIM_FORNECEDOR F 
ON FT.IDFORNECEDOR = F.IDSK
GROUP BY F.NOME
ORDER BY TOTAL_COMPRADO DESC;

FORNECEDOR				TOTAL_COMPRADO
SONY					8725698.00
SAMSUNG					5802783.00
LG						3498486.00
MICROSOFT				2871287.00
PANASONIC				2757850.00
HP						2674600.00
BRASIL MADEIRAS			2657034.00
LINHAS INTERNACIONAIS 	2560854.00
APPLE					2334150.00
GANCA					2164675.00


--Qual meu melhor produto? O melhor produto é aquele que gera mais receita

SELECT TOP 10 P.NOME AS PRODUTO, SUM(F.TOTAL_ITEM) AS RECEITA_TOTAL
FROM FATO F
JOIN DIM_PRODUTO P 
ON F.IDPRODUTO = P.IDSK
GROUP BY P.NOME
ORDER BY RECEITA_TOTAL DESC

PRODUTO						RECEITA_TOTAL
Lavadora Ganca 10l			1873800.00
Smart Tv Samsung 52			1625400.00
Notebook Msft Hibr			1512000.00
Tv Led 60 Sony				1407900.00
Tv 3d Philips 42			1261600.00
Smart Tv Panasonic 52		1230600.00
Tv Led 60 Samsung			1223600.00
Lava Loucas Brastemp		1200500.00
Tv Led 55 Lg				1185600.00
Notebook Hp Inove			1164900.00




-- Qual meu pior produto? enquanto o pior gera menos.

SELECT TOP 10 P.NOME AS PRODUTO, SUM(F.TOTAL_ITEM) AS RECEITA_TOTAL
FROM FATO F
JOIN DIM_PRODUTO P 
ON F.IDPRODUTO = P.IDSK
GROUP BY P.NOME
ORDER BY RECEITA_TOTAL ASC

PRODUTO							RECEITA_TOTAL
Leitor De Cartoes Multilaser	7416.00
A Culpa É Das Estrelas			7944.00
Pendrive 16						8790.00
Sql Server 2016					9390.00
Jackson							9452.00
Cavaleiro Dos 7 Reinos			9540.00
A Vida Secreta					10730.00
Jogos Maléficos					10868.00
Leitor De Cartoes				11118.00
O Super-herói					11160.00

--Em qual região eu vendo mais? A região pode ser analisada somando as vendas por estado ou cidade.


SELECT C.REGIAO, SUM(F.TOTAL_ITEM) AS TOTAL_VENDAS
FROM FATO F
JOIN DIM_CLIENTE C 
ON F.IDCLIENTE = C.IDSK
GROUP BY C.REGIAO
ORDER BY TOTAL_VENDAS DESC

REGIAO				TOTAL_VENDAS
SUDESTE				37584043.00
NORDESTE			13412599.00
SUL					10004119.00
CENTRO-OESTE		8433173.00
NORTE				3922257.00



--Qual vendedor tem a maior taxa de conversão de vendas?

SELECT TOP 10 V.NOME, COUNT(DISTINCT F.IDNOTA) AS NUM_VENDAS, SUM(F.TOTAL_ITEM) AS TOTAL_VENDIDO
FROM FATO F
JOIN DIM_VENDEDOR V 
ON F.IDVENDEDOR = V.IDSK
GROUP BY V.NOME
ORDER BY TOTAL_VENDIDO DESC;


NOME					IDVENDEDOR	TOTAL_VENDIDO
PEDRO NUNES				24			3277987.00
MARCELO WITEMBERG		9			3266290.00
TERESA CRISTINA			17			3259813.00
CLARA MAFRA				4			3213195.00
PILAR SANCHES			8			3187588.00
RODRIGO MARQUES			18			3177790.00
HERMES MACEDO			13			3131093.00
RODRIGO BIO				6			3112727.00
GERALDO FRANCISCO		5			3112334.00
CARLOS SENRA			19			3046888.00

-- quais produtos são frequentemente comprados juntos? -- Essa análise pode ajudar a criar estratégias de cross-sell (vendas combinadas)Q

--  Insight:
--Criar kits promocionais e sugerir produtos no checkout pode aumentar o ticket médio.



SELECT TOP 10 P1.NOME AS PRODUTO_A, P2.NOME AS PRODUTO_B, COUNT(*) AS FREQUENCIA
FROM FATO F1
JOIN FATO F2 
ON F1.IDNOTA = F2.IDNOTA AND F1.IDPRODUTO <> F2.IDPRODUTO
JOIN DIM_PRODUTO P1 
ON F1.IDPRODUTO = P1.IDSK
JOIN DIM_PRODUTO P2 
ON F2.IDPRODUTO = P2.IDSK
GROUP BY P1.NOME, P2.NOME
ORDER BY FREQUENCIA DESC
GO


PRODUTO_A					PRODUTO_B							FREQUENCIA
Rio De Janeiro / New York	Cartao Sd 32 Gb Sandisk				5
Hd 1t Samsung				Freezer 300l Brastemp				5
Samsung Duos				C# Pratico							5
Cartao Sd 32 Gb Sandisk		Rio De Janeiro / New York			5
Teclado Wireless Multilaser	Playstation 3						5
Xtg Sound					Wario								5
Playstation 3				Teclado Wireless Multilaser			5
Gladiadores					Xtg E1								5
C# Pratico					Samsung Duos						5
Ipad 32						Advanced Azure						5

-- Qual é a margem de lucro por produto?
-- Insight:
-- Se um produto vende bem, mas tem margem baixa, podemos reajustar preços ou renegociar custos com fornecedores.

SELECT TOP 10 P.NOME, SUM(F.TOTAL_ITEM - F.CUSTO_TOTAL) AS MARGEM_LUCRO
FROM FATO F
JOIN DIM_PRODUTO P
ON F.IDPRODUTO = P.IDSK
GROUP BY P.NOME
ORDER BY MARGEM_LUCRO DESC;

NOME				MARGEM_LUCRO
Notebook Msft Hibr	567315.00
Galaxy Tab 10		511500.00
Galaxy Note			420980.00
Sony I7				349200.00
Desktop I5			335880.00
Desktop A5 Hp		315820.00
Tv Led 60 Sony		306489.00
Chapa A Gas Ganca	297475.00
Sony I5				288000.00
Playstation 4		284130.00


-- Qual é a PIOR  margem de lucro por produto?

SELECT TOP 10 P.NOME, SUM(F.TOTAL_ITEM - F.CUSTO_TOTAL) AS MARGEM_LUCRO
FROM FATO F
JOIN DIM_PRODUTO P
ON F.IDPRODUTO = P.IDSK
GROUP BY P.NOME
ORDER BY MARGEM_LUCRO ASC;

NOME							MARGEM_LUCRO
O Imortal						3443.00
A Culpa É Das Estrelas			3972.00
Leitor De Cartoes Multilaser	4017.00
Tsql Tuning						4245.00
Jogos Maléficos					4290.00
Jackson							4448.00
A Vida Secreta					4640.00
Sql Server 2016					4695.00
Cavaleiro Dos 7 Reinos			4770.00
Liquidificador Arno				4845.00

-- . Qual é o dia da semana com mais vendas?
-- Se as vendas caem em certos dias, podemos fazer promoções nesses dias para incentivar compras.

SELECT T.DIASEMANA, SUM(F.TOTAL_ITEM) AS TOTAL_VENDAS
FROM FATO F
JOIN DIM_TEMPO T
ON F.IDTEMPO = T.IDSK
GROUP BY T.DIASEMANA
ORDER BY TOTAL_VENDAS DESC;

DIASEMANA	TOTAL_VENDAS
Segunda		10836881.00
Terça		10792127.00
Sexta		10742997.00
Quinta		10549599.00
Quarta		10493564.00
Sábado		9978981.00
Domingo		9962042.00

-- Quais formas de pagamento são mais utilizadas?
-- Insight:
--Se houver um alto uso de cartão de crédito, pode ser interessante oferecer parcelamento sem juros.

SELECT TOP 10 FP.FORMA, COUNT(*) AS QUANTIDADE_VENDAS, SUM(F.TOTAL_ITEM) AS TOTAL_VENDIDO
FROM FATO F
JOIN DIM_FORMA FP 
ON F.IDFORMA = FP.IDSK
GROUP BY FP.FORMA
ORDER BY TOTAL_VENDIDO DESC;

FORMA							QUANTIDADE_VENDAS	TOTAL_VENDIDO
Cartão Visa 3 vezes				2650				5931072.00
Cartão Visa 4 vezes				2673				5840868.00
Cartão Visa 2 vezes				2704				5655826.00
Depósito - Vista				1414				3008140.00
Cartão American 12 vezes		1369				3005637.00
Pagamento Seguro Web - Vista	1402				2960555.00
Tranferência - Vista			1340				2943374.00
Cartão American 10 vezes		1355				2939587.00
Boleto - Vista					1362				2894412.00
Cartão Visa 10 vezes			1345				2871189.00
