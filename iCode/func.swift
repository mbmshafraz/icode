//
//  func.swift
//  CLF
//
//  Created by Mohamed Shafraz on 03/11/2014.
//  Copyright (c) 2014 Child Labor Free Holdings Ltd. All rights reserved.
//

import Foundation

func iCLog(massage: AnyObject,function:String = __FUNCTION__) {
    print("\n\n===== \(function) =====\n LINE    : \(__LINE__) \n MESSAGE : \(massage) \n==== End Log ====\n\n", terminator: "")
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func synced(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
