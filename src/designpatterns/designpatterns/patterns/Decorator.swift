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
