//
//  AppDelegate.swift
//  Unicoder
//
//  Created by Fnoz on 16/7/27.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if(!flag)
        {
            for window in sender.windows {
                window.makeKeyAndOrderFront(self)
            }
        }
        return true;
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func encodeTypeTapped(sender: AnyObject) {
        let item = sender as! NSMenuItem
        let typeArray = ["unicode", "utf8", "url"]
        let string:NSString = typeArray[item.tag - 100]
        NSUserDefaults.standardUserDefaults().setObject(string, forKey: "encodeType")
        NSNotificationCenter.defaultCenter().postNotificationName("encodeTypeChanged", object: nil)
    }

}

