//
//  NSString.swift
//  iCode
//
//  Created by Mohamed Shafraz on 20/10/2014.
//  Copyright (c) 2014 Shafraz. All rights reserved.
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

extension NSString {
    
    func isValidForPattern(pattern:String) ->Bool{
        return isValidForPattern(pattern, option: NSRegularExpressionOptions.CaseInsensitive)
    }
    
    func isValidForPattern(pattern:String, option:NSRegularExpressionOptions) ->Bool {
        
        var isValid = false
        
//        var error:NSError?
        
        let regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: pattern, options: option)
        } catch {
            regex = nil
        }
//        } catch let error1 as NSError {
//            error = error1
//            regex = nil
//        }
        let textRange = NSMakeRange(0, self.length)
        let matchRange = regex?.rangeOfFirstMatchInString(self as String, options: NSMatchingOptions.ReportProgress, range: textRange)
        
        if textRange.location == matchRange?.location && textRange.length == matchRange?.length {
            isValid = true
        }
        
        return isValid
    }
}
