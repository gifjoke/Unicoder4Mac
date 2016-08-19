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
        
        topTextView = NSTextView.init(frame: CGRect.init(x: 30, y: view.frame.height / 2 - 2, width: view.frame.width - 100 - 30, height: (view.frame.height - 10 * 2 - 50) / 2))
        topTextView.backgroundColor = NSColor.clearColor()
        topTextView.insertionPointColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        topTextView.textColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        topTextView.font = NSFont.init(name: "Avenir Next", size: 18)
        topTextView.delegate = self
        view.addSubview(topTextView)
        
        let topStartImageView = NSImageView.init(frame: CGRect.init(x: 8, y: topTextView.frame.maxY - 27, width: 20, height: 30))
        topStartImageView.image = NSImage.init(named: "right")
        view.addSubview(topStartImageView)
        
        bottomTextView = NSTextView.init(frame: CGRect.init(x: 30, y: 10 - 1, width: view.frame.width - 100 - 30, height: (view.frame.height - 10 * 2 - 50) / 2))
        bottomTextView.editable = false
        bottomTextView.backgroundColor = NSColor.clearColor()
        bottomTextView.font = NSFont.init(name: "Avenir Next", size: 18)
        bottomTextView.textColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        view.addSubview(bottomTextView)
        
        let bottomStartImageView = NSImageView.init(frame: CGRect.init(x: 8, y: bottomTextView.frame.maxY - 27, width: 20, height: 30))
        bottomStartImageView.image = NSImage.init(named: "right")
        view.addSubview(bottomStartImageView)
        
        //EncodeType
        let encodeTypeLabel = NSTextField.init(frame: CGRect.init(x: view.frame.width - 85, y: view.frame.height - 95, width: 75, height: 26))
        encodeTypeLabel.stringValue = "Type"
        encodeTypeLabel.bezeled = false
        encodeTypeLabel.drawsBackground = false
        encodeTypeLabel.editable = false
        encodeTypeLabel.selectable = false
        encodeTypeLabel.font = NSFont.init(name: "Avenir Next", size: 15)
        encodeTypeLabel.wantsLayer = true
        encodeTypeLabel.textColor = NSColor.lightGrayColor()
        view.addSubview(encodeTypeLabel)
        
        let titleArray = ["Unicode", "URL", "Base64", "Escape"]
        let prototype = NSButtonCell.init()
        prototype.title = "EncodeType"
        prototype.setButtonType(.RadioButton)
        typeMatrix = NSMatrix.init(frame: CGRect.init(x: view.frame.width - 85, y: view.frame.height - 200, width: 100, height: 100),
                                   mode: .RadioModeMatrix,
                                   prototype: prototype,
                                   numberOfRows: titleArray.count,
                                   numberOfColumns: 1)
        typeMatrix.target = self
        typeMatrix.action = #selector(encodeTypeChanged(_:))
        var cellArray = typeMatrix.cells
        for i in 0 ... titleArray.count - 1 {
            cellArray[i].title = titleArray[i]
        }
        view.addSubview(typeMatrix)
        
        //EncodeDirection
        let encodeDireLabel = NSTextField.init(frame: CGRect.init(x: view.frame.width - 85, y: view.frame.height - 295, width: 72, height: 26))
        encodeDireLabel.stringValue = "Dire"
        encodeDireLabel.bezeled = false
        encodeDireLabel.drawsBackground = false
        encodeDireLabel.editable = false
        encodeDireLabel.selectable = false
        encodeDireLabel.font = NSFont.init(name: "Avenir Next", size: 15)
        encodeDireLabel.wantsLayer = true
        encodeDireLabel.textColor = NSColor.lightGrayColor()
        view.addSubview(encodeDireLabel)
        
        prototype.title = "EncodeDire"
        prototype.setButtonType(.RadioButton)
        directionMatrix = NSMatrix.init(frame: CGRect.init(x: view.frame.width - 85, y: view.frame.height - 400, width: 100, height: 100),
                                        mode: .RadioModeMatrix,
                                        prototype: prototype,
                                        numberOfRows: 2,
                                        numberOfColumns: 1)
        directionMatrix.target = self
        directionMatrix.action = #selector(encodeDireChanged(_:))
        cellArray = directionMatrix.cells
        cellArray[0].title = "Encode"
        cellArray[1].title = "Decode"
        view.addSubview(directionMatrix)
    }
    
    func encodeTypeChanged(typeMatrix:NSMatrix) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            if self.typeMatrix.selectedRow >= 3 {
                self.directionMatrix.selectCellAtRow(0, column: 0)
            }
            self.update(NSNotification.init(name: "", object: ""))
        }
    }
    
    func encodeDireChanged(directionMatrix:NSMatrix) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            if self.typeMatrix.selectedRow >= 3 {
                self.directionMatrix.selectCellAtRow(0, column: 0)
            }
            self.update(NSNotification.init(name: "", object: ""))
        }
    }
    
    func update(noti:NSNotification) {
        if noti.object as? NSTextView == bottomTextView {
            return
        }
        let string = topTextView.string
        
        if string?.characters.count == 0 {
            bottomTextView.string = ""
            return
        }
        
        let typeIndex = typeMatrix.selectedRow
        switch typeIndex {
        case 0:
            bottomTextView.string = UnicodeHandle(string!) as String
        case 1:
            bottomTextView.string = URLHandle(string!) as String
        case 2:
            bottomTextView.string = Base64Handle(string!) as String
        case 3:
            bottomTextView.string = Escape(string!) as String
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

