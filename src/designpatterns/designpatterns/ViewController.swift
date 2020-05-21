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
        //testComposite()
        
        // 브릿지(Bridge) 패턴
        //testBridge()
        
        // 플라이웨이트(Flyweight) 패턴
        //testFlyweight()
        
        // 프록시(Proxy) 패턴
        //testProxy()
        
        // 옵저버(Observer) 패턴
        //testObserver()
        
        // 스트래티지(Strategy) 패턴
        //testStrategy()
        
        // 커맨드(Command) 패턴
        //testCommand()
        
        // 반복자(Iterator) 패턴
        //testIterator()
        
        // 중재자(Mediator) 패턴
        //testMediator()
        
        // 상태(State) 패턴
        //testState()
        
        // 템플릿 메소드(Template Method) 패턴
        //testTemplateMethod()
        
        // 방문자(Visitor) 패턴
        //testVisitor()
        
        // 책임 연쇄 패턴(Chain of Responsibility) 패턴
        //testCoR()
        
        // 메멘토(Memento) 패턴
        testMemento()
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
    
    func testBridge()
    {
        let sedan = Sedan()
        let redSedan = RedCar(car: sedan)
        
        redSedan.drive()
        
        // It's a red color sedan.
        // Drive a sedan
    }
    
    func testFlyweight()
    {
        func addCarToPoliceDatabase(
                _ factory: FlyweightFactory,
                _ plates: String,
                _ owner: String,
                _ car: [String]) {

            print("Client: Adding a car to database.\n")

            let flyweight = factory.getFlyweight(for: car)

            flyweight.operation(uniqueState: [plates, owner])
        }
        
        let factory = FlyweightFactory(states:
        [
            ["Chevrolet", "Camaro2018", "pink"],
            ["Mercedes Benz", "C300", "black"],
            ["Mercedes Benz", "C500", "red"],
            ["BMW", "M5", "red"],
            ["BMW", "X6", "white"]
        ])

        factory.printFlyweights()
        // FlyweightFactory: I have 5 flyweights:

        // Mercedes Benz C300 black
        // BMW M5 red
        // BMW X6 white
        // Chevrolet Camaro2018 pink
        // Mercedes Benz C500 red
        
        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                ["BMW", "M5", "red"])

        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                ["BMW", "X1", "red"])

        factory.printFlyweights()
        
        // BMW X6 white
        // BMW X1 red
        // Mercedes Benz C300 black
        // Mercedes Benz C500 red
        // Chevrolet Camaro2018 pink
        // BMW M5 red
    }
    
    func testProxy()
    {
        func clientProxy(subject: Subject) {
            subject.request()
        }
        
        let realSubject = RealSubject()
        clientProxy(subject: realSubject)
        // RealSubject request.
        
        let proxy = Proxy(realSubject)
        clientProxy(subject: proxy)
        // Proxy request.
        // RealSubject request.
    }
    
    func testObserver()
    {
        let subject = ObserverSubject()

        let observer1 = ConcreteObserverA()
        let observer2 = ConcreteObserverB()

        subject.attach(observer1) // Subject: Attached an observer.
        subject.attach(observer2) // Subject: Attached an observer.

        subject.updateState()
        // ConcreteObserverA - updated a state : 6
        // ConcreteObserverB - updated a state : 6
        
        subject.updateState()
        // ConcreteObserverA - updated a state : 1
        // ConcreteObserverB - updated a state : 1
        
        subject.detach(observer2) // Subject: Detached an observer.
        
        subject.updateState()
        // ConcreteObserverA - updated a state : 9
    }
    
    func testStrategy()
    {
        let context = Context(strategy: ConcreteStrategyA())
        print("Client: Strategy is set to normal sorting.")
        context.doSomeBusinessLogic() // a,b,c,d,e

        print("\nClient: Strategy is set to reverse sorting.")
        context.update(strategy: ConcreteStrategyB())
        context.doSomeBusinessLogic() // e,d,c,b,a
    }
    
    func testCommand()
    {
        let invoker = Invoker()
        invoker.setOnStart(SimpleCommand("Say Hi!"))

        let receiver = Receiver()
        invoker.setOnFinish(ComplexCommand(receiver, "Send email", "Save report"))
        
        // 호출자의 실행 함수를 수정을 할 필요없이 ConcreteCommand 내의 receiver 객체를 통하여 다양한 행위를 할 수 있다.
        invoker.doSomethingImportant()
        
        // SimpleCommand: See, I can do simple things like printing (Say Hi!)
        // ComplexCommand: Complex stuff should be done by a receiver object.
        // Receiver: Working on (Send email)
        // Receiver: Also working on (Save report)
    }
    
    func testIterator()
    {
        let words = ConcreteCollectionA()
        words.append("First")
        words.append("Second")
        words.append("Third")
        
        words.makeIterator()
        
        let numbers = ConcreteCollectionB()
        numbers.append(1)
        numbers.append(2)
        numbers.append(3)

        let iterator1 = words.makeIterator()
        
        while (iterator1.hasNext()) {
            print(iterator1.next()!)
            // First
            // Second
            // Third
        }
        
        let iterator2 = numbers.makeIterator()
        
        while (iterator2.hasNext()) {
            print(iterator2.next()!)
            // 1
            // 2
            // 3
        }
        
        let iterator3 = ConcreteIterator(words)
        
        while (true) {
            guard let collection = iterator3.next() else { break }
            print(collection)
            // First
            // Second
            // Third
        }
        
        let iterator4 = ConcreteIterator(numbers)
        
        while (true) {
            guard let collection = iterator4.next() else { break }
            print(collection)
            // 1
            // 2
            // 3
        }
    }
    
    func testMediator()
    {
        let component1 = Component1()
        let component2 = Component2()

        let mediator = ConcreteMediator(component1, component2)
        
        component1.operationA()
        // operationA
        // operationC

        component2.operationD()
        // operationD
        // operationB
        // operationC
    }
    
    func testState()
    {
        let context = ContextState(ConcreteStateA())
        
        context.request1() // ConcreteStateA handles request1.
        context.request1() // ConcreteStateB handles request1.
        
        context.request2() // ConcreteStateB handles request2.
        context.request2() // ConcreteStateA handles request2.
    }
    
    func testTemplateMethod()
    {
        let template1 = ConcreteClass1()
        template1.templateMethod()
        
        // baseOperation1
        // ConcreteClass1 requiredOperations1
        // baseOperation2
        // ConcreteClass1 requiredOperation2
        // baseOperation3
        // ConcreteClass1 hook2
        
        let template2 = ConcreteClass2()
        template2.templateMethod()
        
        // baseOperation1
        // ConcreteClass2 requiredOperations1
        // baseOperation2
        // ConcreteClass2 hook1
        // ConcreteClass2 requiredOperation2
        // baseOperation3
    }
    
    func testVisitor()
    {
        func visit(elements: [Element], visitor: Visitor) {
            /* for element in elements
            {
                element.accept(visitor)
            }*/
    
            elements.forEach({ $0.accept(visitor) })
        }
        
        let elements: [Element] = [ConcreteElementA(), ConcreteElementB()]
        
        let visitor1 = ConcreteVisitor1()
        visit(elements: elements, visitor: visitor1)
        // A + ConcreteVisitor1
        // B + ConcreteVisitor1
        
        let visitor2 = ConcreteVisitor2()
        visit(elements: elements, visitor: visitor2)
        // A + ConcreteVisitor2
        // B + ConcreteVisitor2
    }
    
    func testCoR()
    {
        func handler(handler: Handler) {

            let food = ["Nut", "Banana", "Fish"]

            food.forEach({ let result = handler.handle(request: $0)
                if(result == nil) {
                    print($0 + " was left untouched.")
                }
                else {
                    print(result!)
                }})
        }
        
        let monkey = MonkeyHandler()
        let dog = DogHandler()
        let cat = CatHandler()
        
        monkey.setNext(handler: dog).setNext(handler: cat)

        // Chain: Monkey > Dog > Cat
        handler(handler: monkey)
        
        // Nut was left untouched.
        // Monkey : I'll eat the Banana
        // Cat : I'll eat the Fish
        
        // Subchain: Dog > Cat
        handler(handler: dog)
        
        // Nut was left untouched.
        // Banana was left untouched.
        // Cat : I'll eat the Fish
    }
    
    func testMemento()
    {
        let originator = Originator(state: "Super-duper-super-puper-super.")
        // Originator: My initial state is: Super-duper-super-puper-super.
        
        let caretaker = Caretaker(originator: originator)
        
        caretaker.backup()
        // Saving Originator's state...
        
        originator.doSomething()
        // Originator: I'm doing something important.
        // Originator: and my state has changed to: B147
        
        caretaker.backup()
        // Saving Originator's state...
        
        originator.doSomething()
        // Originator: I'm doing something important.
        // Originator: and my state has changed to: 20B2
        
        caretaker.backup()
        // Saving Originator's state...
        
        caretaker.showHistory()
        // Super-duper-super-puper-super. 08:22:02
        // B147 08:22:02
        // 20B2 08:22:02
        
        caretaker.undo()
        // Restoring state to: 20B2 08:22:31
        // Originator: My state has changed to: 20B2
        
        caretaker.undo()
        // Restoring state to: B147 08:22:31
        // Originator: My state has changed to: B147
        
        caretaker.undo()
        // Caretaker: Restoring state to: Super-duper-super-puper-super. 08:22:31
        // Originator: My state has changed to: Super-duper-super-puper-super.
    }
}
