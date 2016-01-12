//
//  HTTPClient.swift
//  CLF
//
//  Created by Mohamed Shafraz on 03/11/2014.
//  Copyright (c) 2014 Child Labor Free Holdings Ltd. All rights reserved.
//

import Foundation
import UIKit

@objc protocol HTTPClientDelegate {
    optional func receivedData(httpClient:HTTPClient, data:NSData)
    optional func failedToConnectServer(httpClient:HTTPClient, error:NSError)
//    optional func receivedErrorResponseCode(httpClient:HTTPClient,responseCode:Int)
    optional func receivedErrorResponse(httpClient:HTTPClient,responseCode:Int,responseString:String?)
    optional func receivedEmptyData()
}

class HTTPClient: NSObject {
    
    
    
    weak var delegate:HTTPClientDelegate?
    var request:NSURLRequest?
    
       
    convenience init(request:NSURLRequest) {
        self.init()
        self.request = request
    }
    
    func sendAsynchronousReguest() {
        if self.request != nil {
            sendAsynchronousReguest(self.request!)
        }
    }
    
    func sendAsynchronousReguest(request:NSURLRequest) {
        
        UIApplication.sharedApplication().onNetworkIndicator()
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if error == nil {
                    /* No Errors */
                    let httpResponse = response as! NSHTTPURLResponse
                    if data == nil {
                        iCLog("data is nil")
                    } else {
                        iCLog(data!.toString!)
                    }
                    
                    if httpResponse.statusCode == 200 {
                        
                        if data?.length == 0 {
                            self.delegate?.receivedEmptyData?()
                        } else {
                            self.receivedData(data!)
                        }
                        
                    } else {
        
                        self.delegate?.receivedErrorResponse?(self, responseCode: httpResponse.statusCode, responseString: data!.toString as? String)
                    }
                    
                } else {
                    /* something wrong */
                    iCLog("Connection error : \(error!.description)")
                    self.delegate?.failedToConnectServer?(self, error: error!)
                }
                UIApplication.sharedApplication().offNetworkIndicator()
            })

        })
        task.resume()
    }
    
    func receivedData(data:NSData) {
        self.delegate?.receivedData?(self, data: data)
    }
}
