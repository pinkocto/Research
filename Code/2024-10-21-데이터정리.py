# 데이터 정리 (1차)

import dart_fss as dart
import pandas as pd
import numpy as np
import os

# Open DART API KEY 설정
api_key = 'ed47f5802f82825045bac48008cf29218d783968'
dart.set_api_key(api_key = api_key)

# DART에 공시된 회사 리스트 불러오기
corp_list = dart.get_corp_list()

len(corp_list) # 108722 (2024.10.21 기준)

import numpy as np

corp_info = []

# 각 회사의 정보를 추출해서 리스트에 추가
for corp in corp_list:
    corp_info.append({
        'corp_code': getattr(corp, 'corp_code', np.nan), # corp_code가 없으면 NaN 처리
        'corp_name': getattr(corp, 'corp_name', np.nan), # corp_name이 없으면 NaN 처리
        'stock_code': getattr(corp, 'stock_code', np.nan), # stock_code가 없으면 NaN 처리
        'modify_date': getattr(corp, 'modify_date', np.nan), # modify_date가 없으면 NaN 처리
        'sector': getattr(corp, 'sector', np.nan),   # sector가 없으면 NaN 처리
        'product': getattr(corp, 'product', np.nan), # product가 없으면 NaN 처리
        'corp_cls': getattr(corp, 'corp_cls', np.nan) # corp_cls가 없으면 NaN 처리
    })

corp_info_df = pd.DataFrame(corp_info)

corp_info_df

import os

# folder path
fpath = '/home/jy/Desktop/Research/OpenDart/corp_info'

if not os.path.exists(fpath):
    os.makedirs(fpath)
    print(f"`{fpath}` 폴더를 생성했습니다.")
else:
    print(f"`{fpath}` 폴더가 이미 존재합니다.")

# dart에 공시된 모든 회사 정보 저장
corp_info_df.to_csv(os.path.join(fpath, 'corp_info_df_20241021.csv'), index=False)

corp_info_df.head()

corp_info_df.columns

corp_info_df.columns

corp_info_df.shape