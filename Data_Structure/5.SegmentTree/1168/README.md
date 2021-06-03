# 백준 1168 요세푸스 문제 2
deque 파트에서 다루었던 요세푸스 문제의 심화 파트이다. 시간 제한이 단축되었기 때문에 기존의 deque를 사용하면 시간 초과가 뜨게된다. 만약 우리가 7명의 사람이 있을 때 k=3에 대한 요세푸스를 구한다 생각해보자. 7명의 사람을 각각 배열의 1번부터 7번이라고 하고 원소값을 1을 줘보자. 여기서 1의 의미는 사람이 현재 자리에 앉아있다는 의미이다. 만약 k번째 사람을 골라서 빼낸다면 해당 원소값을 0으로 바꿔버리면 된다. 이렇게 바꾸고 보니 현재 위치한 index로부터 구간합이 k인 지점을 찾는 문제로 바꿀 수 있었다.  
  
그렇다면 구간합에 대한 문제이고 배열 값의 update가 일어나므로 세그먼트 트리나 펜윅 트리를 사용할 수 있겠다. 여기서는 펜윅 트리를 활용하여 문제를 풀었다. 이 때 요세푸스의 핵심은 원으로 되어있어서 처음으로 돌아갈 수 있다는 것이다. 따라서 k번째를 찾을 때 현재 위치부터 end까지의 구간합이 k보다 작다면 다시 start부터 end까지 중 `k - (현재 index~end의 구간합)`의 구간합을 갖는 위치를 찾아주면 된다.  
  
하지만 구간합이 k인 지점을 찾는 문제는 현재 지점으로부터 하나씩 index를 증가시켜가면서 그 차이를 구하게 되면 매번 *O(nlogn)* 의 시간이 소요될 것이다. 따라서 이분탐색의 lower bound를 활용하여 시작 지점과 끝 지점을 지정해주고 해당 범위내에서 구간합이 k가 나오는 lower bound를 찾아주면 (logn)<sup>2</sup> 만에 결과를 얻어낼 수 있다.
```swift
func findKth(tree: [Int], start: Int, end: Int, k: Int) -> Int {
    let rst1 = fenwickFind(tree: tree, index: start-1)
    let rst2 = fenwickFind(tree: tree, index: end)
    
    if rst2-rst1 >= k { 
    //end까지의 구간합이 k보다 클 경우
        var s = start, e = end+1
        while s < e {
            let mid = (s+e)/2
            if fenwickFind(tree: tree, index: mid)-rst1 >= k {
                e = mid
            }
            else {
                s = mid+1
            }
        }
        return e
        //lower bound를 통한 구간합 k인 지점 찾기
    }
    else { 
        return findKth(tree: tree, start: 1, end: n, k: k-rst2+rst1)
        //end까지의 구간합이 k보다 작을 경우, 처음으로 돌아가서 다시 구해준다.
    }
}
```
