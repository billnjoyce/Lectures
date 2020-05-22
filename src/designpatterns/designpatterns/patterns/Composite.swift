//
//  Composite.swift
//  designpatterns
//
//  Created by billkim on 19/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol ComponentA {
    var parent: ComponentA? { get set }

    func add(component: ComponentA)
    func remove()

    func isComposite() -> Bool
    func operation() -> String
}

extension ComponentA {
    func add(component: ComponentA) {}
    func remove() {}
    func isComposite() -> Bool {
        return false
    }
}

class Leaf : ComponentA {
    var parent: ComponentA?

    func operation() -> String {
        return "Leaf"
    }
}

class Composite : ComponentA {
    var parent: ComponentA?

    private var children = [ComponentA]()

    func add(component: ComponentA) {
        var item = component
        item.parent = self
        children.append(item)
    }

    func remove() {
        if children.count > 0 {
            children.removeLast()
        }
    }

    func isComposite() -> Bool {
        return true
    }

    func operation() -> String {
        /*
            let result = children.map( { (component: ComponentA) -> String in
                return component.operation()
            })
        */
        let result = children.map({ $0.operation() })
        
        return "Branch(" + result.joined(separator: " ") + ")"
    }
}

class ClientComposite : Client {
    func makePattern() -> Pattern {
        return PatternComposite()
    }
}

class PatternComposite : Pattern {
    func run() -> String {
        var result = ""
        
        let tree = Composite()
        print("Tree : " + tree.operation())
        result += "Tree : " + tree.operation() + "\n"
        // Tree : Branch()
        
        let branch1 = Composite()
        branch1.add(component: Leaf())
        branch1.add(component: Leaf())

        let branch2 = Composite()
        branch2.add(component: Leaf())

        tree.add(component: branch1)
        print("Tree : " + tree.operation())
        result += "Tree : " + tree.operation() + "\n"
        // Tree : Branch(Branch(Leaf Leaf))
        
        tree.add(component: branch2)
        print("Tree : " + tree.operation())
        result += "Tree : " + tree.operation() + "\n"
        // Tree : Branch(Branch(Leaf Leaf) Branch(Leaf))
        
        tree.add(component: Leaf())
        print("Tree : " + tree.operation())
        result += "Tree : " + tree.operation() + "\n"
        // Tree : Branch(Branch(Leaf Leaf) Branch(Leaf) Leaf)
        
        tree.remove()
        print("Tree(remove) : " + tree.operation())
        result += "Tree(remove) : " + tree.operation() + "\n"
        // Tree(remove) : Branch(Branch(Leaf Leaf) Branch(Leaf))
        
        tree.remove()
        print("Tree(remove) : " + tree.operation())
        result += "Tree(remove) : " + tree.operation() + "\n"
        // Tree(remove) : Branch(Branch(Leaf Leaf))
        
        tree.remove()
        print("Tree(remove) : " + tree.operation())
        result += "Tree(remove) : " + tree.operation() + "\n"
        // Tree(remove) : Branch()
        
        return result
    }
}
