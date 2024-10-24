

`-` ***Data Description***

|Dataset|Description|
|:-----:|:----------:|
|`corp_info_df_20241021.csv`|DART에 공시된 모든 기업들에 관한 기본 정보에 대한 데이터 (sector 포함)|
|`corp_overview_all_20241021.csv`|전체기업개황정보 (코스피, 코스닥, 코넥스, 기타법인)|
|`df_sheet7.csv`|시트정보에 대한 데이터 (시트 개수=7)|
|`df_sheet9.csv`|시트정보에 대한 데이터 (시트 개수=9)|
|`df_sheet_all.csv`|시트정보 통합 (df_sheet7 + df_sheet9)|
|`merged_df`|통합 데이터 업로드 (stock code, sector, market type, sheet정보 포함)|


`-` num_sheets=7
> [`info`, `Data_bs, Labels_bs`, `Data_cis`, `Labels_cis`, `Data_cf`, `Labels_cf`]

|True|False|Total|
|:----:|:----:|:-----:|
|$1962$|$11$|$1973$|

*False의 경우 cis대신 is로 되어있다.* (포괄손익계산서 대신 손익계산서)

`-` num_sheets=9
> [`info`, `Data_bs`, `Labels_bs`, `Data_is`, `Labels_is`, `Data_cis`, `Labels_cis`, `Data_cf`, `Labels_cf`]

|True|False|Total|
|:----:|:-----:|:-------:|
|$215$|$0$|$215$|