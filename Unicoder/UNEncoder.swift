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
