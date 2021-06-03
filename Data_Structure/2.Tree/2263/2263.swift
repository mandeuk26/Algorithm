let n = Int(readLine()!)!
let inorder = readLine()!.split(separator: " ").map{Int(String($0))!}
let postorder = readLine()!.split(separator: " ").map{Int(String($0))!}
var preorder:[String] = []
var inorderDic:[Int:Int] = [:]
inorder.enumerated().forEach {
    inorderDic[$0.element] = $0.offset
}


func orderChange(inorderS: Int, inorderE: Int, postorderS: Int, postorderE: Int) {
    if inorderS > inorderE {
        return
    }
    else {
        let rootNode = postorder[postorderE]
        let rootIndex = inorderDic[rootNode]!
        let postLeftEnd = rootIndex - inorderS + postorderS - 1
        preorder.append(String(rootNode))
        orderChange(inorderS: inorderS, inorderE: rootIndex-1, postorderS: postorderS, postorderE: postLeftEnd)
        orderChange(inorderS: rootIndex+1, inorderE: inorderE, postorderS: postLeftEnd+1, postorderE: postorderE-1)
    }
}

orderChange(inorderS: 0, inorderE: n-1, postorderS: 0, postorderE: n-1)
print(preorder.joined(separator: " "))
