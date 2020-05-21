//
//  TemplateMethod.swift
//  designpatterns
//
//  Created by billkim on 21/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol AbstractClass {
    func templateMethod() // 기본 템플릿 메소드

    // 기본 골격이 되는 메소드들
    
    func baseOperation1()
    func baseOperation2()
    func baseOperation3()

    func requiredOperations1()
    func requiredOperation2()

    func hook1()
    func hook2()
}

extension AbstractClass {
    func templateMethod() {
        baseOperation1()
        requiredOperations1()
        baseOperation2()
        hook1()
        requiredOperation2()
        baseOperation3()
        hook2()
    }

    func baseOperation1() {
        print("baseOperation1")
    }

    func baseOperation2() {
        print("baseOperation2")
    }

    func baseOperation3() {
        print("baseOperation3")
    }

    func hook1() {}
    func hook2() {}
}

class ConcreteClass1: AbstractClass {
    func requiredOperations1() {
        print("ConcreteClass1 requiredOperations1")
    }

    func requiredOperation2() {
        print("ConcreteClass1 requiredOperation2")
    }

    func hook2() {
        print("ConcreteClass1 hook2")
    }
}

class ConcreteClass2: AbstractClass {
    func requiredOperations1() {
        print("ConcreteClass2 requiredOperations1")
    }

    func requiredOperation2() {
        print("ConcreteClass2 requiredOperation2")
    }

    func hook1() {
        print("ConcreteClass2 hook1")
    }
}
