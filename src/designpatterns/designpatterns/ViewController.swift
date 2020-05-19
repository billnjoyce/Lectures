//
//  ViewController.swift
//  designpatterns
//
//  Created by billkim on 18/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 싱글톤(Singleton) 패턴
        // testSingleton()
        
        // 프로토타입(Prototype) 패턴
        //testPrototype()
        
        // 팩토리(Factory) 패턴
        //testFactory()
        
        // 팩토리 메소드(Factory Mehtod) 패턴
        //testFactoryMethod()
        
        // 추상 팩토리(Abstract Factory) 패턴
        //testAbstractFactory()
        
        // 빌더(Builder) 패턴
        //testBuilder()
        
        // 어댑터(Adapter) 패턴
        //testAdapter()
        
        // 퍼사드(Facade) 패턴
        //testFacade()
        
        // 데코레이터(Decorator) 패턴
        //testDecorator()
        
        // 컴포지트(Composite) 패턴
        testComposite()
    }

    func testSingleton()
    {
        SingletonA.sharedInstance.test()
        SingletonA.sharedInstance.test()
        
        // Print SingletonA init
        // Print SingletonA test
        // Print SingletonA test
        
        // var a:SingletonA = SingletonA() // 컴파일 에러, 외부에서 생성 및 초기화 불가
        
        SingletonB.sharedInstance.test()
        SingletonB.sharedInstance.test()
        
        // Print SingletonB init
        // Print SingletonB test
        // Print SingletonB test
        
        // var b:SingletonB = SingletonB() // 컴파일 에러, 외부에서 생성 및 초기화 불가
    }
    
    func testPrototype()
    {
        func concretePrototype(prototype: Prototype) -> Prototype
        {
            // Client는 구체적인 ConcretePrototype 객체 접근 불필요
            // 모든 ConcretePrototype 객체에 대해 알 필요가 없다.
            // 새로운 ConcretePrototype 객체가 추가되더라도 객체 생성 시 수정이 불필요
            
            let newPrototype = prototype.clone()
            return newPrototype
        }
        
        let clientA = concretePrototype(prototype: ConcretePrototypeA())
        clientA.operation(value: 10)
        // ConcretePrototypeA clone
        // ConcretePrototypeA operation - value : 10
        
        let clientB = concretePrototype(prototype: ConcretePrototypeB())
        clientB.operation(value: 10)
        // ConcretePrototypeB clone
        // ConcretePrototypeB operation - value : 20
    }
    
    func testFactory()
    {
        let factory = Factory()
        
        let pen = factory.makePen() // Pen init
        pen.make() // Make a pen.
        
        let pencil = factory.makePencil() // Pencil init
        pencil.make() // Make a pencil.
    }
    
    func testFactoryMethod()
    {
        func concreteClient(creator: Creator) {
            creator.someOperation()
        }
        
        concreteClient(creator: ConcreteCreator1())
        // ConcreteProduct1 operation
        
        concreteClient(creator: ConcreteCreator2())
        // ConcreteProduct2 operation
    }
    
    func testAbstractFactory()
    {
        let factory1 = ConcreteFactory1()
        let productA1 = factory1.createProduct1() // ProductA1 init
        let productA2 = factory1.createProduct2() // ProductA2 init
        
        let factory2 = ConcreteFactory2()
        let productB1 = factory2.createProduct1() // ProductB1 init
        let productB2 = factory2.createProduct2() // ProductB2 init
        
        productA1.useProduct() // ProductA1 useProduct
        productA2.useProduct() // ProductA1 useProduct
        productB1.useProduct() // ProductB1 useProduct
        productB2.useProduct() // ProductB2 useProduct
    }
    
    func testBuilder()
    {
        let product1 = Director(builder:ConCreateBuilderA()).build()
        print("product1.value1 : \(product1.getProduct().value1)") // product1.value1 : 1
        
        let product2 = Director(builder:ConCreateBuilderB()).build()
        print("product2.value1 : \(product2.getProduct().value1)") // product2.value1 : 10
        
        let product3 = Director(builder:ConCreateBuilderB()).build()
        
        // 체이닝 방식으로 각 속성 재설정 가능
        product3.setValue1(value: 100).setValue2(value: 200).setValue3(value: 300)
        print("product3.value1 : \(product3.getProduct().value1)") // product3.value1 : 100
    }
    
    func testAdapter()
    {
        let adaptee = Adaptee()
        print(adaptee.specificRequest()) // Adaptee's specificRequest.
        
        ClientAdapter.specificRequest(target: Adapter(adaptee)) // Call from adapter - Adaptee's specificRequest.
    }
    
    func testFacade()
    {
        let facade = Facade(subsystem1: Subsystem1(), subsystem2: Subsystem2())
        print(facade.operation())
        
        // Facade initializes subsystems:
        // Sybsystem1: Ready!
        // Sybsystem2: Get ready!

        // Facade orders subsystems to perform the action:
        // Sybsystem1: Go!
        // Sybsystem2: Fire!
    }
    
    func testDecorator()
    {
        let component = ConcreteComponent()
        print("Result: " + component.operation()) // Result: ConcreteComponent operation
        
        let decorator1 = ConcreteDecoratorA(component)
        print("Result: " + decorator1.operation()) // Result: ConcreteDecoratorA(ConcreteComponent operation)
        
        let decorator2 = ConcreteDecoratorB(decorator1)
        print("Result: " + decorator2.operation()) // Result: ConcreteDecoratorB(ConcreteDecoratorA(ConcreteComponent operation))
    }
    
    func testComposite()
    {
        let tree = Composite()
        print("Tree : " + tree.operation())
        // Tree : Branch()
        
        let branch1 = Composite()
        branch1.add(component: Leaf())
        branch1.add(component: Leaf())

        let branch2 = Composite()
        branch2.add(component: Leaf())

        tree.add(component: branch1)
        print("Tree : " + tree.operation())
        // Tree : Branch(Branch(Leaf Leaf))
        
        tree.add(component: branch2)
        print("Tree : " + tree.operation())
        // Tree : Branch(Branch(Leaf Leaf) Branch(Leaf))
        
        tree.add(component: Leaf())
        print("Tree : " + tree.operation())
        // Tree : Branch(Branch(Leaf Leaf) Branch(Leaf) Leaf)
        
        tree.remove()
        print("Tree(remove) : " + tree.operation())
        // Tree(remove) : Branch(Branch(Leaf Leaf) Branch(Leaf))
        
        tree.remove()
        print("Tree(remove) : " + tree.operation())
        // Tree(remove) : Branch(Branch(Leaf Leaf))
        
        tree.remove()
        print("Tree(remove) : " + tree.operation())
        // Tree(remove) : Branch()
    }
}

