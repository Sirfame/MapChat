//
//  AllChatsViewController.swift
//  MapChat
//
//  Created by iGuest on 5/31/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

import Foundation
import UIKit

class AllChatsViewController : UIViewController {
    
    override func viewDidLoad() {
        //
        var convoArray: [(username: String, message: String)] = [("USERNAME", "MESSAGE")]
        func injectDummyData() {
            convoArray.append((username: "Chris", message: "wadup fam"))
            convoArray.append((username: "Joel", message: "help swift is killing me"))
            convoArray.append((username: "Sirfame", message: "yolo"))
            convoArray.append((username: "Alyssa", message: "hi peeps"))
        }
        injectDummyData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
