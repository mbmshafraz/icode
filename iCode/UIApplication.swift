//
//  UIApplication+iCode.swift
//  iCode
//
//  Created by Mohamed Shafraz on 20/10/2014.
/*

Copyright (c) 2014, Shafraz Buhary
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the Copyright holder  nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

import Foundation
import UIKit

extension UIApplication {
    
    private struct StaticStruct {
        static var networkRequestCount:Int = 0
    }
    
    func onNetworkIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        synced(self) {
            StaticStruct.networkRequestCount += 1
        }
    }
    
    func offNetworkIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        synced(self){
            if StaticStruct.networkRequestCount > 1 {
                StaticStruct.networkRequestCount -= 1
            } else {
                StaticStruct.networkRequestCount = 0
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
    }
    
    func documentsRoot() ->NSString {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    }
    
    func tempDiractory() ->NSString {
        return NSTemporaryDirectory()
    }
    
    func call(phoneNumber:String) {
        //Fix: Have to implement this
    }
}