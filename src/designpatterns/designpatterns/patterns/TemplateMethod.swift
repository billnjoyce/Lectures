//
//  TemplateMethod.swift
//  designpatterns
//
//  Created by billkim on 21/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol AbstractClass {
    func templateMethod() -> String // 기본 템플릿 메소드

    // 기본 골격이 되는 메소드들
    
    func baseOperation1() -> String
    func baseOperation2() -> String
    func baseOperation3() -> String

    func requiredOperations1() -> String
    func requiredOperation2() -> String

    func hook1() -> String
    func hook2() -> String
}

extension AbstractClass {
    func templateMethod() -> String {
        var result = ""
        
        result += baseOperation1()
        result += requiredOperations1()
        result += baseOperation2()
        result += hook1()
        result += requiredOperation2()
        result += baseOperation3()
        result += hook2()
        
        return result
    }

    func baseOperation1() -> String {
        print("baseOperation1")
        return "baseOperation1\n"
    }

    func baseOperation2() -> String {
        print("baseOperation2")
        return "baseOperation2\n"
    }

    func baseOperation3() -> String {
        print("baseOperation3")
        return "baseOperation3\n"
    }

    func hook1() -> String { return "" }
    func hook2() -> String { return "" }
}

class ConcreteClass1: AbstractClass {
    func requiredOperations1() -> String {
        print("ConcreteClass1 requiredOperations1")
        return "ConcreteClass1 requiredOperations1\n"
    }

    func requiredOperation2() -> String {
        print("ConcreteClass1 requiredOperation2")
        return "ConcreteClass1 requiredOperation2\n"
    }

    func hook2() -> String {
        print("ConcreteClass1 hook2")
        return "ConcreteClass1 hook2\n"
    }
}

class ConcreteClass2: AbstractClass {
    func requiredOperations1() -> String {
        print("ConcreteClass2 requiredOperations1")
        return "ConcreteClass2 requiredOperations1\n"
    }

    func requiredOperation2() -> String {
        print("ConcreteClass2 requiredOperation2")
        return "ConcreteClass2 requiredOperation2\n"
    }

    func hook1() -> String {
        print("ConcreteClass2 hook1")
        return "ConcreteClass2 hook1\n"
    }
}

class ClientTemplateMethod : Client {
    func makePattern() -> Pattern {
        return PatternTemplateMethod()
    }
}

class PatternTemplateMethod : Pattern {
    func run() -> String {
        var result = ""
        
        let template1 = ConcreteClass1()
        result += template1.templateMethod()
        
        // baseOperation1
        // ConcreteClass1 requiredOperations1
        // baseOperation2
        // ConcreteClass1 requiredOperation2
        // baseOperation3
        // ConcreteClass1 hook2
        
        result += "\n"
        
        let template2 = ConcreteClass2()
        result += template2.templateMethod()
        
        // baseOperation1
        // ConcreteClass2 requiredOperations1
        // baseOperation2
        // ConcreteClass2 hook1
        // ConcreteClass2 requiredOperation2
        // baseOperation3
        
        return result
    }
}
