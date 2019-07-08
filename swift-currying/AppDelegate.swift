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
            let add = Normal.add(1, 2)
            print("-> \(add)")
            
            // Create clusure to pass `add` function and default parameter `2`.
            let xs = 1...10
            let list1 = xs.map { Normal.add($0, 2) }
            print("-> \(list1)")
            
            // Don't create closure but pass directly `addTwo` function instead.
            // But this function is too specific, for other cases another specific function has to be created.
            let list2 = xs.map(Normal.addTwo)
            print("-> \(list2)")
        }
        
        do {
            // Functional call
            let add = Functional.add(1)(2)
            print("-> \(add)")
            
            let xs = 1...10
            let list = xs.map(Functional.add(2))
            print("-> \(list)")
        }
        
        exit(1)
    }
}

private struct Normal {
    static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    static func addTwo(a: Int) -> Int {
        return add(a, 2)
    }
}

private struct Functional {
    static func add(_ a: Int) -> (Int) -> Int {
        return { b in a + b }
    }
}
