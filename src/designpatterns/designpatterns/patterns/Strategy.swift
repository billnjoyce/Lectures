//
//  Strategy.swift
//  designpatterns
//
//  Created by billkim on 20/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

class Context {
    private var strategy: Strategy

    init(strategy: Strategy) {
        self.strategy = strategy
    }

    func update(strategy: Strategy) {
        self.strategy = strategy
    }

    func doSomeBusinessLogic() -> String {
        let result = strategy.doAlgorithm(["a", "b", "c", "d", "e"])
        print(result.joined(separator: ","))
        return result.joined(separator: ",") + "\n"
    }
}

protocol Strategy {
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T]
}

class ConcreteStrategyA : Strategy {
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T] {
        return data.sorted()
    }
}

class ConcreteStrategyB : Strategy {
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T] {
        return data.sorted(by: >)
    }
}

class ClientStrategy : Client {
    func makePattern() -> Pattern {
        return PatternStrategy()
    }
}

class PatternStrategy : Pattern {
    func run() -> String {
        var result = ""
        
        let context = Context(strategy: ConcreteStrategyA())
        print("Client: Strategy is set to normal sorting.")
        result += "Client: Strategy is set to normal sorting.\n"
        result += context.doSomeBusinessLogic() // a,b,c,d,e

        print("\nClient: Strategy is set to reverse sorting.")
        result += "\nClient: Strategy is set to reverse sorting.\n"
        context.update(strategy: ConcreteStrategyB())
        result += context.doSomeBusinessLogic() // e,d,c,b,a
        
        return result
    }
}
