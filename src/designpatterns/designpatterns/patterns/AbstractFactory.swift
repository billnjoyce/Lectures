//
//  AbstractFactory.swift
//  designpatterns
//
//  Created by billkim on 18/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

protocol AbstractFactory {
    func createProduct1() -> AbstractProduct
    func createProduct2() -> AbstractProduct
}

class ConcreteFactory1 : AbstractFactory{
    func createProduct1() -> AbstractProduct {
        return ProductA1()
    }
    
    func createProduct2() -> AbstractProduct {
        return ProductA2()
    }
}

class ConcreteFactory2 : AbstractFactory{
    func createProduct1() -> AbstractProduct {
        return ProductB1()
    }
    
    func createProduct2() -> AbstractProduct {
        return ProductB2()
    }
}

protocol AbstractProduct {
    func useProduct() -> String
}

class AbstractProductA : AbstractProduct {
    func useProduct() -> String { return "" }
}

class AbstractProductB : AbstractProduct {
    func useProduct() -> String { return "" }
}

class ProductA1 : AbstractProductA {
    override init() {
        print("ProductA1 init")
    }
    
    override func useProduct() -> String {
        print("ProductA1 useProduct")
        return "ProductA1 useProduct\n"
    }
}

class ProductA2 : AbstractProductA {
    override init() {
        print("ProductA2 init")
    }
    
    override func useProduct() -> String {
        print("ProductA2 useProduct")
        return "ProductA2 useProduct\n"
    }
}

class ProductB1 : AbstractProductB {
    override init() {
        print("ProductB1 init")
    }
    
    override func useProduct() -> String {
        print("ProductB1 useProduct")
        return "ProductB1 useProduct\n"
    }
}

class ProductB2 : AbstractProductB {
    override init() {
        print("ProductB2 init")
    }
    
    override func useProduct() -> String {
        print("ProductB2 useProduct")
        return "ProductB2 useProduct\n"
    }
}

class ClientAbstractFactory : Client {
    func makePattern() -> Pattern {
        return PatternAbstractFactory()
    }
}

class PatternAbstractFactory : Pattern {
    func run() -> String {
        var result = ""
        
        let factory1 = ConcreteFactory1()
        let productA1 = factory1.createProduct1() // ProductA1 init
        result += "ProductA1 init\n"
        let productA2 = factory1.createProduct2() // ProductA2 init
        result += "ProductA2 init\n"
        
        let factory2 = ConcreteFactory2()
        let productB1 = factory2.createProduct1() // ProductB1 init
        result += "ProductB1 init\n"
        let productB2 = factory2.createProduct2() // ProductB2 init
        result += "ProductBa init\n"
        
        result += productA1.useProduct() // ProductA1 useProduct
        result += productA2.useProduct() // ProductA1 useProduct
        result += productB1.useProduct() // ProductB1 useProduct
        result += productB2.useProduct() // ProductB2 useProduct
        
        return result
    }
}
