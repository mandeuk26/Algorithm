func maketrie(str: [String], trie: inout [Dictionary<String, Int>], check: inout [Bool]) {
    var node = 0
    for i in 1...Int(str[0])! {
        let tmp = str[i]
        if trie[node][tmp] == nil {
            trie[node][tmp] = trie.count
            node = trie.count
            trie.append(Dictionary<String, Int>())
            check.append(false)
        }
        else {
            node = trie[node][tmp]!
        }
    }
    check[node] = true
}

func dfs(d: Int, n: Int, arr: [Dictionary<String, Int>]) -> String {
    var str = ""
    for i in arr[n].sorted(by: {$0.key < $1.key}) {
        for _ in 0..<d {
            str += "--"
        }
        str += "\(i.key)\n"
        str += dfs(d: d+1, n: i.value, arr: arr)
    }
    return str
}

var trie = Array(repeating: Dictionary<String, Int>(), count: 1)
var check = Array(repeating: false, count: 1)
let n = Int(readLine()!)!
for _ in 1...n {
    let line = readLine()!.split(separator: " ").map{String($0)}
    maketrie(str: line, trie: &trie, check: &check)
}
print(dfs(d: 0, n: 0, arr: trie))
