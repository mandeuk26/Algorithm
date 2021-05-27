import Foundation
let n = Int(readLine()!)!
var arr:[(x:Int, y:Int)] = []
for _ in 1...n {
    let l = readLine()!.split(separator: " ").map{Int($0)!}
    arr.append((x:l[0], y:l[1]))
}
arr.sort(by: {$0.x < $1.x})
print(findMin(start: 0, end: n-1))

func findMin(start:Int, end:Int) -> Int {
    if end - start < 3 {
        var result = 1_000_000_000
        for i in start...end {
            for j in start...i {
                if i == j {continue}
                let xdis = arr[j].x-arr[i].x
                let ydis = arr[j].y-arr[i].y
                result = min(result, xdis*xdis + ydis*ydis)
            }
        }
        return result
    }
    else {
        let d = min(findMin(start: start, end: (start+end)/2-1), findMin(start: (start+end)/2+1, end: end))
        if d == 0 {return 0}
        let sqrtD = Int(sqrt(Double(d))) + 1
        var result = d
        let xdis = arr[(start+end)/2]
        var list:[(x:Int, y:Int)] = []
        //왼쪽구역 list 추가
        for i in 0...(end-start)/2 {
            let idis = arr[(start+end)/2 - i]
            if xdis.x - idis.x >= sqrtD {
                break
            }
            list.append(idis)
        }
        //오른쪽 구역 list 추가
        for i in 1...(end-(start+end)/2) {
            let idis = arr[(start+end)/2 + i]
            if idis.x - xdis.x >= sqrtD {
                break
            }
            list.append(idis)
        }
        //y좌표순으로 정렬 후 거리비교
        list.sort(by: {$0.y < $1.y})
        for i in 0..<list.count {
            for j in i+1..<list.count {
                if list[j].y - list[i].y >= sqrtD {
                    break
                }
                else {
                    let xdis = list[j].x-list[i].x
                    let ydis = list[j].y-list[i].y
                    result = min(result, xdis*xdis + ydis*ydis)
                }
            }
        }
        return result
    }
}

