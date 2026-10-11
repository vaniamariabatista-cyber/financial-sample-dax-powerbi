# Modelagem e Transformação de Dados com DAX — Financial Sample

Projeto de apoio ao desafio DIO baseado no documento de instruções disponibilizado na atividade. O enunciado pede transformar a tabela única `Financial Sample` em tabelas dimensão e fato, criar uma dimensão de calendário com `CALENDAR()` e registrar no README as etapas e funções utilizadas.

> **Escopo e limitação:** este repositório contém documentação, código M/DAX de referência e diagrama de modelo. Não inclui um arquivo `.pbix` nem afirma que a solução foi executada no Power BI Desktop. O Power BI Desktop não estava disponível no ambiente Debian utilizado durante a preparação. Os códigos devem ser testados no Power BI e ajustados se os nomes reais das colunas da planilha diferirem.

## Artefatos

## Artefatos

- `00_PREPARACAO_POWER_QUERY.md`: instruções para importar e nomear a tabela de origem.
- `01_D_Produtos.m`: dimensão de produtos e métricas agregadas.
- `02_D_Produtos_Detalhes.m`: detalhes dos produtos.
- `03_D_Descontos.m`: dimensão de descontos.
- `04_D_Detalhes.m`: dimensão complementar de segmento e país.
- `05_F_Vendas.m`: tabela fato de vendas.
- `06_D_Calendario.dax`: criação da dimensão calendário.
- `07_medidas.dax`: medidas DAX básicas.
- `08_VALIDACAO.md`: checklist de validação.
- `diagrama_star_schema.mmd`: código-fonte Mermaid do diagrama.
- `diagrama_star_schema.png` e `diagrama_star_schema.svg`: versões visuais do modelo.
- 
## Etapas de construção

1. Importar o arquivo Financial Sample no Power BI e renomear a consulta/tabela de origem para `Financials_origem`. Manter essa consulta como backup e ocultá-la no relatório/modelo, conforme solicitado pelo enunciado.
2. Criar consultas de referência a partir de `Financials_origem` usando os códigos M deste repositório. Em Power Query, abrir **Página Inicial → Editor Avançado** e colar o conteúdo de cada arquivo em uma consulta separada.
3. Na `D_Produtos`, agrupar por `Product` e calcular média de `Units Sold`, média e mediana de `Sale Price`, além de valores máximo e mínimo de `Sale Price`. O identificador de produto é criado por regra condicional: Carretera=0, Montana=1, Paseo=2, Velo=3, VTT=4, Amarilla=5. Se os rótulos reais forem diferentes, ajustar a regra e validar valores nulos.
4. Criar `D_Produtos_Detalhes`, `D_Descontos` e `D_Detalhes` com base nos atributos previstos no enunciado. Como o documento deixa `D_Detalhes (*)` em aberto, este projeto propõe `Segment` e `Country` como atributos descritivos complementares.
5. Criar `F_Vendas` com uma chave de linha (`SK_ID`), produto, unidades, preço, faixa de desconto, segmento, país, vendas, lucro e data, mais chaves auxiliares necessárias para relacionar com as dimensões.
6. Criar `D_Calendário` com a função DAX `CALENDAR()` e colunas de ano, mês, trimestre, dia e nome do dia da semana.
7. No modo Modelo, verificar chaves únicas nas dimensões e criar relacionamentos de um-para-muitos, com as dimensões filtrando `F_Vendas`. Marcar `D_Calendário` como tabela de datas se essa opção estiver disponível.
8. Conferir totais de vendas, lucro e unidades contra `Financials_origem`, validar contagem de linhas, valores nulos nas chaves e categorias de produto não mapeadas.

## Modelo de dados proposto

A tabela central é `F_Vendas`. As dimensões são `D_Produtos`, `D_Produtos_Detalhes`, `D_Descontos`, `D_Detalhes` e `D_Calendário`. O diagrama incluído é uma proposta lógica; após carregar os dados, é necessário confirmar unicidade das chaves e ajustar relacionamentos no Power BI.

### Relações principais

- `D_Produtos[ID_produto]` (1) → `F_Vendas[ID_Produto]` (*).
- `D_Produtos_Detalhes[SK_Produto_Detalhe]` (1) → `F_Vendas[SK_Produto_Detalhe]` (*).
- `D_Descontos[SK_Desconto]` (1) → `F_Vendas[SK_Desconto]` (*).
- `D_Detalhes[ID_Detalhes]` (1) → `F_Vendas[ID_Detalhes]` (*).
- `D_Calendário[Date]` (1) → `F_Vendas[Date]` (*).

As chaves `SK_Produto_Detalhe`, `SK_Desconto` e `ID_Detalhes` são índices inteiros criados nas consultas para garantir uma chave única para cada combinação de atributos. Por serem gerados no refresh, devem ser reconstruídos junto com as consultas e não usados como identificadores persistentes fora deste modelo.

## Campos e nomes

O enunciado usa `Salers` na lista de campos da fato, mas a planilha Financial Sample padrão costuma chamar a coluna de `Sales`. Os códigos usam `Sales`; se a planilha local realmente usar outro cabeçalho, atualize o código. O documento também escreve `Manufactoring Price` em um ponto; aqui é usado o nome padrão `Manufacturing Price`.

## Funções usadas

- **Power Query M:** `Table.Group`, `Table.SelectColumns`, `Table.Distinct`, `Table.AddColumn`, `Table.AddIndexColumn`, `Table.NestedJoin`, `Table.ExpandTableColumn`, `Table.ReorderColumns` e `Table.TransformColumnTypes`.
- **DAX:** `CALENDAR`, `ADDCOLUMNS`, `YEAR`, `MONTH`, `FORMAT`, `DAY`, `SUM` e `DIVIDE`.

## Validação

O resultado só deve ser marcado como validado depois de executar no Power BI. Checklist sugerido:

- [ ] A consulta `Financials_origem` carrega a planilha sem erros.
- [ ] Todas as seis categorias de produto têm `ID_Produto`; nenhuma linha tem ID nulo.
- [ ] `D_Produtos[ID_produto]`, `D_Produtos_Detalhes[SK_Produto_Detalhe]`, `D_Descontos[SK_Desconto]`, `D_Detalhes[ID_Detalhes]` e `D_Calendário[Date]` são únicos.
- [ ] As contagens de linhas e os totais de vendas/lucro/unidades da fato foram comparados com a origem.
- [ ] O diagrama mostra relacionamentos 1:* das dimensões para `F_Vendas`.
- [ ] O arquivo `.pbix` foi salvo e incluído no repositório, se a ferramenta estiver disponível.

## Entrega

O documento da atividade recomenda salvar o `.pbix`, uma imagem do esquema em estrela e este README com o processo de construção, etapas, funcionalidades e funções DAX. A imagem e a documentação estão preparadas; o `.pbix` e a execução no Power BI seguem pendentes e não são simulados neste pacote.
