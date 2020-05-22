//
//  Decorator.swift
//  designpatterns
//
//  Created by billkim on 19/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol Component {
    func operation() -> String
}

class ConcreteComponent: Component {
    func operation() -> String {
        return "ConcreteComponent operation"
    }
}

class Decorator : Component {
    private var component: Component

    init(_ component: Component) {
        self.component = component
    }

    func operation() -> String {
        return component.operation()
    }
}

class ConcreteDecoratorA : Decorator {
    override func operation() -> String {
        return "ConcreteDecoratorA(" + super.operation() + ")"
    }
}

class ConcreteDecoratorB : Decorator {
    override func operation() -> String {
        return "ConcreteDecoratorB(" + super.operation() + ")"
    }
}

class ClientDecorator : Client {
    func makePattern() -> Pattern {
        return PatternDecorator()
    }
}

class PatternDecorator : Pattern {
    func run() -> String {
        var result = ""
        
        let component = ConcreteComponent()
        print("Result: " + component.operation()) // Result: ConcreteComponent operation
        result += "Result: " + component.operation() + "\n"
        
        let decorator1 = ConcreteDecoratorA(component)
        print("Result: " + decorator1.operation()) // Result: ConcreteDecoratorA(ConcreteComponent operation)
        result += "Result: " + decorator1.operation() + "\n"
        
        let decorator2 = ConcreteDecoratorB(decorator1)
        print("Result: " + decorator2.operation()) // Result: ConcreteDecoratorB(ConcreteDecoratorA(ConcreteComponent operation))
        result += "Result: " + decorator2.operation() + "\n"
        
        return result
    }
}
