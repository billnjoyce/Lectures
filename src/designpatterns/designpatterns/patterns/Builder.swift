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
