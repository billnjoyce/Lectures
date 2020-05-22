//
//  Prototype.swift
//  designpatterns
//
//  Created by billkim on 18/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol Prototype {
    func operation(value: Int) -> String
    func clone() -> Prototype
}

class ConcretePrototypeA : Prototype {
    init() { }
    init(client: ConcretePrototypeA) { }
    
    func operation(value: Int) -> String {
        print("ConcretePrototypeA operation - value : \(value)")
        return "ConcretePrototypeA operation - value : \(value)\n"
    }
    
    func clone() -> Prototype {
        print("ConcretePrototypeA clone")
        return ConcretePrototypeA(client: self)
    }
}

class ConcretePrototypeB : Prototype {
    init() { }
    init(client: ConcretePrototypeB) { }
    
    func operation(value: Int) -> String {
        print("ConcretePrototypeB operation - value : \(value*2)")
        return "ConcretePrototypeB operation - value : \(value*2)\n"
    }
    
    func clone() -> Prototype {
        print("ConcretePrototypeB clone")
        return ConcretePrototypeB(client: self)
    }
}

class ClientPrototype : Client {
    func makePattern() -> Pattern {
        return PatternPrototype()
    }
}

class PatternPrototype : Pattern {
    func run() -> String {
        var result = ""
        
        func concretePrototype(prototype: Prototype) -> Prototype
        {
            // Client는 구체적인 ConcretePrototype 객체 접근 불필요
            // 모든 ConcretePrototype 객체에 대해 알 필요가 없다.
            // 새로운 ConcretePrototype 객체가 추가되더라도 객체 생성 시 수정이 불필요
            
            let newPrototype = prototype.clone()
            return newPrototype
        }
        
        let clientA = concretePrototype(prototype: ConcretePrototypeA())
        result += clientA.operation(value: 10)
        // ConcretePrototypeA clone
        // ConcretePrototypeA operation - value : 10
        
        let clientB = concretePrototype(prototype: ConcretePrototypeB())
        result += clientB.operation(value: 10)
        // ConcretePrototypeB clone
        // ConcretePrototypeB operation - value : 20
        
        return result
    }
}
