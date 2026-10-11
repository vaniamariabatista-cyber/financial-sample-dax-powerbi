let
    // Proposta para o D_Detalhes, pois o enunciado marca esta tabela como (*) e pede avaliar
    // os atributos ainda não contemplados nas demais dimensões. Segment e Country são usados aqui.
    Source = Financials_origem,
    Selecionadas = Table.SelectColumns(Source, {"Segment", "Country"}),
    Distintas = Table.Distinct(Selecionadas),
    ComChave = Table.AddIndexColumn(Distintas, "ID_Detalhes", 1, 1, Int64.Type),
    Reordenado = Table.ReorderColumns(ComChave, {"ID_Detalhes", "Segment", "Country"})
in
    Reordenado
