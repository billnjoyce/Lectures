//
//  Memento.swift
//  designpatterns
//
//  Created by billkim on 21/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

class Originator {
    private var state: String

    init(state: String) {
        self.state = state
        print("Originator: My initial state is: \(state)")
        PatternMememto.resultText += "Originator: My initial state is: \(state)\n"
    }

    func doSomething() {
        print("Originator: I'm doing something important.")
        PatternMememto.resultText += "Originator: I'm doing something important.\n"
        state = generateRandomString()
        print("Originator: and my state has changed to: \(state)")
        PatternMememto.resultText += "Originator: and my state has changed to: \(state)\n"
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
        PatternMememto.resultText += "Originator: My state has changed to: \(state)\n"
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

    var name: String { return state + " " + date.description.suffix(14).prefix(8) }
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
        PatternMememto.resultText += "\nSaving Originator's state...\n\n"
    }

    func undo() {
        guard !mementos.isEmpty else { return }
        let removedMemento = mementos.removeLast()

        print("Restoring state to: " + removedMemento.name)
        originator.restore(memento: removedMemento)
        
        PatternMememto.resultText += "Restoring state to: " + removedMemento.name + "\n"
    }

    func showHistory() {
        print("Here's the list of mementos:\n")
        PatternMememto.resultText += "Here's the list of mementos:\n\n"
        
        mementos.forEach({
            print($0.name)
            PatternMememto.resultText += $0.name + "\n"
        })
        
        PatternMememto.resultText += "\n"
    }
}

class ClientMememto : Client {
    func makePattern() -> Pattern {
        return PatternMememto()
    }
}

class PatternMememto : Pattern {
    static var resultText = ""
    
    func run() -> String {
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
        
        return PatternMememto.resultText
    }
}
