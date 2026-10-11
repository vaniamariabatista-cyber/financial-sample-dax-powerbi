let
    Source = Financials_origem,
    Selecionadas = Table.SelectColumns(Source, {"Product", "Discount Band", "Sale Price", "Units Sold", "Manufacturing Price"}),
    Distintas = Table.Distinct(Selecionadas),
    ComIDProduto = Table.AddColumn(
        Distintas,
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
    ComChave = Table.AddIndexColumn(ComIDProduto, "SK_Produto_Detalhe", 1, 1, Int64.Type),
    Reordenado = Table.ReorderColumns(ComChave, {"SK_Produto_Detalhe", "ID_produto", "Product", "Discount Band", "Sale Price", "Units Sold", "Manufacturing Price"})
in
    Reordenado
