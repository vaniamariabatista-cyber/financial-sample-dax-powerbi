let
    Source = Financials_origem,
    ComIDProduto = Table.AddColumn(
        Source,
        "ID_Produto",
        each
            if [Product] = "Carretera" then 0
            else if [Product] = "Montana" then 1
            else if [Product] = "Paseo" then 2
            else if [Product] = "Velo" then 3
            else if [Product] = "VTT" then 4
            else if [Product] = "Amarilla" then 5
            else null,
        Int64.Type
    ),
    JoinProdutoDetalhe = Table.NestedJoin(
        ComIDProduto,
        {"Product", "Discount Band", "Sale Price", "Units Sold", "Manufacturing Price"},
        D_Produtos_Detalhes,
        {"Product", "Discount Band", "Sale Price", "Units Sold", "Manufacturing Price"},
        "ProdutoDetalhe",
        JoinKind.LeftOuter
    ),
    ExpandProdutoDetalhe = Table.ExpandTableColumn(JoinProdutoDetalhe, "ProdutoDetalhe", {"SK_Produto_Detalhe"}, {"SK_Produto_Detalhe"}),
    JoinDescontos = Table.NestedJoin(
        ExpandProdutoDetalhe,
        {"ID_Produto", "Product", "Discount", "Discount Band"},
        D_Descontos,
        {"ID_produto", "Product", "Discount", "Discount Band"},
        "DescontoDim",
        JoinKind.LeftOuter
    ),
    ExpandDescontos = Table.ExpandTableColumn(JoinDescontos, "DescontoDim", {"SK_Desconto"}, {"SK_Desconto"}),
    JoinDetalhes = Table.NestedJoin(
        ExpandDescontos,
        {"Segment", "Country"},
        D_Detalhes,
        {"Segment", "Country"},
        "DetalhesDim",
        JoinKind.LeftOuter
    ),
    ExpandDetalhes = Table.ExpandTableColumn(JoinDetalhes, "DetalhesDim", {"ID_Detalhes"}, {"ID_Detalhes"}),
    ComSK = Table.AddIndexColumn(ExpandDetalhes, "SK_ID", 1, 1, Int64.Type),
    Renomeadas = Table.RenameColumns(ComSK, {{"Product", "Produto"}, {"Sale Price", "Sales Price"}}),
    Selecionadas = Table.SelectColumns(
        Renomeadas,
        {"SK_ID", "ID_Produto", "SK_Produto_Detalhe", "SK_Desconto", "ID_Detalhes", "Produto", "Units Sold", "Sales Price", "Discount Band", "Segment", "Country", "Sales", "Profit", "Date"}
    ),
    Tipos = Table.TransformColumnTypes(Selecionadas, {{"SK_ID", Int64.Type}, {"ID_Produto", Int64.Type}, {"SK_Produto_Detalhe", Int64.Type}, {"SK_Desconto", Int64.Type}, {"ID_Detalhes", Int64.Type}, {"Date", type date}})
in
    Tipos
