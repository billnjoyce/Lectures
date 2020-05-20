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

    func getFlyweight(for state: [String]) -> Flyweight {
        let key = state.key
        
        guard let foundFlyweight = flyweights[key] else {
            print("FlyweightFactory: Can't find a \(key), creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return flyweight
        }
        
        print("FlyweightFactory: Reusing existing \(key).\n")
        return foundFlyweight
    }

    func printFlyweights() {
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        
        for item in flyweights {
            print(item.key)
        }
    }
}
