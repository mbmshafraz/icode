//
//  UITextView.swift
//  SampleSafe
//
//  Created by Mohamed Shafraz on 16/12/2014.
//  Copyright (c) 2014 Sample Safe Valves. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    class func heightFor(text:String, width:CGFloat, font:UIFont) ->CGFloat {
        let textView = UITextView()
        textView.text = text
        textView.font = font
        let size = textView.sizeThatFits(CGSizeMake(width, CGFloat(FLT_MAX)))
        return size.height
    }
}