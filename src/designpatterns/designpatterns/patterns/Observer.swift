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
        print("ConcreteObserverA - updated a state : \(subject.state)")
    }
}

// 실제 구독을 하는 객체
class ConcreteObserverB : Observer {
    func update(subject: ObserverSubject) {
        print("ConcreteObserverB - updated a state : \(subject.state)")
    }
}
