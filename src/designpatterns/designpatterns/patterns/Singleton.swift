//
//  Singleton.swift
//  designpatterns
//
//  Created by billkim on 18/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

class SingletonA {
    static let sharedInstance = SingletonA()

    private init() {
        print("SingletonA init")
    }
    
    func test() {
        print("SingletonA test")
    }
    
    public var a:Int = 0
}

class SingletonB {
    class var sharedInstance: SingletonB {
        struct Static {
            static let instance: SingletonB = SingletonB()
        }
        
        return Static.instance
    }
    
    private init() {
        print("SingletonB init")
    }
    
    func test() {
        print("SingletonB test")
    }
}
