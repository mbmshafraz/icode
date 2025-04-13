//
//  Implies.swift
//  iCode
//
//  Created by Mohamed Shafraz on 2024-07-17.
//

import Foundation

//Defining operator implies, as =>
infix operator =>

// Function which accepts two parameters and returns boolion value
public func => (lhs: Bool, rhs: Bool) -> Bool {
    return !lhs || rhs
}





