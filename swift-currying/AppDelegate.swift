//
//  AppDelegate.swift
//  swift-currying
//
//  Created by Oleksandr  on 08/07/2019.
//  Copyright © 2019 Oleksandr. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            // Normal function call
            let summ = Scope1.add(1, 2)
            print("-> \(summ)")
            
            // Create closure to pass `add` function and default parameter `2`.
            let xs = 1...10
            let list1 = xs.map { Scope1.add($0, 2) }
            print("-> \(list1)")
            
            // Don't create closure but pass directly `addTwo` function instead.
            // But this function is too specific, for other cases another specific function has to be created.
            let list2 = xs.map(Scope1.addTwo)
            print("-> \(list2)")
        }
        
        do {
            // Functional call
            let summ = Scope2.add(1)(2)
            print("-> \(summ)")
            
            let xs = 1...10
            let list = xs.map(Scope2.add(2))
            print("-> \(list)")
        }
        
        do {
            let summ = Scope3.add(NSNumber.add)(1)(2)
            print("-> \(summ)")
            
            let xs = 1...10
            let list = xs.map(Scope3.add(NSNumber.add)(2))
            print("-> \(list)")
        }
        
        exit(1)
    }
}

// MARK: -

private struct Scope1 {
    static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    static func addTwo(a: Int) -> Int {
        return add(a, 2)
    }
}

// MARK: -

private struct Scope2 {
    static func add(_ a: Int) -> (Int) -> Int {
        return { b in a + b }
    }
}

// MARK: -

extension NSNumber {
    class func add(a: NSNumber, b: NSNumber) -> NSNumber {
        return NSNumber(integerLiteral: a.intValue + b.intValue)
    }
}

private struct Scope3 {
    static func add(_ localAdd: @escaping (NSNumber, NSNumber) -> NSNumber) -> ((Int) -> ((Int) -> Int)) {
        return { a in
            { b in
                return localAdd(NSNumber(integerLiteral: a), NSNumber(integerLiteral: b)).intValue
            }
        }
    }
}
