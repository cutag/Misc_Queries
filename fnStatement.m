let
    fnStatement = (Desc) =>
        let
            statement =
                {
                {"FP", "Financial Position"},
                {"IS", "Income Statement"},
                {"E1", "Changes in Equity"}
                },
            StatCln1 = List.First(List.Select(statement, each _{0}=Text.Range(Desc,0,2))){1},
            LineCln1 = Text.Range(Desc,2,Text.PositionOf(Desc, "_", Occurrence.Last) - 2),
            DescCln1 = Text.Range(Desc, Text.PositionOf(Desc, "_", Occurrence.Last) + 1, Text.PositionOf(Desc, "=", Occurrence.Last) - Text.PositionOf(Desc, "_", Occurrence.Last) - 1),
            ValueCln1 = Text.Range(Desc, Text.PositionOf(Desc, "=", Occurrence.Last) + 1),

            info = if List.Contains(List.Combine(statement),Text.Range(Desc,0,2)) then
                [Statement = StatCln1,
                Line = LineCln1,
                Description = DescCln1,
                Value = ValueCln1]
            else if List.Contains({"S2", "S6", "SL", "DL"}, Text.Range(Desc, 0, 2)) then
                [Statement = Text.Range(Desc, 0, 2),
                Line = try Text.Range(Desc,3,Text.PositionOf(Desc, "_", Occurrence.Last) - 3) otherwise "",
                Description = DescCln1,
                Value = ValueCln1]
            else if List.Contains({"CapRW"}, Text.Range(Desc, 0, 5)) then
                [Statement = Text.Range(Desc, 0, 5),
                Line = try Text.Range(Desc,6,Text.PositionOf(Desc, "_", Occurrence.Last) - 6) otherwise "",
                Description = DescCln1,
                Value = ValueCln1]
            else if Text.Range(Desc, 0 , 2) = "E9" then
                [Statement = "Statement of Changes in Equity",
                Line = Text.Range(Desc,1,Text.PositionOf(Desc, "_", Occurrence.Last) - 1),
                Description = DescCln1,
                Value = ValueCln1]
            else if Text.Contains(Desc, "LnLeaseRecCRRisk") then
                [Statement = "Loan & Lease Receivables Credit Risk - Concentrations",
                Line = Text.Range(Desc,17,Text.PositionOf(Desc, "_", Occurrence.Last) - 17),
                Description = DescCln1,
                Value = ValueCln1]
            else if Text.Range(Desc, 0, 4) = "FUND" then
                [Statement = "Funding",
                Line = Text.Range(Desc,5,Text.PositionOf(Desc, "_", Occurrence.Last) - 5),
                Description = DescCln1,
                Value = ValueCln1]
            else if List.Contains({"NCCF", "NSFR"}, Text.Range(Desc, 0, 4)) then
                [Statement = Text.Range(Desc, 0, 4),
                Line = Text.Range(Desc, 5, 6),
                Description = DescCln1,
                Value = ValueCln1]
            else if Text.Contains(Desc, "InvCRRisk") then
                [Statement = "Investment Credit Risk",
                Line = Text.Range(Desc,10,Text.PositionOf(Desc, "_", Occurrence.Last) - 10),
                Description = DescCln1,
                Value = ValueCln1]
            else
                "Remove"
        in
            info
in
    fnStatement
