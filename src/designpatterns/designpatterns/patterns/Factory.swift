//
//  Factory.swift
//  designpatterns
//
//  Created by billkim on 18/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

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
    
    func make() -> String {
        print("Make a pen.")
        return "Make a pen.\n"
    }
}

class Pencil {
    init() {
        print("Pencil init")
    }
    
    func make() -> String {
        print("Make a pencil.")
        return "Make a pencil.\n"
    }
}

class ClientFactory : Client {
    func makePattern() -> Pattern {
        return PatternFactory()
    }
}

class PatternFactory : Pattern {
    func run() -> String {
        var result = ""
        
        let factory = Factory()
        
        let pen = factory.makePen() // Pen init
        
        result += "Pen init\n"
        result += pen.make() // Make a pen.
        
        let pencil = factory.makePencil() // Pencil init
        
        result += "Pencil init\n"
        result += pencil.make() // Make a pencil.
        
        return result
    }
}
