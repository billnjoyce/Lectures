# Itroduction
----------------------- 

Swift와 함께 디자인 패턴에 대한 개념 및 종류에 대해서 살펴봅니다.


주요 강좌 및 개념
-----------------------  

* [Singleton](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Singleton.pdf)

> Singleton(싱글톤) 패턴은 객체 생성과 관련한 디자인 패턴으로서 객체 생성을 단한번만 생성하여 어디서든 참조하여 사용할 수 있도록 도와주는 디자인 패턴입니다.

```javascript
class SingletonA {
    static let sharedInstance = SingletonA()

    private init() {
        print("SingletonA init");
    }
    
    func test() {
        print("SingletonA test");
    }
}

SingletonA.sharedInstance.test()
SingletonA.sharedInstance.test()
        
// Print SingletonA init
// Print SingletonA test
// Print SingletonA test
        
var a:SingletonA = SingletonA() // 컴파일 에러, 외부에서 생성 및 초기화 불가
```
         
* [Prototype](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Prototype.pdf)

> 프로토타입 패턴은 원형이 되는 인스턴스를 사용하여 생성할 객체의 종류를 명시하고, 이렇게 만든 견본을 복사해서 새롭게 객체를 생성하여 사용하는 패턴입니다.
> 구체 클래스를 알 수 없는 경우에도 객체를 복사할 수 있는 공통된 인터페이스를 제공합니다.


```javascript
protocol Prototype {
    func operation(value: Int)
   func clone() -> Prototype
}

class ConcretePrototypeA : Prototype {
    init() { }
    init(client: ConcretePrototypeA) { }
    
    func operation(value: Int) { print("ConcretePrototypeA operation - value : \(value)") }
    
    func clone() -> Prototype {
        print("ConcretePrototypeA clone")
        return ConcretePrototypeA(client: self)
    }
}

class ConcretePrototypeB : Prototype {
    init() { }
    init(client: ConcretePrototypeB) { }
    
    func operation(value: Int) { print("ConcretePrototypeB operation - value : \(value*2)") }
    
    func clone() -> Prototype {
        print("ConcretePrototypeB clone")
        return ConcretePrototypeB(client: self)
    }
}

// Usage
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
```

* [Factory](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Factory.pdf)

> Factory(팩토리) 디자인 패턴은 객체 생성과 관련된 디자인 패턴으로서 사용자에게 객체 생성 로직을 노출하지 않은채 객체를 생성하기 위해서 제공되는 패턴입니다.
> 사용자는 단순히 필요한 객체의 생성 로직을 신경쓰지 않고 특정 객체에 대해서 가져올 수 있습니다.

```javascript

class Factory {
    func makePen() -> Pen {
        return Pen()
    }
    
    func makePencil() -> Pencil {
        return Pencil()
    }
}

class Pen {
    init() {
        print("Pen init")
    }
    
    func make() {
        print("Make a pen.")
    }
}

class Pencil {
    init() {
        print("Pencil init")
    }
    
    func make() {
        print("Make a pencil.")
    }
}

let factory = Factory()
        
let pen = factory.makePen() // Pen init
pen.make() // Make a pen.
        
let pencil = factory.makePencil() // Pencil init
pencil.make() // Make a pencil.
```

* [Factory Method](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Factory%20Method.pdf)

> Factory Mthod(팩토리 매소드) 디자인 패턴은 객체 생성을 위해 인터페이스는 정의하지만 어떤 클래스의 인스턴스를 생성할 지에 결정은 서브클래스가 정의하도록 해주는 디자인 패턴입니다.
> 팩토리 메서드는 직접 인스턴스를 생성하는 대신 생성을 위한 메서드를 인터페이스로 제공합니다. 서브 클래스는 생성될 객체의 클래스를 변경하기 위해서 메서드를 재정의 할 수 있습니다.

```javascript
// Creator
protocol Creator {
    func factoryMethod() -> Product
    func someOperation() -> String
}

extension Creator {
    func someOperation() -> String {
        let product = factoryMethod()
        return product.operation()
    }
}

// Product
protocol Product {
    func operation() -> String
}

// Concrete Creators
class ConcreteCreator1: Creator {
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    public func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}

// Concrete Products
class ConcreteProduct1: Product {
    func operation() -> String {
        print("ConcreteProduct1 operation")
        return "ConcreteProduct1 operation"
    }
}

class ConcreteProduct2: Product {
    func operation() -> String {
        print("ConcreteProduct2 operation")
        return "ConcreteProduct2 operation"
    }
}

func concreteClient(creator: Creator) {
    creator.someOperation()
}

concreteClient(creator: ConcreteCreator1())
// ConcreteProduct1 operation

concreteClient(creator: ConcreteCreator2())
// ConcreteProduct2 operation
```

* [Abstract Factory](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Abstract%20Factory.pdf)

> Abstract Factory(추상 팩토리) 디자인 패턴은 연관된 혹은 의존성이 있는 객체의 그룹을 구체적인 클래스를 지정하지 않고 생성하기 위해서 사용하는 패턴입니다.
> 결국 객체 생성을 추상화하여 이를 사용하는 모듈과 독립적인 인터페이스를 정의할 수 있습니다.

```javascript
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
```

* [Builder](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Builder.pdf)

> Builder(빌더) 디자인 패턴은 복합 객체의 생성 과정과 표현 방법을 분리하여 동일한 생성 절차를 통하여 서로 다른 결과를 만들 수 있게 해주는 패턴입니다.
> 즉 생성 절차는 항상 동일하되 결과는 다르게 만들어주는 디자인 패턴입니다. 또한 객체 내의 여러 속성들에 대해서 체이닝 형식으로 생성할 수도 있습니다.

```javascript
class Product {
    var value1: Int = 0
    var value2: Int = 0
    var value3: Int = 0
}

protocol Builder {
    var product:Product { get set }
    
    func build() -> Builder
    func getProduct() -> Product
    
    func setValue1(value: Int) -> Builder
    func setValue2(value: Int) -> Builder
    func setValue3(value: Int) -> Builder
}

class ConCreateBuilderA : Builder {
    var product = Product()
    
    func getProduct() -> Product {
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
       return self
    }
    
    func setValue2(value: Int) -> Builder {
       product.value2 = value
       return self
    }
    
    func setValue3(value: Int) -> Builder {
       product.value3 = value
       return self
    }
}

class ConCreateBuilderB : Builder {
    var product = Product()
    
    func getProduct() -> Product {
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
       return self
    }
    
    func setValue2(value: Int) -> Builder {
       product.value2 = value
       return self
    }
    
    func setValue3(value: Int) -> Builder {
       product.value3 = value
       return self
    }
}

class Director {
    var builder: Builder
    
    init(builder: Builder) {
        self.builder = builder
    }
    
    // Construct
    func build() -> Builder {
        return builder.build()
    }
}

let product1 = Director(builder:ConCreateBuilderA()).build()
print("product1.value1 : \(product1.getProduct().value1)") 
// product1.value1 : 1
        
let product2 = Director(builder:ConCreateBuilderB()).build()
print("product2.value1 : \(product2.getProduct().value1)") 
// product2.value1 : 10
        
let product3 = Director(builder:ConCreateBuilderB()).build()
        
// 체이닝 방식으로 각 속성 재설정 가능
product3.setValue1(value: 100).setValue2(value: 200).setValue3(value: 300)
print("product3.value1 : \(product3.getProduct().value1)") 
// product3.value1 : 100
```

* [Adapter](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Adapter.pdf)

> Adapter(어댑터) 디자인 패턴은 호환되지 않는 인터페이스를 가진 두 개의 객체가 함께 동작할 수 있도록 해주는 구조 설계 패턴입니다.
> 즉 특정 객체의 인터페이스를 변환하여 다른 객체에 적응시켜 사용할 수 있게 도와줍니다.

```javascript
class Target {
    func request() -> String {
        return ""
    }
}

class Adaptee {
    public func specificRequest() -> String {
        return "Adaptee's specificRequest."
    }
}

class Adapter: Target {
    private var adaptee: Adaptee

    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }

    override func request() -> String {
        return self.adaptee.specificRequest()    }
}

class Client {
    static func specificRequest(target: Target) {
        print("Call from adapter - \(target.request())")
    }
}

let adaptee = Adaptee()

print(adaptee.specificRequest()) 
// Adaptee's specificRequest.
        
Client.specificRequest(target: Adapter(adaptee)) 
// Call from adapter - Adaptee's specificRequest.
```

* [Facade](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Facade.pdf)

> Facade(퍼사드) 디자인 패턴은 복잡한 클래스 시스템에 대해서 간단한 인터페이스를 제공해주는 구조 설계 관련 디자인 패턴입니다.
> Facade 패턴은 많은 클래스를 포함하는 복잡한 서브 시스템을 사용하기 위한 간단한 인터페이스를 제공합니다. 

```javascript
class Subsystem1 {
    func operation1() -> String {
        return "Sybsystem1: Ready!\n"
    }

    func operationN() -> String {
        return "Sybsystem1: Go!\n"
    }
}

class Subsystem2 {
    func operation1() -> String {
        return "Sybsystem2: Get ready!\n"
    }

    func operationZ() -> String {
        return "Sybsystem2: Fire!\n"
    }
}

class Facade {
    private var subsystem1: Subsystem1
    private var subsystem2: Subsystem2

    init(subsystem1: Subsystem1 = Subsystem1(),
         subsystem2: Subsystem2 = Subsystem2()) {
        self.subsystem1 = subsystem1
        self.subsystem2 = subsystem2
    }

    func operation() -> String {
        
        var result = "Facade initializes subsystems:\n"
        result += " " + subsystem1.operation1()
        result += " " + subsystem2.operation1()
        result += "\n" + "Facade orders subsystems to perform the action:\n"
        result += " " + subsystem1.operationN()
        result += " " + subsystem2.operationZ()
        
        return result
    }
}

let facade = Facade(subsystem1: Subsystem1(), subsystem2: Subsystem2())
print(facade.operation())
        
// Facade initializes subsystems:
// Sybsystem1: Ready!
// Sybsystem2: Get ready!

// Facade orders subsystems to perform the action:
// Sybsystem1: Go!
// Sybsystem2: Fire!
```

* [Decorator](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Decorator.pdf)

> Decorator(데코레이터) 디자인 패턴은 특정 객체에 대해서 새로운 기능을 동적(Run-time)으로 추가하기 위한 구조 설계 패턴입니다.
> 객체에 동적으로 기능을 추가하고 코드의 추가를 숨기고 싶은 경우 사용하면 좋습니다.

```javascript
protocol Component {
    func operation() -> String
}

class ConcreteComponent: Component {
    func operation() -> String {
        return "ConcreteComponent operation"
    }
}

class Decorator : Component {
    private var component: Component

    init(_ component: Component) {
        self.component = component
    }

    func operation() -> String {
        return component.operation()
    }
}

class ConcreteDecoratorA : Decorator {
    override func operation() -> String {
        return "ConcreteDecoratorA(" + super.operation() + ")"
    }
}

class ConcreteDecoratorB : Decorator {
    override func operation() -> String {
        return "ConcreteDecoratorB(" + super.operation() + ")"
    }
}

let component = ConcreteComponent()
print("Result: " + component.operation()) 
// Result: ConcreteComponent operation
        
let decorator1 = ConcreteDecoratorA(component)
print("Result: " + decorator1.operation()) 
// Result: ConcreteDecoratorA(ConcreteComponent operation)
        
let decorator2 = ConcreteDecoratorB(decorator1)
print("Result: " + decorator2.operation()) 
// Result: ConcreteDecoratorB(ConcreteDecoratorA(ConcreteComponent operation))
```

* [Composite](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Composite.pdf)

> Composite(컴포지트)패턴은 클라이언트가 복합 객체(group of object) 나 단일 객체를 동일하게 취급하는 것을 목적으로 하는 패턴입니다.
> 즉, 전체-부분의 관계(Ex. Directory-File)를 갖는 객체들 사이의 관계를 정의할 때 유용합니다.
> 또한 클라이언트는 전체와 부분을 구분하지 않고 동일한 인터페이스를 사용할 수 있습니다.

```javascript
protocol Component {
    var parent: Component? { get set }

    func add(component: Component)
    func remove(component: Component)

    func isComposite() -> Bool
    func operation() -> String
}

extension Component {
    func add(component: Component) {}
    func remove(component: Component) {}
    func isComposite() -> Bool {
        return false
    }
}

class Leaf : Component {
    var parent: Component?

    func operation() -> String {
        return "Leaf"
    }
}

class Composite : Component {
    var parent: Component?

    private var children = [Component]()

    func add(component: Component) {
        var item = component
        item.parent = self
        children.append(item)
    }

    func remove(component: Component) {
        if children.count > 0 {
            children.removeLast()
        }    
    }

    func isComposite() -> Bool {
        return true
    }

    func operation() -> String {
        /*
            let result = children.map( { (component: Component) -> String in
                return component.operation()
            })
        */
        let result = children.map({ $0.operation() })
        
        return "Branch(" + result.joined(separator: " ") + ")"
    }
}

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
```

* [Bridge](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Bridge.pdf)

> Bridge(브릿지)패턴은 구현부에서 추상층을 분리하여 각자 독립적으로 변형이 가능하고 확장이 가능하도록 하는 패턴입니다.
> 즉 기능과 구현에 대해서 두 개의 별도의 클래스로 구현을 할 수 있도록 하는 구조 설계 관련 패턴입니다.
> Bridge 패턴은 객체의 다중 상속 구조를 피하면서 독립적으로 확장을 할 수 있도록 도와줍니다.

```javascript
// Implementor
protocol Car {
    // implementation()
    func drive()
}

// ConcreteImplementor
class Sedan : Car {
    // implementation()
    func drive() {
        print("Drive a sedan")
    }
}

// ConcreteImplementor
class SUV : Car {
    func drive() {
        print("Drive a SUV")
    }
}

// Abstraction
protocol ColoredCar {
    // implementor
    var car: Car { get set }
    
    // implementation()
    func drive()
}

// RefinedAbstraction
class RedCar: ColoredCar {
    // implementor
    var car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    // refinedFunction()
    func drive() {
        print("It's a red color sedan.")
        
        // self.impl.implementation()
        car.drive()
    }
}

let sedan = Sedan()
let redSedan = RedCar(car: sedan)
        
redSedan.drive()
        
// It's a red color sedan.
// Drive a sedan
```

* [Flyweight](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Flyweight.pdf)

> Flyweight 패턴은 객체의 내부에서 참조하는 객체를 직접 만드는 것이 아니라, 없다면 만들고 만들어져 있다면 객체를 공유하여 전달해주는 구조 관련 패턴입니다.
> Flyweight 패턴을 사용하면 객체의 할당에 사용되는 메모리를 줄일 수 있을 뿐 아니라, 객체를 생성하는 시간도 들지 않게 도와줍니다.

```javascript
class Flyweight {
    var sharedState: [String]
    init(sharedState: [String]) { self.sharedState = sharedState }
    func operation(uniqueState: [String]) { }
}

class ConcreteFlyweight : Flyweight {
    override func operation(uniqueState: [String]) {
        print("Flyweight: Displaying shared (\(sharedState)) and unique (\(uniqueState) state.\n")
    }
}

extension Array where Element == String {
    /// Returns a Flyweight's string hash for a given state.
    var key: String {
        return self.joined(separator: " ")
    }
}

class FlyweightFactory {
    private var flyweights: [String: Flyweight]

    init(states: [[String]]) {
        var flyweights = [String: Flyweight]() // Dictionary

        for state in states {
            flyweights[state.key] = Flyweight(sharedState: state)
        }

        self.flyweights = flyweights
    }

    func getFlyweight(for state: [String]) -> Flyweight {
        let key = state.key
        
        guard let foundFlyweight = flyweights[key] else {
            print("FlyweightFactory: Can't find a \(key), creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return flyweight
        }
        
        print("FlyweightFactory: Reusing existing \(key).\n")
        return foundFlyweight
    }

    func printFlyweights() {
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        
        for item in flyweights {
            print(item.key)
        }
    }
}

func addCarToPoliceDatabase(_ factory: FlyweightFactory, _ plates: String, _ owner: String, _ car: [String]) {
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
                       [“BMW", "X1", "red"])

factory.printFlyweights()

// BMW X6 white
// BMW X1 red
// Mercedes Benz C300 black
// Mercedes Benz C500 red
// Chevrolet Camaro2018 pink
// BMW M5 red
```

* [Proxy](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Proxy.pdf)

> Proxy(프록시)패턴은 실제 기능을 수행하는 객체(Real Object)(대신 가상의 객체(Proxy Object)를 사용해 로직의 흐름을 제어하는 디자인 패턴입니다.
> 즉 Proxy 객체를 이용하여 원래 객체의 변경없이 기능을 특정 방식을 제어할 수 있게 도와줍니다.

```javascript
protocol Subject {
    func request()
}

class RealSubject : Subject {
    func request() {
        print("RealSubject request.")
    }
}

class Proxy : Subject {
    private var realSubject: RealSubject

    init(_ realSubject: RealSubject) {
        self.realSubject = realSubject
    }

    func request() {
        print("Proxy request.")
        
        otherFunction()
    }

    private func otherFunction() { }
}

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
```

* [Observer](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Observer.pdf)

> Observer(옵저버) 패턴은 특정 객체에서 발생하는 이벤트를 구독자에게 전달하는 패턴입니다.
> Observer(옵저버) 패턴은 한 객체의 상태 변화에 따라 다른 객체의 상태도 연동 되도록 1 대 N 객체간 의존 관계를 구성하는 디자인 패턴입니다.

```javascript
// 구독할 주제 객체
class Subject {
    var state: Int = { return Int(arc4random_uniform(10)) }()
    private lazy var observers = [Observer]()

    func attach(_ observer: Observer) {
        print("Subject: Attached an observer.\n")
        observers.append(observer)
    }

    func detach(_ observer: Observer) {
        if let idx = observers.index(where: { $0 === observer }) {
            observers.remove(at: idx)
            print("Subject: Detached an observer.\n")
        }
    }

    func notify() {
        print("Subject: Notifying observers...\n")
        observers.forEach({ $0.update(subject: self)})
    }

    func updateState() {
        state = Int(arc4random_uniform(10))
        notify()
    }
}

// 구독자 부모 추상 객체
protocol Observer : class {
    func update(subject: ObserverSubject)
}

// 실제 구독을 하는 객체
class ConcreteObserverA : Observer {
    func update(subject: ObserverSubject) {
        print("ConcreteObserverA - updated a state : \(subject.state)\n")
    }
}

// 실제 구독을 하는 객체
class ConcreteObserverB : Observer {
    func update(subject: ObserverSubject) {
        print("ConcreteObserverB - updated a state : \(subject.state)\n")
    }
}

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
```

* [Strategy](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Strategy.pdf)

> Strategy 패턴은 클래스의 행위를 캡슐화 하여 동적으로 행위를 자유롭게 바꿀 수 있도록 돕는 패턴이다.
> Strategy 패턴은 특정한 계열의 알고리즘(행위) 및 동작을 정의하고 해당 알고리즘을 캡슐화하며 이 알고리즘들을 해당 계열 안에서 상호 교체가 가능하게 만들어 줍니다.

```javascript
class Context {
    private var strategy: Strategy

    init(strategy: Strategy) {
        self.strategy = strategy
    }

    func update(strategy: Strategy) {
        self.strategy = strategy
    }

    func doSomeBusinessLogic() {
        let result = strategy.doAlgorithm(["a", "b", "c", "d", "e"])
        print(result.joined(separator: ","))
    }
}

protocol Strategy {
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T]
}

class ConcreteStrategyA : Strategy {
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T] {
        return data.sorted()
    }
}

class ConcreteStrategyB : Strategy {
    func doAlgorithm<T: Comparable>(_ data: [T]) -> [T] {
        return data.sorted(by: >)
    }
}

let context = Context(strategy: ConcreteStrategyA())
print("Client: Strategy is set to normal sorting.")
context.doSomeBusinessLogic() // a,b,c,d,e

print("\nClient: Strategy is set to reverse sorting.")
context.update(strategy: ConcreteStrategyB())
context.doSomeBusinessLogic() // e,d,c,b,a
```

* [Command](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Command.pdf)

> Command 패턴은 실행될 기능을 캡슐화함으로써 주어진 여러 기능을 실행할 수 있는 재사용성이 높은 클래스를 설계하는 행위(Behavior) 패턴입니다.
> 즉, 이벤트가 발생했을 때 실행될 기능이 다양하면서도 변경이 필요한 경우에 이벤트를 발생시키는 클래스를 변경하지 않고 재사용하고자 할 때 유용합니다.
> 실행될 기능을 캡슐화함으로써 기능의 실행을 요구하는 호출자(Invoker) 클래스와 실제 기능을 실행하는 수신자(Receiver) 클래스 사이의 의존성을 제거합니다.

```javascript
protocol Command {
    func execute()
}

class SimpleCommand: Command {
    private var payload: String

    init(_ payload: String) {
        self.payload = payload
    }

    func execute() {
        print("SimpleCommand: See, I can do simple things like printing (" + payload + ")")
    }
}

class ComplexCommand: Command {
    private var receiver: Receiver

    private var a: String
    private var b: String

    init(_ receiver: Receiver, _ a: String, _ b: String) {
        self.receiver = receiver
        self.a = a
        self.b = b
    }

    func execute() {
        print("ComplexCommand: Complex stuff should be done by a receiver object.\n")
        receiver.doSomething(a)
        receiver.doSomethingElse(b)
    }
}

class Receiver {
    func doSomething(_ a: String) {
        print("Receiver: Working on (" + a + ")\n")
    }

    func doSomethingElse(_ b: String) {
        print("Receiver: Also working on (" + b + ")\n")
    }
}

class Invoker {
    private var onStart: Command?
    private var onFinish: Command?

    func setOnStart(_ command: Command) {
        onStart = command
    }

    func setOnFinish(_ command: Command) {
        onFinish = command
    }

    func doSomethingImportant() {
        onStart?.execute()
        onFinish?.execute()
    }
}

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
```

* [Iterator](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20iterator.pdf)

> Iterator(반복자) 패턴은 데이터의 타입(리스트, 스택, 트리 등)을 드러내지 않고 컬렉션 요소를 순회할 수 있는 행동 디자인 패턴입니다.
> Iterator(반복자) 패턴의 주요 아이디어는 컬렉션의 순회 동작을 별도의 반복자 객체로 분리하는 것입니다. 

```javascript
protocol Collection
{
    var items:[Any] { get set }
    func makeIterator() -> ConcreteIterator
}

class ConcreteCollectionA : Collection {
    var items = [Any]()

    func append(_ item: String) {
        self.items.append(item)
    }
    
    func makeIterator() -> ConcreteIterator {
        return ConcreteIterator(self)
    }
}

class ConcreteCollectionB : Collection {
    var items = [Any]()

    func append(_ item: Int) {
        self.items.append(item)
    }
    
    func makeIterator() -> ConcreteIterator {
        return ConcreteIterator(self)
    }
}

protocol Iterator {
    func next() -> Any?
    func hasNext() -> Bool
}

class ConcreteIterator : Iterator {
    private let collections : Collection
    private var index = 0

    init(_ collections: Collection) {
        self.collections = collections
    }

    func next() -> Any? {
        defer { index += 1 }
        return index < collections.items.count ? collections.items[index] : nil
    }
    
    func hasNext() -> Bool {
        if index < collections.items.count {
            return true
        }
        else {
            return false
        }
    }
}

let words = ConcreteCollectionA()
words.append("First")
words.append("Second")
words.append("Third")
               
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
```

* [Mediator](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Mediator.pdf)

> Mediator(미디에이터) 패턴은 복잡한 의존 관계를 줄이고자 할 때 유용한 행동 디자인 패턴입니다.
> 모든 클래스간의 복잡한 로직(상호작용)을 캡슐화하여 하나의 클래스에 위임하여 처리하는 패턴으로서 비슷한 패턴으로는 Facade 패턴과 Observer 패턴 등이 있습니다.

```javascript
protocol Mediator : AnyObject {
    func notify(sender: BaseComponent, event: String)
}

class ConcreteMediator : Mediator {
    private var component1: Component1
    private var component2: Component2

    init(_ component1: Component1, _ component2: Component2) {
        self.component1 = component1
        self.component2 = component2

        component1.update(mediator: self)
        component2.update(mediator: self)
    }

    func notify(sender: BaseComponent, event: String) {
        if event == "A" {
            self.component2.operationC()
        }
        else if (event == "D") {
            self.component1.operationB()
            self.component2.operationC()
        }
    }
}

class BaseComponent {
    fileprivate weak var mediator: Mediator?

    init(mediator: Mediator? = nil) {
        self.mediator = mediator
    }

    func update(mediator: Mediator) {
        self.mediator = mediator
    }
}

class Component1 : BaseComponent {
    func operationA() {
        print("operationA")
        mediator?.notify(sender: self, event: "A")
    }

    func operationB() {
        print("operationB")
        mediator?.notify(sender: self, event: "B")
    }
}

class Component2 : BaseComponent {
    func operationC() {
        print("operationC")
        mediator?.notify(sender: self, event: "C")
    }

    func operationD() {
        print("operationD")
        mediator?.notify(sender: self, event: "D")
    }
}

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
```

* [State](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20State.pdf)

> State(상태) 패턴은 객체 내부의 상태에 따라서 객체가 다른 행동을 할 수 있게 해주는 패턴입니다.
> 즉 객체의 상태만 변경해주어도 다른 행동을 하는 객체로 만들어줍니다.

```javascript
class Context {
    private var state: State

    init(_ state: State) {
        self.state = state
        changeState(state: state)
    }

    func changeState(state: State) {
        //print("change state to " + String(describing: state))
        self.state = state
        self.state.update(context: self)
    }

    func request1() {
        state.handle1()
    }

    func request2() {
        state.handle2()
    }
}

protocol State : class {
    func update(context: Context)

    func handle1()
    func handle2()
}

class ConcreteStateA : State {
    private(set) weak var context: Context?

    func update(context: Context) {
        self.context = context
    }
    
    func handle1() {
        print("ConcreteStateA handles request1.")
        context?.changeState(state: ConcreteStateB())
    }

    func handle2() {
        print("ConcreteStateA handles request2.\n")
    }
}

class ConcreteStateB : State {
    private(set) weak var context: Context?

    func update(context: Context) {
        self.context = context
    }
    
    func handle1() {
        print("ConcreteStateB handles request1.\n")
    }

    func handle2() {
        print("ConcreteStateB handles request2.")
        context?.changeState(state: ConcreteStateA())
    }
}

let context = Context(ConcreteStateA())
        
context.request1() // ConcreteStateA handles request1.
context.request1() // ConcreteStateB handles request1.
        
context.request2() // ConcreteStateB handles request2.
context.request2() // ConcreteStateA handles request2.
```

* [Template Method](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Template%20Method.pdf)

> Template Method 패턴은 어떤 작업을 처리하는 일부분을 서브 클래스로 캡슐화해 전체 일을 수행하는 구조는 바꾸지 않으면서 특정 단계에서 수행하는 내역을 바꾸는 행위 관련 패턴입니다.

```javascript
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
```

* [Visitor](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Visitor.pdf)

> Visitor(방문자) 패턴은 객체의 구조와 기능을 분리시키는 패턴으로서 구조는 변하지 않으면서 기능을 쉽게 추가하거나 확장되어야 할 경우 사용할 수 있는 행위 관련 패턴입니다.
> Visitor(방문자) 패턴의 예로서 파일 탐색기를 구현해볼수 있는데 파일 탐색기는 여기저기 폴더를 돌아다니면서 필요한 파일을 찾아서 특정 저장 공간에 그 파일들이 있는지 저장하였다가 방문이 모두 끝나면 사용자에게 결과를 보여줄 수 있습니다.
> 바로 탐색기가 여기서 Visitor(방문자) 입니다.

```javascript
protocol Element {
    func accept(_ visitor: Visitor)
}

class ConcreteElementA : Element {
    func accept(_ visitor: Visitor) {
        visitor.visitConcreteElementA(element: self)
    }

    func exclusiveMethodOfConcreteElementA() -> String {
        return "A"
    }
}

class ConcreteElementB: Element {
    func accept(_ visitor: Visitor) {
        visitor.visitConcreteElementB(element: self)
    }

    func specialMethodOfConcreteElementB() -> String {
        return "B"
    }
}

protocol Visitor {
    func visitConcreteElementA(element: ConcreteElementA)
    func visitConcreteElementB(element: ConcreteElementB)
}

class ConcreteVisitor1: Visitor {
    func visitConcreteElementA(element: ConcreteElementA) {
        print(element.exclusiveMethodOfConcreteElementA() + " + ConcreteVisitor1\n")
    }

    func visitConcreteElementB(element: ConcreteElementB) {
        print(element.specialMethodOfConcreteElementB() + " + ConcreteVisitor1\n")
    }
}

class ConcreteVisitor2: Visitor {
    func visitConcreteElementA(element: ConcreteElementA) {
        print(element.exclusiveMethodOfConcreteElementA() + " + ConcreteVisitor2\n")
    }

    func visitConcreteElementB(element: ConcreteElementB) {
        print(element.specialMethodOfConcreteElementB() + " + ConcreteVisitor2\n")
    }
}

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
```

* [Chain of Responsibility](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Chain%20of%20Responsibility.pdf)

> Chain of Responsibility(책임 연쇄 패턴) 패턴은 연속적인 핸들러를 따라 요청을 전달하도록 하는 행동 디자인 패턴입니다.
> 요청을 받으면 핸들러는 요청을 처리하거나 다음 핸들러로 요청을 전달합니다.

```javascript
protocol Handler : class {
    @discardableResult // 결과를 사용하든 안하든 경고가 안 뜨도록 해주는 지시어
    func setNext(handler: Handler) -> Handler
    func handle(request: String) -> String?
}

class BaseHandler : Handler {
    var nextHandler: Handler?
    
    func setNext(handler: Handler) -> Handler {
        self.nextHandler = handler
        return handler
    }
    
    func handle(request: String) -> String? {
        return nextHandler?.handle(request: request)
    }
}

class MonkeyHandler : BaseHandler {
    override func handle(request: String) -> String? {
        if (request == "Banana") {
            return "Monkey : I'll eat the " + request
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class DogHandler: BaseHandler {
    override func handle(request: String) -> String? {
        if (request == "MeatBall") {
            return "Dog : I'll eat the " + request
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class CatHandler: BaseHandler {
    override func handle(request: String) -> String? {
        if (request == "Fish") {
            return "Cat : I'll eat the " + request
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

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
```

* [Mememto](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BSwift%5D%20Memento.pdf)

> Memento(메멘토) 패턴은 객체의 상태를 저장하고 복원할 수 있는 행동 디자인 패턴입니다. 
> 기본 오리지날 객체는 본래의 기능에만 충실하고 상태 정보에 대한 관리를 메멘토 객체에게 전담하여 상태를 저장하고 복원할 수 있게 합니다.

```javascript
class Originator {
    private var state: String

    init(state: String) {
        self.state = state
        print("Originator: My initial state is: \(state)")
    }

    func doSomething() {
        print("Originator: I'm doing something important.")
        state = generateRandomString()
        print("Originator: and my state has changed to: \(state)")
    }

    private func generateRandomString() -> String {
        return String(UUID().uuidString.suffix(4))
    }

    func save() -> Memento {
        return ConcreteMemento(state: state)
    }

    func restore(memento: Memento) {
        guard let memento = memento as? ConcreteMemento else { return }
        self.state = memento.state
        print("Originator: My state has changed to: \(state)")
    }
}

protocol Memento {
    var name: String { get }
    var date: Date { get }
}

class ConcreteMemento: Memento {
    private(set) var state: String
    private(set) var date: Date

    init(state: String) {
        self.state = state
        self.date = Date()
    }

    var name:String { return state + " " + date.description.suffix(14).prefix(8) }
}

class Caretaker {
    private lazy var mementos = [Memento]()
    private var originator: Originator

    init(originator: Originator) {
        self.originator = originator
    }

    func backup() {
        print("\nSaving Originator's state...\n")
        mementos.append(originator.save())
    }

    func undo() {
        guard !mementos.isEmpty else { return }
        let removedMemento = mementos.removeLast()

        print("Restoring state to: " + removedMemento.name)
        originator.restore(memento: removedMemento)
    }

    func showHistory() {
        print("Here's the list of mementos:\n")
        mementos.forEach({ print($0.name) })
    }
}

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
```

* [(iOS) MVC, MVP, MVVM](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BiOS%5D%20MVC%2C%20MVP%2C%20MVVM.pdf)

> Traditional MVC

![!](https://t1.daumcdn.net/cfile/tistory/2752874556C1801403)

- Model : Data(데이터) + Status(상태) + Logic(로직)을 담당
- View : Model을 표현하고 책임지는 객체
- Controller : Model과 View를 연결해주고 관리하는 객체

> Appls' MVC

![!](https://t1.daumcdn.net/cfile/tistory/27298D4556C1801326)

- Model : Data(데이터) + Status(상태) + Logic(로직)을 담당
- View Controller : View가 Model을 표현하는 역할을 주로 하며 View Controller와 연결되어 대부분 View Controller가 
모든 처리를 담당

```javascript
import UIKit

struct Person { // Model
    let firstName: String
    let lastName: String
}

class GreetingViewController : UIViewController { // View + Controller
    var person: Person!
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
    }
    
    func didTapButton(button: UIButton) {
        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
        self.greetingLabel.text = greeting
        
    }
    // layout code goes here
}
// Assembling of MVC
let model = Person(firstName: "David", lastName: "Blaine")
let view = GreetingViewController()
view.person = model;
```

> MVP

![!](https://t1.daumcdn.net/cfile/tistory/2550864556C1801305)

- Model : Data(데이터) + Status(상태) + Logic(로직)을 담당
- (Passive) View : Presenter를 소유하며 액션을 보내주는 객체
- Presenter : Model을 소유하고 모델이 갱신되면 View 에 전달

```javascript
import UIKit

struct Person { // Model
    let firstName: String
    let lastName: String
}

protocol GreetingView: class {
    func setGreeting(greeting: String)
}

protocol GreetingViewPresenter {
    init(view: GreetingView, person: Person)
    func showGreeting()
}

class GreetingPresenter : GreetingViewPresenter {
    unowned let view: GreetingView
    let person: Person
    required init(view: GreetingView, person: Person) {
        self.view = view
        self.person = person
    }
    func showGreeting() {
        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
        self.view.setGreeting(greeting)
    }
}

class GreetingViewController : UIViewController, GreetingView {
    var presenter: GreetingViewPresenter!
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
    }
    
    func didTapButton(button: UIButton) {
        self.presenter.showGreeting()
    }
    
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
    
    // layout code goes here
}
// Assembling of MVP
let model = Person(firstName: "David", lastName: "Blaine")
let view = GreetingViewController()
let presenter = GreetingPresenter(view: view, person: model)
view.presenter = presenter
```

> MVVM

![!](https://t1.daumcdn.net/cfile/tistory/25507E4556C1801305)

- Model : MVC, MVP에서의 Model와 같음
- View : View Controller가 View의 역할을 함
- View Model : Model을 소유하고 모델을 직접 갱신한다. 갱신에 대한 이벤트 및 액션을 View에 바인딩하여 전달한다.

```javascript
import UIKit

struct Person { // Model
    let firstName: String
    let lastName: String
}

protocol GreetingViewModelProtocol: class {
    var greeting: String? { get }
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())? { get set } // function to call when greeting did change
    init(person: Person)
    func showGreeting()
}

class GreetingViewModel : GreetingViewModelProtocol {
    let person: Person
    var greeting: String? {
        didSet {
            self.greetingDidChange?(self)
        }
    }
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())?
    required init(person: Person) {
        self.person = person
    }
    func showGreeting() {
        self.greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
    }
}

class GreetingViewController : UIViewController {
    var viewModel: GreetingViewModelProtocol! {
        didSet {
            self.viewModel.greetingDidChange = { [unowned self] viewModel in
                self.greetingLabel.text = viewModel.greeting
            }
        }
    }
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self.viewModel, action: "showGreeting", forControlEvents: .TouchUpInside)
    }
    // layout code goes here
}
// Assembling of MVVM
let model = Person(firstName: "David", lastName: "Blaine")
let viewModel = GreetingViewModel(person: model)
let view = GreetingViewController()
view.viewModel = viewModel
```

* [(iOS) VIPER](https://github.com/billnjoyce/Lectures/blob/master/docs/design%20patterns/%5BiOS%5D%20VIPER.pdf)

> VIPER 

![!](http://labs.brandi.co.kr///assets/20180227/05.png)

- View : Presenter를 소유하여 요청을 받으며 액션을 전달하는 객체
- Interactor : Entity 모델 객체를 조작하고 비지니스 로직 관리
- Presenter : Interactor로부터 데이터를 가져오고 View로 데이터를 언제 보여줄지를 결정하는 객체
- Entity : Model 객체
- Router(Wireframe) : Persenter와 달리 View를 어떻게 보여줄지(seques)를 결정하는 객체

```javascript
import UIKit

struct Person { // Entity (usually more complex e.g. NSManagedObject)
    let firstName: String
    let lastName: String
}

struct GreetingData { // Transport data structure (not Entity)
    let greeting: String
    let subject: String
}

protocol GreetingProvider {
    func provideGreetingData()
}

protocol GreetingOutput: class {
    func receiveGreetingData(greetingData: GreetingData)
}

class GreetingInteractor : GreetingProvider {
    weak var output: GreetingOutput!
    
    func provideGreetingData() {
        let person = Person(firstName: "David", lastName: "Blaine") // usually comes from data access layer
        let subject = person.firstName + " " + person.lastName
        let greeting = GreetingData(greeting: "Hello", subject: subject)
        self.output.receiveGreetingData(greeting)
    }
}

protocol GreetingViewEventHandler {
    func didTapShowGreetingButton()
}

protocol GreetingView: class {
    func setGreeting(greeting: String)
}

class GreetingPresenter : GreetingOutput, GreetingViewEventHandler {
    weak var view: GreetingView!
    var greetingProvider: GreetingProvider!
    
    func didTapShowGreetingButton() {
        self.greetingProvider.provideGreetingData()
    }
    
    func receiveGreetingData(greetingData: GreetingData) {
        let greeting = greetingData.greeting + " " + greetingData.subject
        self.view.setGreeting(greeting)
    }
}

class GreetingViewController : UIViewController, GreetingView {
    var eventHandler: GreetingViewEventHandler!
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
    }
    
    func didTapButton(button: UIButton) {
        self.eventHandler.didTapShowGreetingButton()
    }
    
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
    
    // layout code goes here
}
// Assembling of VIPER module, without Router
let view = GreetingViewController()
let presenter = GreetingPresenter()
let interactor = GreetingInteractor()
view.eventHandler = presenter
presenter.view = view
presenter.greetingProvider = interactor
interactor.output = presenter
```
