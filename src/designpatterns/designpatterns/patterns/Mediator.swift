//
//  Mediator.swift
//  designpatterns
//
//  Created by billkim on 21/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol Mediator : AnyObject {
    func notify(sender: BaseComponent, event: String)
}

class ConcreteMediator : Mediator {
    private var component1: Component1
    private var component2: Component2

    init(_ component1: Component1, _ component2: Component2) {
        self.component1 = component1
        self.component2 = component2

        component1.update(mediator: self)
        component2.update(mediator: self)
    }

    func notify(sender: BaseComponent, event: String) {
        if event == "A" {
            self.component2.operationC()
        }
        else if (event == "D") {
            self.component1.operationB()
            self.component2.operationC()
        }
    }
}

class BaseComponent {
    fileprivate weak var mediator: Mediator?

    init(mediator: Mediator? = nil) {
        self.mediator = mediator
    }

    func update(mediator: Mediator) {
        self.mediator = mediator
    }
}

class Component1 : BaseComponent {
    func operationA() {
        print("operationA")
        mediator?.notify(sender: self, event: "A")
    }

    func operationB() {
        print("operationB")
        mediator?.notify(sender: self, event: "B")
    }
}

class Component2 : BaseComponent {
    func operationC() {
        print("operationC")
        mediator?.notify(sender: self, event: "C")
    }

    func operationD() {
        print("operationD")
        mediator?.notify(sender: self, event: "D")
    }
}
