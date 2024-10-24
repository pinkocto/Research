library(tidyverse)
library(readxl)

# 폴더 경로 지정
fpath <- "~/Quant/fsdata/yearly/"

# 폴더 내 모든 파일 리스트
flist <- list.files(path = fpath, full.names=TRUE)

# 파일 내 시트 이름 가져오기
file_path <- flist[1] # 동화약품 (코스피)
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

# write.csv(df_bs, "./sample/df_bs.csv", row.names = FALSE)
# write.csv(df_cis, "./sample/df_cis.csv", row.names = FALSE)
# write.csv(df_cf, "./sample/df_cf.csv", row.names = FALSE)


# wide form으로 변환
library(tidyr)
library(dplyr)

df_bs <- read.csv('./sample/df_bs.csv')
df_bs %>% dim() # [1] 45 16
df_cis %>% dim() # [1] 30 16
df_cf %>% dim() # [1] 91 16

# 결측값 제거
df_cleaned <- df_bs %>%
  filter(!is.na(`Data_bs....3`)) %>%  # label_ko에 해당하는 열에서 결측값 제거
  select(`Data_bs....3`, matches("^Data_bs\\.\\d{8}$"))  # 필요한 열만 선택

# long form으로 변환
df_long <- df_cleaned %>% 
  pivot_longer(cols = matches("^Data_bs\\.\\d{8}$"), names_to="year", values_to = "value")

# wide form으로 변환
df_wide <- df_long %>% 
  pivot_wider(names_from = `Data_bs....3`, values_from = value)


View(df_wide)

df_wide %>% dim() # [1]  8 45
df_wide %>% head()

df_wide <- df_wide %>% select(-label_ko)

df_wide %>% dim() # [1]  8 44


#==============================================================
#
# 1. Balance Sheet
#
#==============================================================

library(tidyverse)
library(readxl)

library(tidyverse)
library(readxl)


# 폴더 경로 지정
fpath <- "~/Quant/fsdata/yearly/"

# 폴더 내 모든 파일 리스트
flist <- list.files(path = fpath, full.names=TRUE)

# 파일 내 시트 이름 가져오기
file_path <- flist[1] # 동화약품 (코스피)
sheets <- excel_sheets(file_path) # 시트이름
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


# 데이터를 처리하는 함수 정의
process_data <- function(file_path, df_sheet){
  df_cleaned <- df_bs %>% 
    filter(!is.na(`Data_bs....3`)) %>%  # label_ko에 해당하는 열에서 결측값 제거
    select(`Data_bs....3`, matches("^Data_bs\\.\\d{8}$")) %>% # 필요한 열만 선택
    filter(!(`Data_bs....3` == "label_ko"))
  
  # long form으로 변환
  df_long <- df_cleaned %>% 
    pivot_longer(cols = matches("^Data_bs\\.\\d{8}$"), names_to="year", values_to = "value")
  
  # wide form으로 변환
  df_wide <- df_long %>% 
    pivot_wider(names_from = `Data_bs....3`, values_from = value) %>% 
    mutate(year = str_replace(year, "Data_bs\\.", ""))
  
  return(df_wide)
}
    
df_wide_bs <- process_data(file_path, df_bs)
View(df_wide_bs)
  

df_wide_bs %>% dim() # [1]  8 44




#==============================================================
#
# 2. Comprehensive Income Statement
#
#==============================================================
# 폴더 경로 지정
fpath <- "~/Quant/fsdata/yearly/"

# 폴더 내 모든 파일 리스트
flist <- list.files(path = fpath, full.names=TRUE)

# 파일 내 시트 이름 가져오기
file_path <- flist[1] # 동화약품 (코스피)
sheets <- excel_sheets(file_path) # 시트이름
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

df_cis %>% head()

# df_cleaned_bs <- df_bs %>% 
#   filter(!is.na(`Data_bs....3`)) %>%  # label_ko에 해당하는 열에서 결측값 제거
#   select(`Data_bs....3`, matches("^Data_bs\\.\\d{8}$")) %>% # 필요한 열만 선택
#   filter(!(`Data_bs....3` == "label_ko"))
# 
# View(df_cleaned_bs)

df_cleaned_cis <- df_cis %>% 
  filter(!is.na(`Data_cis....3`)) %>%  # label_ko에 해당하는 열에서 결측값 제거
  select(`Data_cis....3`, matches("^Data_cis\\.\\d{8}\\.\\d{8}$")) %>%  # 필요한 열만 선택
  filter(!(`Data_cis....3` == "label_ko"))
  
# View(df_cleaned_cis)


View(df_cleaned_cis)

View(df_cleaned_cis %>% 
  pivot_longer(cols = matches("^Data_cis\\.\\d{8}\\.\\d{8}$"), names_to = "year", values_to = "value") %>% 
  mutate(year = str_replace(year, "Data_cis\\.", "")) %>%  # "Data_cis." 제거
  mutate(year = str_replace(year, "\\..*", "")) %>%  # 연도 뒤의 부분 제거
  pivot_wider(names_from = `Data_cis....3`, values_from = value))

# 데이터를 처리하는 함수 정의
process_data_cis <- function(file_path, df_sheet){
  df_cleaned <- df_sheet %>% 
    filter(!is.na(`Data_cis....3`)) %>%  # label_ko에 해당하는 열에서 결측값 제거
    select(`Data_cis....3`, matches("^Data_cis\\.\\d{8}\\.\\d{8}$")) %>%  # 필요한 열만 선택
    filter(!(`Data_cis....3` == "label_ko"))
  
  # long form으로 변환
  df_long <- df_cleaned %>% 
     pivot_longer(cols = matches("^Data_cis\\.\\d{8}\\.\\d{8}$"), names_to = "year", values_to = "value")
  
  # wide form으로 변환
  df_wide <- df_long %>% 
    pivot_wider(names_from = `Data_cis....3`, values_from = value) %>% 
    select(-label_ko) %>% 
    mutate(year = str_replace(year, "Data_cis\\.", ""))
  
  return(df_wide)
}


df_wide_cis <- process_data_cis(file_path, df_cis)




View(df_cis)


#==============================================================
#
# 3. Cash Flow Statement
#
#==============================================================

library(tidyverse)
library(readxl)

library(tidyverse)
library(readxl)


# 폴더 경로 지정
fpath <- "~/Quant/fsdata/yearly/"

# 폴더 내 모든 파일 리스트
flist <- list.files(path = fpath, full.names=TRUE)

# 파일 내 시트 이름 가져오기
file_path <- flist[1] # 동화약품 (코스피)
sheets <- excel_sheets(file_path) # 시트이름
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

df_cf %>% head()

# 데이터를 처리하는 함수 정의
process_data_cf <- function(file_path, df_sheet){
  df_cleaned <- df_sheet %>% 
    filter(!is.na(`Data_cf....3`)) %>%  # label_ko에 해당하는 열에서 결측값 제거
    select(`Data_cf....3`, matches("^Data_cf\\.\\d{8}.\\d{8}$")) %>% # 필요한 열만 선택
    filter(!(`Data_cf....3` == "label_ko" ))
  
  # long form으로 변환
  df_long <- df_cleaned %>% 
    pivot_longer(cols = matches("^Data_cf\\.\\d{8}.\\d{8}$"), names_to="year", values_to = "value")
  
  # wide form으로 변환
  df_wide <- df_long %>% 
    pivot_wider(names_from = `Data_cf....3`, values_from = value) %>% 
    mutate(year = str_replace(year, "Data_cf\\.", ""))
  
  return(df_wide)
}

df_wide_cf <- process_data_cf(file_path, df_cf)
View(df_wide_cf)


df_wide_cf %>% dim() # [1]  8 90


