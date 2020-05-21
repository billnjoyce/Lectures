//
//  Visitor.swift
//  designpatterns
//
//  Created by billkim on 21/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol Element {
    func accept(_ visitor: Visitor)
}

class ConcreteElementA : Element {
    func accept(_ visitor: Visitor) {
        visitor.visitConcreteElementA(element: self)
    }

    func exclusiveMethodOfConcreteElementA() -> String {
        return "A"
    }
}

class ConcreteElementB: Element {
    func accept(_ visitor: Visitor) {
        visitor.visitConcreteElementB(element: self)
    }

    func specialMethodOfConcreteElementB() -> String {
        return "B"
    }
}

protocol Visitor {
    func visitConcreteElementA(element: ConcreteElementA)
    func visitConcreteElementB(element: ConcreteElementB)
}

class ConcreteVisitor1: Visitor {
    func visitConcreteElementA(element: ConcreteElementA) {
        print(element.exclusiveMethodOfConcreteElementA() + " + ConcreteVisitor1\n")
    }

    func visitConcreteElementB(element: ConcreteElementB) {
        print(element.specialMethodOfConcreteElementB() + " + ConcreteVisitor1\n")
    }
}

class ConcreteVisitor2: Visitor {
    func visitConcreteElementA(element: ConcreteElementA) {
        print(element.exclusiveMethodOfConcreteElementA() + " + ConcreteVisitor2\n")
    }

    func visitConcreteElementB(element: ConcreteElementB) {
        print(element.specialMethodOfConcreteElementB() + " + ConcreteVisitor2\n")
    }
}
