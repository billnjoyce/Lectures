//
//  Iterator.swift
//  designpatterns
//
//  Created by billkim on 21/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

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
