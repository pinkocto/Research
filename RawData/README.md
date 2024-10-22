## 기업개황
> DART 에서 수집 (2024.10.21)
> <https://dart.fss.or.kr/dsae001/main.do>

전자공시 시스템에 등록되어 있는 유가증권 상장법인, 코스닥 상장법인, 코넥스 상장법인, 기타법인
(외감대상 비상장법인 등) 등 회사의 범인유형에 대한 데이터 셋.
- `RawData/corp_overview/20241021/kospi_20241021.csv`
- `RawData/corp_overview/20241021/kosdaq_20241021.csv`
- `RawData/corp_overview/20241021/konex_20241021.csv`
- `RawData/corp_overview/20241021/other_corp_20241021.csv`

|법인유형||
|:------:|:------:|
|유가증권시장|$845$ (건)|
|코스닥시장|$1755$ (건)|
|코넥스시장|$120$ (건)|
|기타법인|$106008$ (건)|
|(합계)|$108728$ (건)|



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