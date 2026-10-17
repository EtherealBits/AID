-- Query 1
WITH MEMBER [Measures].[Ratio] AS
  ([Measures].[gdp_per_capita], [Country].[Country].[Portugal]) / ([Measures].[gdp_per_capita], [Country].[Country].[Spain])
SELECT [Measures].[Ratio] ON COLUMNS,
  FILTER([Time].[Decade].Members, CInt([Time].[Decade].CurrentMember.Name) >= 1960 AND CInt([Time].[Decade].CurrentMember.Name) <= 2020) ON ROWS
FROM [Virtual Cube]

-- Query 2
WITH MEMBER [Measures].[value_added_pct_gdp.] AS
  CASE
    WHEN
      [Sector].[Sector Hierarchy].CurrentMember IS [Sector].[Broad Sector]
    THEN
      SUM([Sector].[Sector Hierarchy].CurrentMember.CHILDREN, [Measures].[value_added_pct_gdp])
  ELSE
    [Measures].[value_added_pct_gdp]
  END
SELECT {([Time].[Year].[1995]), [Time].[Year].[2020]} ON COLUMNS,
  [Country].[Country].[Portugal] * DESCENDANTS([Sector].[Broad Sector].Members, [Sector].[Sector], SELF_AND_BEFORE) ON ROWS
FROM [Virtual Cube]
WHERE [Measures].[value_added_pct_gdp.]
