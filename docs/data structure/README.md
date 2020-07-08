# Itroduction
----------------------- 

Swift와 함께 자료구조에 대한 개념 및 종류에 대해서 살펴봅니다.


주요 강좌 및 개념
-----------------------  

* [Data Structure Introduction](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20Introduction.pdf)

> 자료구조의 주요 개요을 설명하고 자료구조의 목적과 분류에 대해서 살펴봅니다.

* [Array](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Array.pdf)

> 자료구조에서 가장 기본이 되는 구조는 배열(리스트)입니다.

```swift
class Node<T> {
    fileprivate var data:T
    
    init(_ data: T) {
        self.data = data
    }
}

class ArrayList<T> {
    private var size:Int
    private var list:[Node<T>]
    
    init(size:Int) {
        self.list = [Node<T>]()
        self.size = size
    }
    
    func insert(item:T) {
        if self.list.count < size {
            self.list.append(Node<T>(item))
        }
    }
    
    func remove(at:Int) {
        if self.list.count <= 0 { return }
        if self.list.count <= at { return }
        
        self.list.remove(at: at)
    }
    
    func removeAll() {
        self.list.removeAll()
    }
    
    func get(index:Int) -> T {
        return self.list[index].data
    }
    
    func count() -> Int {
        size = list.count
        
        return size
    }
}
```

* [Stack](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Stack.pdf)

> 스택은 리스트의 한쪽 끝에서 자료의 삽입과 삭제가 이루어지는 자료구조입니다.(LIFO)

```swift
class Stack<T> {
    private var elements = Array<T>()
    public init() {}
    
    public func push(element: T) {
        self.elements.append(element)
    }
    
    public func pop() -> T? {
        return self.elements.popLast()
    }
    
    public func peek() -> T? {
        return self.elements.last
    }
    
    public var isEmpty: Bool {
        return self.elements.isEmpty
    }
    
    public var count: Int {
        return self.elements.count
    }
}

public struct ArrayIterator<T> : IteratorProtocol {
    var currentElement: [T]
    init(elements: [T]) {
        self.currentElement = elements
    }
    
    public mutating func next() -> T? {
        if !self.currentElement.isEmpty {
            return self.currentElement.popLast()
        }
        return nil
    }
}
 
extension Stack : Sequence {
    public func makeIterator() -> ArrayIterator<T> {
        return ArrayIterator<T>(elements: self.elements)
    }
}

```

* [Queue](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Queue.pdf)

> 큐는 한쪽에서는 추가, 다른 한쪽에서는 삭제가 이루어지는 구조입니다.(FIFO)


```swift
class Queue<T> {
    internal var array = Array<T>()
    public init() {}
    
    public func enqueue(_ element: T) {
        array.append(element)
    }
    
    public func dequeue() -> T? {
        return array.removeFirst()
    }
    
    public func peek() -> T? {
        return array.first
    }
    
    public func removeAll() {
        array.removeAll()
    }
}

extension Queue {
    public var count: Int {
        return array.count
    }
    
    public var capacity: Int {
        get { return array.capacity }
        set { array.reserveCapacity(newValue) }
    }
    
    public func isFull() -> Bool {
        return count == array.capacity
    }
    
    public func isEmpty() -> Bool {
        return array.isEmpty
    }
}

public struct QueueIterator<T> : IteratorProtocol {
    var currentElement: [T]
    
    public mutating func next() -> T? {
        if !self.currentElement.isEmpty {
            return currentElement.removeFirst()
        }else {
            return nil
        }
    }
}
 
extension Queue : Sequence {
    public func makeIterator() -> QueueIterator<T> {
        return QueueIterator(currentElement: self.array)
    }
}
```

* [Linked List](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Linked%20List.pdf)

> 링크드 리스트(Linked List)는 순차적으로 모인 데이터의 모음으로서 다음 차례의 노드 주소를 가지고 있는 형태를 가집니다.
>
> 가지고 있는 노드의 주소 형태에 따라서 아래의 두 가지 유형을 나타낼 수 있습니다.
>
> * Singly Linked List :
> 다음 노드(Next Node)의 주소만 가지는 리스트
>
> * Double Linked List :
> 다음 노드 및 이전 노드(Previous Node)의 주소를 가지는 리스트

```swift
class LinkedListNode<T> {
    var value: T
    
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    typealias Node = LinkedListNode<T>
    
    private var head: Node?
    private var tail: Node?
    
    public init() {
        head = nil
        tail = nil
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        return tail
    }
    
    public func node(at index: Int) -> Node? {
        if index >= 0 {
          var node = head
          var i = index
          while node != nil {
            if i == 0 { return node }
            i -= 1
            node = node!.next
          }
        }
        
        return nil
    }
    
    public func insert(_ value: T) {
        let newNode = Node(value: value)
        
        if let tailNode = tail {
          newNode.previous = tailNode
          tailNode.next = newNode
        } else {
          head = newNode
        }
        
        tail = newNode
    }

    public func insert(_ node: Node, at index: Int) {
        if index == 0,
            tail == nil {
            head = node
            tail = node
        } else {
            guard let nodeAtIndex = self.node(at: index) else {
                print("Index out of bounds.")
                return
            }
            
            if nodeAtIndex.previous == nil {
                head = node
            }
            
            node.previous = nodeAtIndex.previous
            nodeAtIndex.previous?.next = node
        
            node.next = nodeAtIndex
            nodeAtIndex.previous = node
        }
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    public func removeLast() -> T {
        return remove(node: last!)
    }
    
    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
    
    public func count() -> Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        
        return count
    }
    
    public var toString : String {
       var s = "["
       var node = head
       while node != nil {
           s += "\(node!.value)"
           node = node!.next
           if node != nil { s += ", " }
       }
       return s + "]"
    }
    
    struct LinkedListIterator : IteratorProtocol {
        let linkedList: LinkedList
        var current: Node?

        init(_ linkedList: LinkedList) {
            self.linkedList = linkedList
            self.current = linkedList.head
        }

        mutating func next() -> Node? {
            guard let thisCurrent = current else { return nil }
            current = thisCurrent.next
            return thisCurrent
        }
    }
}

extension LinkedList : Sequence {
    func makeIterator() -> LinkedListIterator {
        return LinkedListIterator(self)
    }
}
```

* [Dequeue](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Dequeue.pdf)

> 데크(Dequeue)는 Doubly-ended Queue의 약자로서 양쪽 끝에서 추가, 삭제가 가능한 선형 구조 형태의 자료구조입니다.

```swift
class Dequeue<T> {
    private var array = [T]()
 
    public init() {}
 
    public func enqueue(_ element: T) {
        array.append(element)
    }
 
    public func enqueueFront(_ element: T) {
        array.insert(element, at: 0)
    }
 
    public func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
 
    public func dequeueBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }

    public func removeAll() {
        array.removeAll()
    }
}

extension Dequeue {
    public func peekFront() -> T? {
        return array.first
    }
 
    public func peekBack() -> T? {
        return array.last
    }
    
    public var count: Int {
        return array.count
    }

    public var isEmpty: Bool {
        return array.isEmpty
    }
}

public struct DequeueIterator<T> : IteratorProtocol {
    var currentElement: [T]
    
    public mutating func next() -> T? {
        if !self.currentElement.isEmpty {
            return currentElement.removeFirst()
        }else {
            return nil
        }
    }
}
 
extension Dequeue : Sequence {
    public func makeIterator() -> DequeueIterator<T> {
        return DequeueIterator(currentElement: self.array)
    }
}
```

* [Tree](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Tree.pdf)

> 트리(Tree)는 일종의 계층적 자료구조(Hierarchical Data Structure)로서 부모 노드 하단에 자식 노드들을 연결하여 구성되는 형태의 자료구조입니다.

```swift
public class Tree<T> {
    public var value: T

    public weak var parent: Tree?
    public var children = [Tree<T>]()

    public init(_ value: T) {
        self.value = value
    }

    public func addChild(_ node: Tree<T>) {
        children.append(node)
        node.parent = self
    }
}

extension Tree where T: Equatable {
    public func search(_ value: T) -> Tree? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }
}

extension Tree : CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
        }
        return s
    }
}
```

* [Heap](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Heap.pdf)

> 힙(Heap)는 일종의 이진 트리(Tree)를 단일 배열을 이용하여 구현한 구조 가지는 자료구조로서 여러개의 값들 중에서 가장 큰 값이나 가장 작은 값을 빠르게 찾아내도록 하기위해서 만들어진 자료구조입니다.

```swift
class Heap<Element : Comparable> {
    
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1){
                siftDown(from: i)
            }
        }
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        return 2*index + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        return 2*index + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
}

extension Heap {
    func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
        
    }
    
    func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        return elements.removeLast()
    }
    
    func remove(at index: Int) -> Element? {
        guard index < elements.count else {  return nil }
        
        if index == elements.count - 1 {
            return elements.removeLast()
        }else {
            elements.swapAt(index, elements.count-1)
            siftDown(from: index)
            siftUp(from: index)
        }
        return elements.removeLast()
    }
}

extension Heap {
    func siftDown(from index: Int) {
        var parent = index
        
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            
            var candidate = parent // 탐색할 아이 지정
            if left < count , sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < count , sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent {  // 종료조건
                return
            }
            
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    func siftUp(from index: Int) {
        var child = index // 마지막 인덱스
        
        while true {
            let parent = parentIndex(ofChildAt: child)
            
            if child > 0 && sort(elements[child], elements[parent]) { // > 이니까
                elements.swapAt(child, parent)
                child = parent
            }else {
                return
            }
        }
    }
}

extension Heap {
    func peek() -> Element? {
        return elements.first
    }
    
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
}
```

* [Graph](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Graph.pdf)

> 그래프(Graph)는 비선형(Non-Linear) 자료구조로서 노드(Node)와 간선(Edge)로 구성된 형태를 가진 네트워크 모델의 자료구조입니다.

```swift
public struct Vertex<T>: Equatable where T: Hashable {
    public var data: T
    public let index: Int
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(index): \(data)"
    }
}

extension Vertex: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(data)
        hasher.combine(index)
    }
}

public struct Edge<T>: Equatable where T: Hashable {
    public let from: Vertex<T>
    public let to: Vertex<T>

    public let weight: Double?
}

extension Edge: CustomStringConvertible {
    public var description: String {
        guard let unwrappedWeight = weight else {
          return "\(from.description) -> \(to.description)"
        }
        
        return "\(from.description) -(\(unwrappedWeight))-> \(to.description)"
    }
}

extension Edge: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(from.description)
        hasher.combine(to.description)
        hasher.combine(weight)
    }
}

public func ==<T>(lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
    guard lhs.index == rhs.index else {
        return false
    }

    guard lhs.data == rhs.data else {
        return false
    }

    return true
}

public func == <T>(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
    guard lhs.from == rhs.from else {
        return false
    }

    guard lhs.to == rhs.to else {
        return false
    }

    guard lhs.weight == rhs.weight else {
        return false
    }

    return true
}

open class AbstractGraph<T>: CustomStringConvertible where T: Hashable {
    public required init() {}

    public required init(fromGraph graph: AbstractGraph<T>) {
        for edge in graph.edges {
            let from = createVertex(edge.from.data)
            let to = createVertex(edge.to.data)

            addDirectedEdge(from, to: to, withWeight: edge.weight)
        }
    }

    open func createVertex(_ data: T) -> Vertex<T> {
        fatalError("abstract function called")
    }

    open func addDirectedEdge(_ from: Vertex<T>, to: Vertex<T>, withWeight weight: Double?) {
        fatalError("abstract function called")
    }

    open func addUndirectedEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
        fatalError("abstract function called")
    }
    
    open func weightFrom(_ sourceVertex: Vertex<T>, 
                         to destinationVertex: Vertex<T>) -> Double? {
        fatalError("abstract function called")
    }

    open func edgesFrom(_ sourceVertex: Vertex<T>) -> [Edge<T>] {
        fatalError("abstract function called")
    }
    
    open var description: String {
        fatalError("abstract property accessed")
    }

    open var vertices: [Vertex<T>] {
        fatalError("abstract property accessed")
    }

    open var edges: [Edge<T>] {
        fatalError("abstract property accessed")
    }
}
```

* [Graph(DFS)](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Graph(DFS).pdf)

> DFS(Depth-First Search)란 깊이 우선 탐색으로서 그래프에서 모든 경로를 탐색하는데 사용하는 알고리즘입니다.

```swift
func depthFirstSearch(start: Int, end lastNode: Int, edges: [(Int, Int)]) -> [Any] {
    var edgeInfo = [Int: Array<Int>]()
    
    for edge in edges {
        if var array = edgeInfo[edge.0] {
            array.append(edge.1)
            edgeInfo[edge.0] = array
        } else { edgeInfo[edge.0] = [edge.1] }
    }
    
    var result = 0
    var paths:[[Any]] = [[]]
    
    func dfs(node: Int, visited: [Int]) {
        guard node != lastNode else {
            if result < lastNode { paths.append(visited) }
            result += 1
            return
        }
        
        guard let neighbors = edgeInfo[node] else { return }
        
        for edge in neighbors {
            guard visited.contains(edge) == false else { continue }
            
            dfs(node: edge, visited: visited + [edge])
        }
    }
    
    dfs(node: start, visited: [1])
    
    return paths.filter { $0.count != 0 }
}
```

* [Graph(BFS)](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Graph(BFS).pdf)

> BFS(Bredth-First Search)란 그래프(Graph)에서 노드를 탐색하기 위한 하나의 알고리즘 방법으로서 너비 우선 검색이라는 방식입니다.
> BFS를 사용하여 최단 및 최소 경로를 구할 수 있습니다.

```swift
func breadthFirstSearch(n: Int, edges: [(Int, Int)]) -> [Any] {
   let nodes = (0..<n).map({ NodeGraphPath<Int>(value: $0 + 1) })
    
    for (from, to) in edges {
        nodes[from - 1].appendEdgeTo(nodes[to - 1])
    }
    
    var shortest = Array(repeating: [1], count: n)
   
    let queue = Queue<NodeGraphPath<Int>>()
    
    // 시작 노드를 큐에 삽입 및 방문 상태 체크
    queue.enqueue(nodes[0])
    nodes[0].visited = true
    
    // 큐에서 최상단 노드를 하나씩 빼면서 큐가 비어 있을 때까지 반복
    while let node = queue.dequeue() {
       for edge in node.edges {
            let dest = edge.destination
           
            // 현재 대상 노드를 큐에 삽입 및 방문 상태 체크
            guard dest.visited == false else { continue }
            queue.enqueue(dest)
            dest.visited = true

            // 현재 노드에 대한 총 이동 경로 노드를 저장
            shortest[dest.value - 1] = shortest[node.value - 1] + [dest.value]
       }
   }
    
    return shortest
}
```

* [Binary Tree](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Binary%20Tree.pdf)

> 이진 트리(Binary Tree)는 한 노드가 최대 2개의 자식 노드만 가질 수 있는 트리를 말합니다.

```swift
// recursive enum 은 indirect 키워드 적어줘야함
public indirect enum BinaryTree<T : Comparable> {
    case node(BinaryTree<T>, T, BinaryTree<T>)
    case empty

    public var count: Int {
        switch self {
            case let .node(left, _, right):
              return left.count + 1 + right.count
            case .empty:
              return 0
        }
    }
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        switch self {
            case let .node(left, value, right):
              return "value: \(value), left = [\(left.description)], right = [\(right.description)]"
            case .empty:
              return ""
        }
    }
}

extension BinaryTree {
    public func traverseInOrder(process: (T) -> Void) {
        // 같은 BinaryTree만 가능하도록
        if case let .node(left, value, right) = self {
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }

    public func traversePreOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            process(value)
            left.traversePreOrder(process: process)
            right.traversePreOrder(process: process)
        }
    }

    public func traversePostOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traversePostOrder(process: process)
            right.traversePostOrder(process: process)
            process(value)
        }
    }
}
```

* [Binary Search Tree](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20Binary%20Search%20Tree.pdf)

> 이진 탐색 트리(Binary Search Tree)는 이진 트리의 한 종류로서 삽입과 삭제에서 특정한 규칙을 두어 검색을 빠르게 할 수 있도록 도와주는 자료구조입니다.

```swift
public class BinarySearchTree<T: Comparable> {
    fileprivate(set) public var value: T
    fileprivate(set) public var parent: BinarySearchTree?
    fileprivate(set) public var left: BinarySearchTree?
    fileprivate(set) public var right: BinarySearchTree?

    public init(value: T) {
        self.value = value
    }

    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        
        for v in array.dropFirst() {
          insert(value: v)
        }
    }
}

extension BinarySearchTree {
   public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
}

extension BinarySearchTree {
   @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?

        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }

        replacement?.remove()

        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        
        reconnectParentTo(node:replacement)

        parent = nil
        left = nil
        right = nil

        return replacement
    }

    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        
        node?.parent = parent
    }
}

extension BinarySearchTree {
    public func search(value: T) -> BinarySearchTree? {
        var node: BinarySearchTree? = self
        
        while let n = node {
            if value < n.value {
                node = n.left
            } else if value > n.value {
                node = n.right
            } else {
                return node
            }
        }
        
        return nil
    }
}

extension BinarySearchTree {
    public func traversePreOrder(process: (T) -> Void) -> [T] {
        var results = [T]()

        process(value)
        results.append(value)
        results += left?.traversePreOrder(process: process) ?? []
        results += right?.traversePreOrder(process: process) ?? []

        return results
    }
    
    public func traverseInOrder(process: (T) -> Void)-> [T] {
        var results = [T]()

        results += left?.traverseInOrder(process: process) ?? []
        process(value)
        results.append(value)
        results += right?.traverseInOrder(process: process) ?? []

        return results
    }

    public func traversePostOrder(process: (T) -> Void) -> [T] {
        var results = [T]()

        results += left?.traversePostOrder(process: process) ?? []
        results += right?.traversePostOrder(process: process) ?? []
        process(value)
        results.append(value)

        return results
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
            
        if let left = left {
            s += "(\(left.description)) <- "
        }
            
        s += "\(value)"
            
        if let right = right {
            s += " -> (\(right.description))"
        }
        
        return s
    }

    public func toArray() -> [T] {
        return map { $0 }
    }
}
```

* [AVL](https://github.com/billnjoyce/Lectures/blob/master/docs/data%20structure/%5BSwift%5D%20Data%20Structure%20-%20AVL.pdf)

> AVL는 자가 균형 트리로서 트리가 한쪽으로 치우쳐 트리가 가지는 높이의 균형이 깨지지 않도록 스스로 균형을 맞춰주는 이진 탐색 트리입니다.

```swift
public class AVLNode<Element> {
    public var value: Element
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    
    public var height = 0

    public var balanceFactor: Int {
        return leftHeight - rightHeight
    }

    public var leftHeight: Int { return leftChild?.height ?? -1 }
    public var rightHeight: Int { return rightChild?.height ?? -1 }
    
    public init(value: Element) {
        self.value = value
    }
}

extension AVLNode: CustomStringConvertible {
    var min: AVLNode {
        return leftChild?.min ?? self
    }

    public var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: AVLNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild, top + " ", top + "┌──", top + "│ ")
            + root + "\(node.value)\n"
            + diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

public struct AVLTree<Element: Comparable> {
    public private(set) var root: AVLNode<Element>?
    
    public init() {}

    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }

        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }

        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
    
        return balancedNode
    }
}

extension AVLTree {
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return nil
        }

        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }

        let balanceNode = balanced(node)
        balanceNode.height = max(balanceNode.leftHeight, balanceNode.rightHeight) + 1
        return balanceNode
    }
}

extension AVLTree {
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.rightChild!
       
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
       
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1

        return pivot
    }
    
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!

        node.leftChild = pivot.rightChild
        pivot.rightChild = node

        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1

        return pivot
    }
}

extension AVLTree {
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }

        node.rightChild = rightRotate(rightChild)
      
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node}

        node.leftChild = leftRotate(leftChild)

        return rightRotate(node)
    }
}

extension AVLTree {
   private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFactor {

        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
               return leftRightRotate(node)
            } else {
          
                return rightRotate(node)
            }

        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }

        default:
            return node
        }
    }
}

extension AVLTree: CustomStringConvertible {
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}
```
