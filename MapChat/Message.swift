//
//  Message.swift
//  MapChat
//
//  Created by studentuser on 5/29/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class Message : NSObject, JSQMessageData {
    private var _senderDisplayName: String
    private var _senderId : String
    private var _date: NSDate
    private var _isMediaMessage : Bool
    private var _messageHash : String
    private var _text : String
    
    init(text: String?, sender: String?) {
        self._senderDisplayName = Device.Username
        self._senderId = Device.DeviceId
        self._date = NSDate()
        self._isMediaMessage = false
        self._messageHash = ""
        self._text = ""
    }
    
    func senderId() -> String {
        return _senderId
    }
    
    func senderDisplayName() -> String! {
        return _senderDisplayName
    }
    
    func date() -> NSDate! {
        return _date
    }
    
    func isMediaMessage() -> Bool {
        return _isMediaMessage
    }
    
    func messageHash() -> UInt {
        return 1
    }
        
}
