-- HABILITANDO CONSTRAINTS

USE COMERCIO_OLTP
GO

ALTER TABLE VENDEDOR ADD CONSTRAINT FK_GERENTE
FOREIGN KEY(ID_GERENTE) REFERENCES VENDEDOR(IDVENDEDOR)
GO

ALTER TABLE NOTA_FISCAL ADD CONSTRAINT FK_NOTA_CLIENTE
FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE)
GO

ALTER TABLE NOTA_FISCAL ADD CONSTRAINT FK_NOTA_VENDEDOR
FOREIGN KEY(ID_VENDEDOR) REFERENCES VENDEDOR(IDVENDEDOR)
GO

ALTER TABLE ITEM_NOTA ADD CONSTRAINT FK_ITEM_PRODUTO
FOREIGN KEY(ID_PRODUTO) REFERENCES PRODUTO(IDPRODUTO)
GO

ALTER TABLE ITEM_NOTA ADD CONSTRAINT FK_ITEM_NOTAFISCAL
FOREIGN KEY(ID_NOTA_FISCAL) REFERENCES NOTA_FISCAL(IDNOTA)
GO

ALTER TABLE PRODUTO ADD CONSTRAINT FK_PRODUTO_FORNECEDOR
FOREIGN KEY(ID_FORNECEDOR) REFERENCES FORNECEDOR(IDFORNECEDOR)
GO


ALTER TABLE PRODUTO ADD CONSTRAINT FK_PRODUTO_CATEGORIA
FOREIGN KEY(ID_CATEGORIA) REFERENCES CATEGORIA(IDCATEGORIA)
GO

ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_CLIENTE
FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE)
GO

ALTER TABLE NOTA_FISCAL ADD CONSTRAINT FK_NOTA_FORMA
FOREIGN KEY(ID_FORMA) REFERENCES FORMA_PAGAMENTO(IDFORMA)
GO