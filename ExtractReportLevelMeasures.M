let
    Origen = #"Report Layout",
    #"Otras columnas quitadas" = Table.SelectColumns(Origen,{"ReportName", "config"}),
    #"Added Custom" = Table.AddColumn(#"Otras columnas quitadas", "config json", each Json.Document([config])),
    #"Columnas quitadas" = Table.RemoveColumns(#"Added Custom",{"config"}),
    #"Se expandió config json" = Table.ExpandRecordColumn(#"Columnas quitadas", "config json", {"modelExtensions"}, {"modelExtensions"}),
    #"Se expandió modelExtensions" = Table.ExpandListColumn(#"Se expandió config json", "modelExtensions"),
    #"Se expandió modelExtensions2" = Table.ExpandRecordColumn(#"Se expandió modelExtensions", "modelExtensions", {"entities"}, {"entities"}),
    #"Se expandió entities" = Table.ExpandListColumn(#"Se expandió modelExtensions2", "entities"),
    #"Se expandió entities1" = Table.ExpandRecordColumn(#"Se expandió entities", "entities", {"name", "extends", "measures"}, {"name", "extends", "measures"}),
    #"Se expandió measures" = Table.ExpandListColumn(#"Se expandió entities1", "measures"),
    #"Se expandió measures1" = Table.ExpandRecordColumn(#"Se expandió measures", "measures", {"name", "dataType", "expression", "errorMessage", "hidden", "references", "formulaOverride", "formatInformation"}, {"name.1", "dataType", "expression", "errorMessage", "hidden", "references", "formulaOverride", "formatInformation"}),
    #"Se expandió references" = Table.ExpandRecordColumn(#"Se expandió measures1", "references", {"unrecognizedReferences", "measures"}, {"references.unrecognizedReferences", "references.measures"}),
    #"Se expandió references.measures" = Table.ExpandListColumn(#"Se expandió references", "references.measures"),
    #"Se expandió references.measures1" = Table.ExpandRecordColumn(#"Se expandió references.measures", "references.measures", {"schema", "entity", "name"}, {"schema", "entity", "name.2"}),
    #"Se expandió formatInformation" = Table.ExpandRecordColumn(#"Se expandió references.measures1", "formatInformation", {"formatString", "format", "thousandSeparator", "currencyFormat", "dateTimeCustomFormat"}, {"formatString", "format", "thousandSeparator", "currencyFormat", "dateTimeCustomFormat"})
in
    #"Se expandió formatInformation"
