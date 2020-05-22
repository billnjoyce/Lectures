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
    
    func test() -> String {
        print("SingletonA test")
        return "SingletonA test\n"
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
    
    func test() -> String {
        print("SingletonB test")
        return "SingletonB test\n"
    }
}

class ClientSingleton : Client {
    func makePattern() -> Pattern {
        return PatternSingleton()
    }
}

class PatternSingleton : Pattern {
    func run() -> String {
        var result = ""
        
        result += SingletonA.sharedInstance.test()
        result += SingletonA.sharedInstance.test()
        
        // Print SingletonA init
        // Print SingletonA test
        // Print SingletonA test
        
        // var a:SingletonA = SingletonA() // 컴파일 에러, 외부에서 생성 및 초기화 불가
        
        result += SingletonB.sharedInstance.test()
        result += SingletonB.sharedInstance.test()
        
        return result
    }
}
