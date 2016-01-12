//
//  JSONClient.swift
//  CLF
//
//  Created by Mohamed Shafraz on 03/11/2014.
//  Copyright (c) 2014 Child Labor Free Holdings Ltd. All rights reserved.
//

import Foundation

@objc protocol JSONClientDelegate : HTTPClientDelegate {
    optional func receivedJSONObject(jsonClient:JSONClient, object:AnyObject)
    optional func receivedInvalidJSON(jsonClient:JSONClient,data:NSData)
}

class JSONClient: HTTPClient {
    override func receivedData(data:NSData) {
        var error: NSError?
        let jsonObject:AnyObject?
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        } catch let error1 as NSError {
            error = error1
            jsonObject = nil
        }
        
        if let delegate = self.delegate as? JSONClientDelegate {
            if error == nil {
                if jsonObject is NSArray || jsonObject is NSDictionary {
                    delegate.receivedJSONObject?(self, object: jsonObject!)
                } else {
                    delegate.receivedInvalidJSON?(self, data: data)
                }
            } else {
                delegate.receivedInvalidJSON?(self, data: data)
            }
        }
        
//        if jsonObject is NSArray || jsonObject is NSDictionary {
//            if let delegate = self.delegate as? JSONClientDelegate {
//                if error == nil {
//                    delegate.receivedJSONObject?(self, object: jsonObject!)
//                } else {
//                    delegate.receivedInvalidJSON?(self, data: data)
//                }
//            }
//        }
    }
}
