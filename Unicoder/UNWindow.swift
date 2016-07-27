//
//  UNWindow.swift
//  Unicoder
//
//  Created by Fnoz on 16/7/27.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

import Cocoa

class UNWindow: NSWindow {
    
    /**
     * NSTextView input will be disalbed if NSWindow hide title
     * because 2 follow value will be false
     */
    override var canBecomeKeyWindow: Bool {
        get {
            return true
        }
    }
    
    override var canBecomeMainWindow: Bool {
        get {
            return true
        }
    }
}
