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
        var tupleArray: [(username: String, message: String)] = [("USERNAME", "MESSAGE")]
        func injectDummyData() {
            tupleArray.append((username: "Chris", message: "wadup fam"))
            tupleArray.append((username: "Joel", message: "help swift is killing me"))
            tupleArray.append((username: "Sirfame", message: "yolo"))
            tupleArray.append((username: "Alyssa", message: "hi peeps"))
        }
        injectDummyData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
