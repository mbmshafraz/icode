//
//  HTTPMultipartForm.swift
//  WFL Installer
//
//  Created by Mohamed Shafraz on 8/3/15.
//  Copyright (c) 2015 Warm for Life. All rights reserved.
//
/*

Copyright (c) 2014, Shafraz Buhary
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the Copyright holder  nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

import UIKit

class HTTPMultipartForm {
    let data:NSMutableData
    let boundary:String
    
    init(boundary:String) {
        self.boundary = boundary
        data = NSMutableData()
        addBoundary()
    }
    
    private func addBoundary() {
        data.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    }
    
    func addData(name:String,value:String) {
        data.appendData("Content-Disposition: form-data; name=\(name)\r\n\r\n\(value)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        addBoundary()
    }
    
    func addData(name:String,value:Int) {
        addData(name, value: "\(value)")
    }
    
    func addData(name:String,value:UInt) {
        addData(name, value: "\(value)")
    }

    func addData(name:String,value:UInt64) {
        addData(name, value: "\(value)")
    }
    
    func addData(name:String,value:UInt32) {
        addData(name, value: "\(value)")
    }
    
    func addData(name:String, value:Float) {
        addData(name, value: "\(value)")
    }
    
    func addData(name:String,date:NSDate) {
        addData(name, date: date, formate: "yyyy-MM-dd HH:mm:ss")
    }
    
    func addData(name:String, date:NSDate, formate:String) {
        addData(name, value: date.dateTimeInFormate(formate))
    }
    
    func addData(name:String, value:Bool) {
        addData(name, value: value ? 1 : 0)
    }
    
    func addJpegImage(name:String,fileName:String,image:NSData) {
        data.appendData("Content-Disposition: form-data; name=\(name); filename=\(fileName).jpg\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        data.appendData("Content-Type: image/jpeg\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        data.appendData(image)
        data.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        addBoundary()
    }
    
    func addJpegImage(name:String,fileName:String,image:UIImage) {
        addJpegImage(name, fileName: fileName, image: UIImageJPEGRepresentation(image,0.0)!)
    }
}
