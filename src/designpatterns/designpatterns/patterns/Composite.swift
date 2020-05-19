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
