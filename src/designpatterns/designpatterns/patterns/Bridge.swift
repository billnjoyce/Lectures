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
    func drive()
}

// ConcreteImplementor
class Sedan : Car {
    // implementation()
    func drive() {
        print("Drive a sedan")
    }
}

// ConcreteImplementor
class SUV : Car {
    func drive() {
        print("Drive a SUV")
    }
}

// Abstraction
protocol ColoredCar {
    // implementor
    var car: Car { get set }
    
    // implementation()
    func drive()
}

// RefinedAbstraction
class RedCar: ColoredCar {
    // implementor
    var car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    // refinedFunction()
    func drive() {
        print("It's a red color sedan.")
        
        // self.impl.implementation()
        car.drive()
    }
}

