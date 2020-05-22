//
//  Observer.swift
//  designpatterns
//
//  Created by billkim on 20/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

// 구독할 주제 객체
class ObserverSubject {
    var state: Int = { return Int(arc4random_uniform(10)) }()
    private lazy var observers = [Observer]()

    func attach(_ observer: Observer) -> String {
        print("Subject: Attached an observer.\n")
        observers.append(observer)
        
        return "Subject: Attached an observer.\n"
    }

    func detach(_ observer: Observer) -> String {
        if let idx = observers.index(where: { $0 === observer }) {
            observers.remove(at: idx)
            print("Subject: Detached an observer.\n")
            return "Subject: Detached an observer.\n"
        }
        
        return ""
    }

    func notify() {
        print("Subject: Notifying observers...\n")
        PatternObserver.resultText += "Subject: Notifying observers...\n"
        
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
        print("ConcreteObserverA - updated a state : \(subject.state)")
        PatternObserver.resultText += "ConcreteObserverA - updated a state : \(subject.state)" + "\n"
    }
}

// 실제 구독을 하는 객체
class ConcreteObserverB : Observer {
    func update(subject: ObserverSubject) {
        print("ConcreteObserverB - updated a state : \(subject.state)")
        PatternObserver.resultText += "ConcreteObserverB - updated a state : \(subject.state)" + "\n"
    }
}

class ClientObserver : Client {
    func makePattern() -> Pattern {
        return PatternObserver()
    }
}

class PatternObserver : Pattern {
    static var resultText = ""
    
    func run() -> String {
        //var result = ""
        
        let subject = ObserverSubject()

        let observer1 = ConcreteObserverA()
        let observer2 = ConcreteObserverB()

        PatternObserver.resultText += subject.attach(observer1) // Subject: Attached an observer.
        PatternObserver.resultText += subject.attach(observer2) // Subject: Attached an observer.

        subject.updateState()
        // ConcreteObserverA - updated a state : 6
        // ConcreteObserverB - updated a state : 6
        
        subject.updateState()
        // ConcreteObserverA - updated a state : 1
        // ConcreteObserverB - updated a state : 1
        
        PatternObserver.resultText += subject.detach(observer2) // Subject: Detached an observer.
        
        subject.updateState()
        // ConcreteObserverA - updated a state : 9
        
        return PatternObserver.resultText
    }
}
