//
//  ChainofResponsibility.swift
//  designpatterns
//
//  Created by billkim on 21/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import Foundation

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

class ClientCoR : Client {
    func makePattern() -> Pattern {
        return PatternCoR()
    }
}

class PatternCoR : Pattern {
    func run() -> String {
        var result = ""
        
        func handler(handler: Handler) {

            let food = ["Nut", "Banana", "Fish"]

            food.forEach({ let r = handler.handle(request: $0)
                if(r == nil) {
                    print($0 + " was left untouched.")
                    result += $0 + " was left untouched.\n"
                }
                else {
                    print(r!)
                    result += r! + "\n"
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
        
        return result
    }
}
