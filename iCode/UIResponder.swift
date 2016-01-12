//
//  NSResponder.swift
//  CLF
//
//  Created by Mohamed Shafraz on 03/12/2014.
//  Copyright (c) 2014 Child Labor Free Holdings Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {

    private struct StaticStruct {
        weak static var currentFirstResponder:UIResponder?
    }

    class func currentFirstResponder() -> UIResponder? {
        StaticStruct.currentFirstResponder = nil
        UIApplication.sharedApplication().sendAction("findFirstResponder:", to: nil, from: nil, forEvent: nil)
        return StaticStruct.currentFirstResponder
    }

    func findFirstResponder(sender:AnyObject) {
        StaticStruct.currentFirstResponder = self
    }
}