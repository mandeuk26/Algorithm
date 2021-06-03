struct DisjointSet {
    var nameToInt:[String:Int] = [:]
    var arr:[Int] = []
    var memberCount:[Int] = []
    func nodeNumber(_ str: String) -> Int {
        guard let tmp = nameToInt[str] else {
            return -1
        }
        return tmp
    }
    mutating func insert(_ str: String) -> Int {
        let count = arr.count
        arr.append(count)
        memberCount.append(1)
        nameToInt[str] = count
        return count
    }
    mutating func findRoot(_ n: Int) -> Int {
        if arr[n] == n {
            return n
        }
        else {
            let root = findRoot(arr[n])
            arr[n] = root
            return root
        }
    }
    mutating func union(_ a: Int, _ b: Int) -> Int {
        let rootA = findRoot(a), rootB = findRoot(b)
        if rootA < rootB {
            arr[rootB] = rootA
            memberCount[rootA] += memberCount[rootB]
            return memberCount[rootA]
        }
        else if rootA > rootB{
            arr[rootA] = rootB
            memberCount[rootB] += memberCount[rootA]
            return memberCount[rootB]
        }
        else {
            return memberCount[rootA]
        }
    }
}

let testcase = Int(readLine()!)!
var str = ""
for _ in 1...testcase {
    let n = Int(readLine()!)!
    var disjointSet = DisjointSet()
    for _ in 1...n {
        let relation = readLine()!.split(separator: " ").map{String($0)}
        let person1 = relation[0], person2 = relation[1]
        var number1 = disjointSet.nodeNumber(person1)
        var number2 = disjointSet.nodeNumber(person2)
        if number1 == -1 {
            number1 = disjointSet.insert(person1)
        }
        if number2 == -1 {
            number2 = disjointSet.insert(person2)
        }
        str += "\(disjointSet.union(number1, number2))\n"
    }
}
print(str)

