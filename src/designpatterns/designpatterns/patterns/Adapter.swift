//
//  Adapter.swift
//  designpatterns
//
//  Created by billkim on 19/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

class Target {
    func request() -> String {
        return ""
    }
}

class Adaptee {
    public func specificRequest() -> String {
        return "Adaptee's specificRequest."
    }
}

class Adapter: Target {
    private var adaptee: Adaptee

    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }

    override func request() -> String {
        return self.adaptee.specificRequest()
    }
}

class ClientAdapter : Client {
    func makePattern() -> Pattern {
        return PatternAdapter()
    }
}

class PatternAdapter : Pattern {
    func run() -> String {
        var result = ""
        
        let adaptee = Adaptee()
        print(adaptee.specificRequest()) // Adaptee's specificRequest.
        result += "\(adaptee.specificRequest())\n"
        
        result += "Call from adapter - \(Adapter(adaptee).request())\n"
        
        return result
    }
}
