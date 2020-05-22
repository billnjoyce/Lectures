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

class ClientIterator : Client {
    func makePattern() -> Pattern {
        return PatternIterator()
    }
}

class PatternIterator : Pattern {
    func run() -> String {
        var result = ""
        
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
            let value:Any = iterator1.next()!
            print(value)
            result += value as! String + "\n"
            
            // First
            // Second
            // Third
        }
        
        let iterator2 = numbers.makeIterator()
        
        while (iterator2.hasNext()) {
            let value:Any = iterator2.next()!
            print(value)
            result += "\(value)" + "\n"
            // 1
            // 2
            // 3
        }
        
        let iterator3 = ConcreteIterator(words)
        
        while (true) {
            guard let collection = iterator3.next() else { break }
            print(collection)
            result += collection as! String + "\n"
            // First
            // Second
            // Third
        }
        
        let iterator4 = ConcreteIterator(numbers)
        
        while (true) {
            guard let collection = iterator4.next() else { break }
            print(collection)
            result += "\(collection)" + "\n"
            // 1
            // 2
            // 3
        }
        
        return result
    }
}
