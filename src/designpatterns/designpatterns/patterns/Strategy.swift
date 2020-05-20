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

    func doSomeBusinessLogic() {
        let result = strategy.doAlgorithm(["a", "b", "c", "d", "e"])
        print(result.joined(separator: ","))
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
