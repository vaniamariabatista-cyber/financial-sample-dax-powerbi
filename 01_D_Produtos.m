let
    Source = Financials_origem,
    Agrupado = Table.Group(
        Source,
        {"Product"},
        {
            {"Média de Unidades Vendidas", each List.Average(List.RemoveNulls([Units Sold])), type nullable number},
            {"Média do valor de vendas", each List.Average(List.RemoveNulls([Sale Price])), type nullable number},
            {"Mediana do valor de vendas", each List.Median(List.RemoveNulls([Sale Price])), type nullable number},
            {"Valor máximo de Venda", each List.Max(List.RemoveNulls([Sale Price])), type nullable number},
            {"Valor mínimo de Venda", each List.Min(List.RemoveNulls([Sale Price])), type nullable number}
        }
    ),
    ComIDProduto = Table.AddColumn(
        Agrupado,
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
    Reordenado = Table.ReorderColumns(
        ComIDProduto,
        {"ID_produto", "Product", "Média de Unidades Vendidas", "Média do valor de vendas", "Mediana do valor de vendas", "Valor máximo de Venda", "Valor mínimo de Venda"}
    )
in
    Reordenado
