//
//  ViewController.swift
//  Thread-TestTask
//
//  Created by Raman Kozar on 30/01/2023.
//

import UIKit

var isAvalible: Bool = false
let condition = NSCondition()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let valFirstThread = ValueFirst()
        let valSecondThread = ValueSecond()
        
        valFirstThread.start()
        valSecondThread.start()
        
    }

}

class ValueFirst: Thread {
    
    override func main() {
        printFirstValue()
    }
    
    private func printFirstValue() {
     
        condition.lock()
        print("1-1")
        isAvalible = true
        condition.signal()
        
        do {
            condition.unlock()
        }
        
        print("1-2")
        
    }
}

class ValueSecond: Thread {
    
    override func main() {
        printSecondValue()
    }
    
    private func printSecondValue() {
     
        condition.lock()
        print("2-1")
        
        if !isAvalible {
            condition.wait()
        }
        
        isAvalible = false
        
        do {
            condition.unlock()
        }
        
        print("2-2")
        
    }
    
}

