# Checklist de validação no Power BI

O `.pbix` final precisa ser salvo pelo Power BI Desktop. Este checklist não substitui a execução real.

- [ ] Importar Financial Sample e criar/renomear consulta `Financials_origem`.
- [ ] Confirmar tipos de dados e nomes dos cabeçalhos.
- [ ] Criar as cinco dimensões/fato através dos arquivos M.
- [ ] Conferir que os seis valores de Product foram mapeados para IDs e que não há ID_Produto nulo.
- [ ] Conferir unicidade de `ID_produto`, `SK_Produto_Detalhe`, `SK_Desconto`, `ID_Detalhes` e `D_Calendário[Date]`.
- [ ] Criar a dimensão `D_Calendário` via `CALENDAR()`.
- [ ] Criar relacionamentos 1:* das dimensões para `F_Vendas`; direção de filtro dimensão → fato.
- [ ] Validar somas de Sales, Profit e Units Sold contra `Financials_origem`.
- [ ] Criar medidas em `dax/02_medidas.dax`.
- [ ] Salvar o arquivo PBIX, exportar imagem do modelo e fazer upload ao repositório.
