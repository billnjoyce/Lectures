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
