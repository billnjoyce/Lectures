//
//  Prototype.swift
//  designpatterns
//
//  Created by billkim on 18/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol Prototype {
    func operation(value: Int)
    func clone() -> Prototype
}

class ConcretePrototypeA : Prototype {
    init() { }
    init(client: ConcretePrototypeA) { }
    
    func operation(value: Int) { print("ConcretePrototypeA operation - value : \(value)") }
    
    func clone() -> Prototype {
        print("ConcretePrototypeA clone")
        return ConcretePrototypeA(client: self)
    }
}

class ConcretePrototypeB : Prototype {
    init() { }
    init(client: ConcretePrototypeB) { }
    
    func operation(value: Int) { print("ConcretePrototypeB operation - value : \(value*2)") }
    
    func clone() -> Prototype {
        print("ConcretePrototypeB clone")
        return ConcretePrototypeB(client: self)
    }
}
