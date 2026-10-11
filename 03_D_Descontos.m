let
    Source = Financials_origem,
    Selecionadas = Table.SelectColumns(Source, {"Product", "Discount", "Discount Band"}),
    ComIDProduto = Table.AddColumn(
        Selecionadas,
        "ID_produto",
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
    Reordenado = Table.ReorderColumns(ComIDProduto, {"ID_produto", "Product", "Discount", "Discount Band"}),
    Distintas = Table.Distinct(Reordenado),
    ComChave = Table.AddIndexColumn(Distintas, "SK_Desconto", 1, 1, Int64.Type),
    Final = Table.ReorderColumns(ComChave, {"SK_Desconto", "ID_produto", "Product", "Discount", "Discount Band"})
in
    Final
