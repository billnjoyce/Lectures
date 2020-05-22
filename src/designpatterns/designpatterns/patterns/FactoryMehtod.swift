//
//  FactoryMehtod.swift
//  designpatterns
//
//  Created by billkim on 18/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

// Creator
protocol Creator {
    func factoryMethod() -> Product
    func someOperation() -> String
}

extension Creator {
    func someOperation() -> String {
        let product = factoryMethod()
        return "Creator : The same creator's code has just worked with " + product.operation()
    }
}

// Product
protocol Product {
    func operation() -> String
}

// Concrete Creators
class ConcreteCreator1: Creator {
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    public func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}

// Concrete Products
class ConcreteProduct1: Product {
    func operation() -> String {
        print("ConcreteProduct1 operation")
        return "ConcreteProduct1 operation"
    }
}

class ConcreteProduct2: Product {
    func operation() -> String {
        print("ConcreteProduct2 operation")
        return "ConcreteProduct2 operation"
    }
}

class ClientFactoryMethod : Client {
    func makePattern() -> Pattern {
        return PatternFactoryMethod()
    }
}

class PatternFactoryMethod : Pattern {
    func run() -> String {
        var result = ""
        
        func concreteClient(creator: Creator) -> String {
            return creator.someOperation() + "\n"
        }
        
        result += concreteClient(creator: ConcreteCreator1())
        // ConcreteProduct1 operation
        
        result += concreteClient(creator: ConcreteCreator2())
        // ConcreteProduct2 operation
        
        return result
    }
}
