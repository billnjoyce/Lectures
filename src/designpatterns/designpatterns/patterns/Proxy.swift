//
//  Proxy.swift
//  designpatterns
//
//  Created by billkim on 20/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol Subject {
    func request()
}

class RealSubject : Subject {
    func request() {
        print("RealSubject request.")
    }
}

class Proxy : Subject {
    private var realSubject: RealSubject

    init(_ realSubject: RealSubject) {
        self.realSubject = realSubject
    }

    func request() {
        print("Proxy request.")
        
        otherFunction()
    }

    private func otherFunction() { }
}
