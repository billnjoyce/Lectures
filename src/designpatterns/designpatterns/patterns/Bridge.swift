//
//  Bridge.swift
//  designpatterns
//
//  Created by billkim on 20/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

// Implementor
protocol Car {
    // implementation()
    func drive() -> String
}

// ConcreteImplementor
class Sedan : Car {
    // implementation()
    func drive() -> String {
        print("Drive a sedan")
        return "Drive a sedan\n"
    }
}

// ConcreteImplementor
class SUV : Car {
    func drive() -> String {
        print("Drive a SUV")
        return "Drive a SUV\n"
    }
}

// Abstraction
protocol ColoredCar {
    // implementor
    var car: Car { get set }
    
    // implementation()
    func drive() -> String
}

// RefinedAbstraction
class RedCar: ColoredCar {
    // implementor
    var car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    // refinedFunction()
    func drive() -> String {
        var result = ""
        print("It's a red color sedan.")
        result += "It's a red color sedan.\n"
        
        // self.impl.implementation()
        result += car.drive()
        
        return result
    }
}

class ClientBridge : Client {
    func makePattern() -> Pattern {
        return PatternBridge()
    }
}

class PatternBridge : Pattern {
    func run() -> String {
        var result = ""
        
        let sedan = Sedan()
        let redSedan = RedCar(car: sedan)
        
        result += redSedan.drive()
        
        // It's a red color sedan.
        // Drive a sedan
        
        return result
    }
}
