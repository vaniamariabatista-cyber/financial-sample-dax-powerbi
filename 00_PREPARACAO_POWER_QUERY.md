# Preparar a origem no Power BI

1. Use **Obter dados → Excel** e selecione o arquivo Financial Sample fornecido na atividade.
2. No Navegador, selecione a tabela/folha que contém a amostra financeira.
3. No Power Query, renomeie a consulta para `Financials_origem`.
4. Confirme os tipos: `Units Sold`, `Manufacturing Price`, `Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS` e `Profit` como numéricos; `Date` como Data; campos categóricos como Texto.
5. Mantenha a consulta de origem como backup e desabilite a carga no relatório se apropriado; o nome deve ser `Financials_origem` porque as consultas seguintes fazem referência a ele.
6. Crie uma consulta em branco para cada arquivo `.m` de `power_query/` (exceto este arquivo e este guia), abra o Editor Avançado e cole o código. Nomeie a consulta pelo nome indicado no arquivo, por exemplo `D_Produtos`.

Os códigos pressupõem os nomes de colunas do Financial Sample padrão: `Product`, `Discount Band`, `Sale Price`, `Units Sold`, `Manufacturing Price`, `Discount`, `Segment`, `Country`, `Sales`, `Profit` e `Date`.
