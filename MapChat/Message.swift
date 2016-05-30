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
    
    init(text: String?, sender: String?) {
        self._date = NSDate()
        self._senderId = NSUUID().UUIDString
        self._senderDisplayName: String 
    }
    
    func senderId() -> String {
        return _senderId
    }
        
}
