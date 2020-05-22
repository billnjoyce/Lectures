//
//  Proxy.swift
//  designpatterns
//
//  Created by billkim on 20/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol Subject {
    func request() -> String
}

class RealSubject : Subject {
    func request() -> String {
        print("RealSubject request.")
        return "RealSubject request."
    }
}

class Proxy : Subject {
    private var realSubject: RealSubject

    init(_ realSubject: RealSubject) {
        self.realSubject = realSubject
    }

    func request() -> String {
        print("Proxy request.")
        
        otherFunction()
        
        return "Proxy request."
    }

    private func otherFunction() { }
}

class ClientProxy : Client {
    func makePattern() -> Pattern {
        return PatternProxy()
    }
}

class PatternProxy : Pattern {
    func run() -> String {
        var result = ""
        
        func clientProxy(subject: Subject) {
            result += subject.request() + "\n"
        }
        
        let realSubject = RealSubject()
        clientProxy(subject: realSubject)
        // RealSubject request.
        
        let proxy = Proxy(realSubject)
        clientProxy(subject: proxy)
        // Proxy request.
        // RealSubject request.
        
        return result
    }
}
