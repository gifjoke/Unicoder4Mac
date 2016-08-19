//
//  UNEncoder.swift
//  Unicoder
//
//  Created by Fnoz on 16/7/29.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

import Cocoa
import Foundation
import AppKit

func UnicodeEncode(string:NSString) -> NSString {
    let data = string.dataUsingEncoding(NSNonLossyASCIIStringEncoding)
    return NSString.init(data: data!, encoding: NSUTF8StringEncoding)!
}

func UnicodeDecode(string:NSString) -> NSString {
    let data = string.dataUsingEncoding(NSUTF8StringEncoding)
    var resultStr = NSString.init(data: data!, encoding: NSNonLossyASCIIStringEncoding)
    if resultStr == nil {
        resultStr = ""
    }
    return resultStr!
}

func URLEncode(string: NSString) -> NSString {
    return string.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
}

func URLDecode(string: NSString) -> NSString {
    return string.stringByRemovingPercentEncoding!
}

func Base64Encode(string: NSString) -> NSString {
    let encodedData = string.dataUsingEncoding(NSUTF8StringEncoding)
    return (encodedData?.base64EncodedStringWithOptions(.Encoding64CharacterLineLength))!
}

func Base64Decode(string: NSString) -> NSString {
    if let decodedData = NSData.init(base64EncodedString: string as String, options: .IgnoreUnknownCharacters) {
        return NSString.init(data: decodedData, encoding: NSUTF8StringEncoding)!
    } else {
        return string
    }
}

func Escape(string: NSString) -> NSString {
    let result = NSMutableString.init(string: "")
    for i in 0 ... string.length - 1 {
        let uc = string.substringWithRange(NSRange.init(location: i, length: 1))
        switch uc {
        case "\"":
            result.appendString("\\\"")
            break
        case "\'":
            result.appendString("\\\'")
            
            break
        case "\\":
            result.appendString("\\\\")
            break
        case "\t":
            result.appendString("\\t")
            break
        case "\n":
            result.appendString("\\n")
            break
        case "\r":
            result.appendString("\\r")
            break
        case "\u{8}":
            result.appendString("\\u{8}")
            break
        case "\u{12}":
            result.appendString("\\u{12}")
        default:
            result.appendString(uc)
            break
        }
    }
    return result.copy() as! String
}
