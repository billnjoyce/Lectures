//
//  Builder.swift
//  designpatterns
//
//  Created by billkim on 19/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation
import UIKit

class BuilderProduct {
    var value1: Int = 0
    var value2: Int = 0
    var value3: Int = 0
}

protocol Builder {
    var product:BuilderProduct { get set }
    
    func build() -> Builder
    func getProduct() -> BuilderProduct
    
    func setValue1(value: Int) -> Builder
    func setValue2(value: Int) -> Builder
    func setValue3(value: Int) -> Builder
}

class ConCreateBuilderA : Builder {
    var product = BuilderProduct()
    
    func getProduct() -> BuilderProduct {
        return product
    }
    
    func build() -> Builder
    {
        setValue1(value: 1)
        setValue2(value: 2)
        setValue2(value: 3)
        
        return self
    }
    
    func setValue1(value: Int) -> Builder {
        product.value1 = value
        print("setValue1 : \(value)")
        return self
    }
    
    func setValue2(value: Int) -> Builder {
        product.value2 = value
        print("setValue2 : \(value)")
        return self
    }
    
    func setValue3(value: Int) -> Builder {
        product.value3 = value
        print("setValue3 : \(value)")
        return self
    }
}

class ConCreateBuilderB : Builder {
    var product = BuilderProduct()
    
    func getProduct() -> BuilderProduct {
        return product
    }
    
    func build() -> Builder
    {
        setValue1(value: 10)
        setValue2(value: 20)
        setValue2(value: 30)
        
        return self
    }
    
    func setValue1(value: Int) -> Builder {
        product.value1 = value
        print("setValue1 : \(value)")
        return self
    }
    
    func setValue2(value: Int) -> Builder {
        product.value2 = value
        print("setValue2 : \(value)")
        return self
    }
    
    func setValue3(value: Int) -> Builder {
        product.value3 = value
        print("setValue3 : \(value)")
        return self
    }
}

class Director {
    var builder: Builder
    
    init(builder: Builder) {
        self.builder = builder
    }
    
    func build() -> Builder {
        return builder.build()
    }
}

class ClientBuilder : Client {
    func makePattern() -> Pattern {
        return PatternBuilder()
    }
}

class PatternBuilder : Pattern {
    func run() -> String {
        var result = ""
        
        let product1 = Director(builder:ConCreateBuilderA()).build()
        print("product1.value1 : \(product1.getProduct().value1)") // product1.value1 : 1
        result += "product1.value1 : \(product1.getProduct().value1)\n"
        
        let product2 = Director(builder:ConCreateBuilderB()).build()
        print("product2.value1 : \(product2.getProduct().value1)") // product2.value1 : 10
        result += "product2.value1 : \(product2.getProduct().value1)\n"
        
        let product3 = Director(builder:ConCreateBuilderB()).build()
        
        // 체이닝 방식으로 각 속성 재설정 가능
        product3.setValue1(value: 100).setValue2(value: 200).setValue3(value: 300)
        print("product3.value1 : \(product3.getProduct().value1)") // product3.value1 : 100
        result += "product3.value1 : \(product3.getProduct().value1)\n"
        
        return result
    }
}
