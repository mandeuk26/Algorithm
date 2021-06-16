# 백준 13713 문자열과 쿼리
문자열 S = S<sub>1</sub>S<sub>2</sub>...S<sub>N</sub>이 주어질 때 F(i)는 S와 S<sub>1</sub>S<sub>2</sub>...S<sub>i</sub>의 가장 긴 공통 접미사의 길이로 정의된다.  
S와 i가 주어졌을 때 F(i)를 구하는 문제이다.  
앞에서 배웠던 Z알고리즘을 활용하려고 보니 뭔가 이상하다.  
Z알고리즘은 S<sub>i</sub>~S<sub>N</sub>의 가장 긴 공통 접두사였는데 이번에는 형태가 조금 다르다.  
  
하지만 해법은 간단하다.  
문자열 S를 뒤집어서 S<sub>N</sub>~S<sub>1</sub>의 형태가 된다고 생각하자.  
Z[N-i]은 뒤집힌 S와 S<sub>i</sub>~S<sub>1</sub>의 가장 긴 공통 접두사의 길이 로 정의된다.  
이는 우리가 구하고자 했던 S와 S<sub>1</sub>~S<sub>i</sub>의 공통 접미사 길이와 같다.  
따라서 문자열을 뒤집어서 Z알고리즘을 적용시킨 후에 다시한번 뒤집어서 출력해주면 되는 문제이다.  
  
파일의 입력이 크기때문에 fread를 해줘야 시간초과가 안난다. 관련 코드는 JCSooHwanCho님의 FileIO.swift 를 참조하였다.
<출처 : https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88>
