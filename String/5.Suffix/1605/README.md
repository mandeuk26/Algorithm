# 백준 1605 반복 부분문자열
길이 L의 문자열이 주어지면 이 문자열의 부분문자열 중 적어도 한 번은 반복되는 부분문자열을 반복 부분문자열이라고 부르기로 했을 때 가장 긴 반복 부분문자열의 길이를 구하는 문제이다.  
  
반복 부분문자열은 결국에는 suffix array상에서 가장 가까운 두 suffix 문자열이 갖는 접두사의 길이와 같다는 것을 알아야한다.  
A라는 반복 부분문자열이 존재하고 가장 길다고 했을 때, A라는 부분 문자열을 맨앞에 포함하는 두 suffix는 suffix array상에서 인접할 수밖에 없다.  
  
예를들어 문자열 aabcaabcd가 존재한다고 했을 때.  
- aabcd  
- aabcaabcd  

두 suffix는 suffix array상에서 바로 옆에 위치한다.  
  
문제가 어려워보였지만 결국에는 LCP를 구하는 문제로 바꿔볼 수 있다.  
최종적으로는 LCP값 중에서 최댓값을 구하면 되는 문제이다.  
