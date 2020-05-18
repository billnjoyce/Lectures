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
    func useProduct()
}

class AbstractProductA : AbstractProduct {
    func useProduct() { }
}

class AbstractProductB : AbstractProduct {
    func useProduct() { }
}

class ProductA1 : AbstractProductA {
    override init() {
        print("ProductA1 init")
    }
    
    override func useProduct() {
        print("ProductA1 useProduct")
    }
}

class ProductA2 : AbstractProductA {
    override init() {
        print("ProductA2 init")
    }
    
    override func useProduct() {
        print("ProductA2 useProduct")
    }
}

class ProductB1 : AbstractProductB {
    override init() {
        print("ProductB1 init")
    }
    
    override func useProduct() {
        print("ProductB1 useProduct")
    }
}

class ProductB2 : AbstractProductB {
    override init() {
        print("ProductB2 init")
    }
    
    override func useProduct() {
        print("ProductB2 useProduct")
    }
}
