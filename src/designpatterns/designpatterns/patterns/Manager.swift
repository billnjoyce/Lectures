//
//  Manager.swift
//  designpatterns
//
//  Created by billkim on 22/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol Client {
    func run() -> String
    func makePattern() -> Pattern
}

extension Client {
    func run()  -> String {
        let pattern = makePattern()
        return pattern.run()
    }
}

protocol Pattern {
    func run() -> String 
}

class Manager {
    static let sharedInstance = Manager()

    private init() {
    }
}
