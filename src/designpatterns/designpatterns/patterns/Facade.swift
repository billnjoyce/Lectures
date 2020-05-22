//
//  Facade.swift
//  designpatterns
//
//  Created by billkim on 19/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

class Facade {
    private var subsystem1: Subsystem1
    private var subsystem2: Subsystem2

    init(subsystem1: Subsystem1 = Subsystem1(),
         subsystem2: Subsystem2 = Subsystem2()) {
        self.subsystem1 = subsystem1
        self.subsystem2 = subsystem2
    }

    func operation() -> String {
        
        var result = "Facade initializes subsystems:\n"
        result += " " + subsystem1.operation1()
        result += " " + subsystem2.operation1()
        result += "\n" + "Facade orders subsystems to perform the action:\n"
        result += " " + subsystem1.operationN()
        result += " " + subsystem2.operationZ()
        
        return result
    }
}

class Subsystem1 {
    func operation1() -> String {
        return "Sybsystem1: Ready!\n"
    }

    func operationN() -> String {
        return "Sybsystem1: Go!\n"
    }
}

class Subsystem2 {
    func operation1() -> String {
        return "Sybsystem2: Get ready!\n"
    }

    func operationZ() -> String {
        return "Sybsystem2: Fire!\n"
    }
}

class ClientFacade : Client {
    func makePattern() -> Pattern {
        return PatternFacade()
    }
}

class PatternFacade : Pattern {
    func run() -> String {
        var result = ""
        
        let facade = Facade(subsystem1: Subsystem1(), subsystem2: Subsystem2())
        print(facade.operation())
        result += facade.operation() + "\n"
        
        // Facade initializes subsystems:
        // Sybsystem1: Ready!
        // Sybsystem2: Get ready!

        // Facade orders subsystems to perform the action:
        // Sybsystem1: Go!
        // Sybsystem2: Fire!
        
        return result
    }
}
