//
//  ViewController.swift
//  designpatterns
//
//  Created by billkim on 18/05/2020.
//  Copyright © 2020 billkim. All rights reserved.
//

import UIKit
import SwiftComboBox

class ViewController: UIViewController {
    @IBOutlet weak var combobox1: SwiftComboBox!
    @IBOutlet weak var textview1: UITextView!
    
    private var selectedIndex = 0
    private let patterns: [String : Client] = [ "Singleton" : ClientSingleton(),
                                                "Prototype" : ClientPrototype(),
                                                "Factory" : ClientFactory(),
                                                "Factory Method" : ClientFactoryMethod(),
                                                "Abstract Factory" : ClientAbstractFactory(),
                                                "Builder" : ClientBuilder(),
                                                "Adapter" : ClientAdapter(),
                                                "Facade" : ClientFacade(),
                                                "Decorator" : ClientDecorator(),
                                                "Composite" : ClientComposite(),
                                                "Bridge" : ClientBridge(),
                                                "Flyweight" : ClientFlyweight(),
                                                "Proxy" : ClientProxy(),
                                                "Observer" : ClientObserver(),
                                                "Strategy" : ClientStrategy(),
                                                "Command" : ClientCommand(),
                                                "Iterator" : ClientIterator(),
                                                "Mediator" : ClientMediator(),
                                                "State" : ClientState(),
                                                "Template Method" : ClientTemplateMethod(),
                                                "Visitor" : ClientVisitor(),
                                                "Chain of Responsibility" : ClientCoR(),
                                                "Mememto" : ClientMememto()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initControls()
    }
    
    func initControls()
    {
        let defaultText = "Push a 'RUN' button..."
        
        selectedIndex = 0
        
        combobox1.context = self
        combobox1.dataSource = Array(patterns.keys)
        combobox1.didSelectRow = { (index: Int, item: String) in
            self.selectedIndex = index;
            self.textview1.text = "Selected Pattern : \(item) \nPush a 'RUN' button..."
        }
        
        textview1.text = defaultText
    }
    
    @IBAction func pushRun()
    {
        textview1.text = ""
        if(selectedIndex < 0 || selectedIndex >= patterns.count) { return; }
        
        guard let pattern = patterns[combobox1.selectedItem!.text] else { return }
        
        self.textview1.text = pattern.run()
    }
}
