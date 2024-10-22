library(tidyverse)
library(readxl)

# 폴더 경로 지정
fpath <- "~/Quant/fsdata/yearly/"

# 폴더 내 모든 파일 리스트
flist <- list.files(path = fpath, full.names=TRUE)

# 파일 내 시트 이름 가져오기
file_path <- flist[1]
sheets <- excel_sheets(file_path)
# [1] "info"       "Data_bs"    "Labels_bs" 
# [4] "Data_cis"   "Labels_cis" "Data_cf"   
# [7] "Labels_cf"


# 모든 시트의 데이터를 리스트로 불러오기
all_sheets <- lapply(sheets, function(sheet) {
  read_excel(file_path, sheet=sheet)
})

# 시트이름을 리스트의 이름으로 저장
names(all_sheets) <- sheets


df_info <- all_sheets["info"] %>% data.frame()
df_bs <- all_sheets["Data_bs"] %>% data.frame()
df_cis <- all_sheets["Data_cis"] %>% data.frame()
df_cf <- all_sheets["Data_cf"] %>% data.frame()

View(df_bs)

write.csv(df_bs, "./sample/df_bs.csv", row.names = FALSE)
write.csv(df_cis, "./sample/df_cis.csv", row.names = FALSE)
write.csv(df_cf, "./sample/df_cf.csv", row.names = FALSE)


# wide form으로 변환
library(tidyr)
library(dplyr)

df_bs <- read.csv('./sample/df_bs.csv')
df_bs %>% dim() # [1] 45 16

# 결측값 제거
df_cleaned <- df_bs %>%
  filter(!is.na(`Data_bs....3`)) %>%  # label_ko에 해당하는 열에서 결측값 제거
  select(`Data_bs....3`, matches("^Data_bs\\.\\d{8}$"))  # 필요한 열만 선택


df_long <- df_cleaned %>% 
  pivot_longer(cols = matches("^Data_bs\\.\\d{8}$"), names_to="year", values_to = "value")


df_wide <- df_long %>% 
  pivot_wider(names_from = `Data_bs....3`, values_from = value)


View(df_wide)

df_wide %>% dim() # [1]  8 45
df_wide %>% head()

df_wide <- df_wide %>% select(-label_ko)

df_wide %>% dim() # [1]  8 44


