//
//  Flyweight.swift
//  designpatterns
//
//  Created by billkim on 20/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

class Flyweight {
    var sharedState: [String]
    init(sharedState: [String]) { self.sharedState = sharedState }
    func operation(uniqueState: [String]) { }
}

class ConcreteFlyweight : Flyweight {
    override func operation(uniqueState: [String]) {
        print("Flyweight: Displaying shared (\(sharedState)) and unique (\(uniqueState) state.\n")
    }
}

extension Array where Element == String {
    /// Returns a Flyweight's string hash for a given state.
    var key: String {
        return self.joined(separator: " ")
    }
}

class FlyweightFactory {
    private var flyweights: [String: Flyweight]

    init(states: [[String]]) {
        var flyweights = [String: Flyweight]() // Dictionary

        for state in states {
            flyweights[state.key] = Flyweight(sharedState: state)
        }

        self.flyweights = flyweights
    }

    func getFlyweight(for state: [String]) -> (String, Flyweight) {
        let key = state.key
        
        guard let foundFlyweight = flyweights[key] else {
            print("FlyweightFactory: Can't find a \(key), creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return ("FlyweightFactory: Can't find a \(key), creating new one.\n", flyweight)
        }
        
        print("FlyweightFactory: Reusing existing \(key).\n")
        return ("FlyweightFactory: Reusing existing \(key).\n", foundFlyweight)
    }

    func printFlyweights() -> String {
        var result = ""
        
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        result += "FlyweightFactory: I have \(flyweights.count) flyweights:\n\n"
        
        for item in flyweights {
            print(item.key)
            result += item.key + "\n"
        }
        
        return result
    }
}

class ClientFlyweight : Client {
    func makePattern() -> Pattern {
        return PatternFlyweight()
    }
}

class PatternFlyweight : Pattern {
    func run() -> String {
        var result = ""
        
        func addCarToPoliceDatabase(
                _ factory: FlyweightFactory,
                _ plates: String,
                _ owner: String,
                _ car: [String]) {

            print("Client: Adding a car to database.\n")
            result += "Client: Adding a car to database.\n"
            
            let flyweight = factory.getFlyweight(for: car)

            flyweight.1.operation(uniqueState: [plates, owner])
            
            result += flyweight.0 + "\n"
        }
        
        let factory = FlyweightFactory(states:
        [
            ["Chevrolet", "Camaro2018", "pink"],
            ["Mercedes Benz", "C300", "black"],
            ["Mercedes Benz", "C500", "red"],
            ["BMW", "M5", "red"],
            ["BMW", "X6", "white"]
        ])

        result += factory.printFlyweights() + "\n"
        // FlyweightFactory: I have 5 flyweights:

        // Mercedes Benz C300 black
        // BMW M5 red
        // BMW X6 white
        // Chevrolet Camaro2018 pink
        // Mercedes Benz C500 red
        
        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                ["BMW", "M5", "red"])

        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                ["BMW", "X1", "red"])

        result += factory.printFlyweights()
        
        // BMW X6 white
        // BMW X1 red
        // Mercedes Benz C300 black
        // Mercedes Benz C500 red
        // Chevrolet Camaro2018 pink
        // BMW M5 red
        
        return result
    }
}
