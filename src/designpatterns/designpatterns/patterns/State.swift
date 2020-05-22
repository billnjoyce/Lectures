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

    func request1() -> String {
        return state.handle1()
    }

    func request2() -> String {
        return state.handle2()
    }
}

protocol State : class {
    func update(context: ContextState)

    func handle1() -> String
    func handle2() -> String
}

class ConcreteStateA : State {
    private(set) weak var context: ContextState?

    func update(context: ContextState) {
        self.context = context
    }
    
    func handle1() -> String {
        print("ConcreteStateA handles request1.")
        context?.changeState(state: ConcreteStateB())
        
        return "ConcreteStateA handles request1.\n"
    }

    func handle2() -> String {
        print("ConcreteStateA handles request2.\n")
        return "ConcreteStateA handles request2.\n"
    }
}

class ConcreteStateB : State {
    private(set) weak var context: ContextState?

    func update(context: ContextState) {
        self.context = context
    }
    
    func handle1() -> String {
        print("ConcreteStateB handles request1.\n")
        return "ConcreteStateB handles request1.\n"
    }

    func handle2() -> String {
        print("ConcreteStateB handles request2.")
        context?.changeState(state: ConcreteStateA())
        return "ConcreteStateB handles request2.\n"
    }
}

class ClientState : Client {
    func makePattern() -> Pattern {
        return PatternState()
    }
}

class PatternState : Pattern {
    func run() -> String {
        var result = ""
        
        let context = ContextState(ConcreteStateA())
        
        result += context.request1() // ConcreteStateA handles request1.
        result += context.request1() // ConcreteStateB handles request1.
        
        result += context.request2() // ConcreteStateB handles request2.
        result += context.request2() // ConcreteStateA handles request2.
        
        return result
    }
}
