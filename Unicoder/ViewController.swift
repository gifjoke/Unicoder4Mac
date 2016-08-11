//
//  ViewController.swift
//  Unicoder
//
//  Created by Fnoz on 16/7/27.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {
    var topTextView:NSTextView! = nil
    var bottomTextView:NSTextView! = nil
    var typeMatrix: NSMatrix! = nil
    var directionMatrix: NSMatrix! = nil
    override func viewDidAppear() {
        let win = view.window!
        win.backgroundColor = NSColor.init(red: 252/255.0, green: 252/255.0, blue: 250/255.0, alpha: 1)
        win.titlebarAppearsTransparent = true
        win.title = ""
        win.styleMask = win.styleMask | NSFullSizeContentViewWindowMask;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(update(_:)), name: NSTextViewDidChangeSelectionNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.init(red: 252/255.0, green: 252/255.0, blue: 250/255.0, alpha: 1).CGColor
        view.layer?.cornerRadius = 5
        
        let titleLabel = NSTextField.init(frame: CGRect.init(x: (view.frame.width - 100)/2 + 10, y: view.frame.height - 30, width: 100, height: 30))
        titleLabel.stringValue = "Unicoder"
        titleLabel.bezeled = false
        titleLabel.drawsBackground = false
        titleLabel.editable = false
        titleLabel.selectable = false
        titleLabel.font = NSFont.init(name: "Avenir Next", size: 20)
        titleLabel.textColor = NSColor.init(red: 230/255.0, green: 75/255.0, blue: 21/255.0, alpha: 1)
        view.addSubview(titleLabel)
        
        let topStartLabel = NSTextField.init(frame: CGRect.init(x: 8, y: view.frame.height - 60, width: 20, height: 30))
        topStartLabel.stringValue = ">"
        topStartLabel.bezeled = false
        topStartLabel.drawsBackground = false
        topStartLabel.editable = false
        topStartLabel.selectable = false
        topStartLabel.font = NSFont.init(name: "Avenir Next", size: 20)
        topStartLabel.textColor = NSColor.init(red: 230/255.0, green: 75/255.0, blue: 21/255.0, alpha: 1)
        view.addSubview(topStartLabel)
        
        topTextView = NSTextView.init(frame: CGRect.init(x: 30, y: view.frame.height / 2 - 2, width: view.frame.width - 10 - 30, height: (view.frame.height - 10 * 2 - 50) / 2))
        topTextView.backgroundColor = NSColor.clearColor()
        topTextView.insertionPointColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        topTextView.textColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        topTextView.font = NSFont.init(name: "Avenir Next", size: 18)
        topTextView.delegate = self
        view.addSubview(topTextView)
        
        let bottomStartLabel = NSTextField.init(frame: CGRect.init(x: 8, y: view.frame.height / 2 - 50, width: 20, height: 30))
        bottomStartLabel.stringValue = ">"
        bottomStartLabel.bezeled = false
        bottomStartLabel.drawsBackground = false
        bottomStartLabel.editable = false
        bottomStartLabel.selectable = false
        bottomStartLabel.font = NSFont.init(name: "Avenir Next", size: 20)
        bottomStartLabel.textColor = NSColor.init(red: 230/255.0, green: 75/255.0, blue: 21/255.0, alpha: 1)
        view.addSubview(bottomStartLabel)
        
        bottomTextView = NSTextView.init(frame: CGRect.init(x: 30, y: 10 - 1, width: view.frame.width - 10 - 30, height: (view.frame.height - 10 * 2 - 50) / 2))
        bottomTextView.editable = false
        bottomTextView.backgroundColor = NSColor.clearColor()
        bottomTextView.font = NSFont.init(name: "Avenir Next", size: 18)
        bottomTextView.textColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        view.addSubview(bottomTextView)
        
        //EncodeType
        let encodeLabel = NSTextField.init(frame: CGRect.init(x: view.frame.width - 100, y: view.frame.height - 90, width: 75, height: 26))
        encodeLabel.stringValue = "     Type"
        encodeLabel.bezeled = false
        encodeLabel.drawsBackground = false
        encodeLabel.editable = false
        encodeLabel.selectable = false
        encodeLabel.font = NSFont.init(name: "Avenir Next", size: 15)
        encodeLabel.wantsLayer = true
        encodeLabel.layer?.borderColor = NSColor.lightGrayColor().CGColor
        encodeLabel.layer?.borderWidth = 2
        encodeLabel.textColor = NSColor.lightGrayColor()
        view.addSubview(encodeLabel)
        
        let prototype = NSButtonCell.init()
        prototype.title = "EncodeType"
        prototype.setButtonType(.RadioButton)
        typeMatrix = NSMatrix.init(frame: CGRect.init(x: view.frame.width - 100, y: view.frame.height - 200, width: 100, height: 100),
                                   mode: .RadioModeMatrix,
                                   prototype: prototype,
                                   numberOfRows: 3,
                                   numberOfColumns: 1)
        var cellArray = typeMatrix.cells
        cellArray[0].title = "Unicode"
        cellArray[1].title = "URL"
        cellArray[2].title = "Base64"
        view.addSubview(typeMatrix)
        
        //EncodeDirection
        let decodeLabel = NSTextField.init(frame: CGRect.init(x: view.frame.width - 100, y: view.frame.height - 290, width: 72, height: 26))
        decodeLabel.stringValue = " Direction"
        decodeLabel.bezeled = false
        decodeLabel.drawsBackground = false
        decodeLabel.editable = false
        decodeLabel.selectable = false
        decodeLabel.font = NSFont.init(name: "Avenir Next", size: 15)
        decodeLabel.wantsLayer = true
        decodeLabel.layer?.borderColor = NSColor.lightGrayColor().CGColor
        decodeLabel.layer?.borderWidth = 2
        decodeLabel.textColor = NSColor.lightGrayColor()
        view.addSubview(decodeLabel)
        
        prototype.title = "EncodeDirection"
        prototype.setButtonType(.RadioButton)
        directionMatrix = NSMatrix.init(frame: CGRect.init(x: view.frame.width - 100, y: view.frame.height - 400, width: 100, height: 100),
                                        mode: .RadioModeMatrix,
                                        prototype: prototype,
                                        numberOfRows: 2,
                                        numberOfColumns: 1)
        cellArray = directionMatrix.cells
        cellArray[0].title = "Encode"
        cellArray[1].title = "Decode"
        view.addSubview(directionMatrix)
    }
    
    func update(noti:NSNotification) {
        if noti.object as? NSTextView == bottomTextView {
            return
        }
        let typeIndex = typeMatrix.selectedRow
        let string = topTextView.string
        switch typeIndex {
        case 0:
            bottomTextView.string = UnicodeHandle(string!) as String
        case 1:
            bottomTextView.string = URLHandle(string!) as String
        case 2:
            bottomTextView.string = Base64Handle(string!) as String
        default:
            bottomTextView.string = UnicodeHandle(string!) as String
        }
    }
    
    func UnicodeHandle(string:NSString) -> NSString {
        if directionMatrix.selectedRow == 1 {
            return UnicodeDecode(string)
        }
        else {
            return UnicodeEncode(string)
        }
    }
    
    func URLHandle(string:NSString) -> NSString {
        if directionMatrix.selectedRow == 1 {
            return URLDecode(string)
        }
        else {
            return URLEncode(string)
        }
    }
    
    func Base64Handle(string:NSString) -> NSString {
        if directionMatrix.selectedRow == 1 {
            return Base64Decode(string)
        }
        else {
            return Base64Encode(string)
        }
    }
}

