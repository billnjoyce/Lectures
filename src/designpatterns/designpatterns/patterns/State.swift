//
//  State.swift
//  designpatterns
//
//  Created by billkim on 21/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

class ContextState {
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
    func update(context: ContextState)

    func handle1()
    func handle2()
}

class ConcreteStateA : State {
    private(set) weak var context: ContextState?

    func update(context: ContextState) {
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
    private(set) weak var context: ContextState?

    func update(context: ContextState) {
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
