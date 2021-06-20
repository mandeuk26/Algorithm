func calc(a: CLongLong, b: CLongLong) -> CLongLong {
    var r1 = a, r2 = b, s1:CLongLong = 1, s2:CLongLong = 0, t1:CLongLong = 0, t2:CLongLong = 1
    while r2 != 0 {
        let q = r1/r2
        let r = r1-q*r2, s = s1-q*s2, t = t1-q*t2
        r1 = r2
        s1 = s2
        t1 = t2
        r2 = r
        s2 = s
        t2 = t
    }
    t1 = (t1%a + a) % a
    if r1 != 1 || t1 > 1_000_000_000 {
        return -1
    }
    return t1
}

let t = Int(readLine()!)!
let MAX:CLongLong = 1_000_000_000
for _ in 0..<t {
    let kc = readLine()!.split(separator: " ").map{CLongLong(String($0))!}
    let k = kc[0], c = kc[1]
    let result = calc(a: k, b: c)
    if c == 1 {
        if k+1 <= MAX {
            print(k+1)
        }
        else {
            print("IMPOSSIBLE")
        }
    }
    else if k == 1 {
        print(1)
    }
    else if result != -1 {
        print(result)
    }
    else {
        print("IMPOSSIBLE")
    }
}

