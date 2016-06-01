//
//  AllChatsTableViewCell.swift
//  MapChat
//
//  Created by iGuest on 5/24/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

// AllChatTableViewCell: Handles the cells of the TableView in the Chat screen.

import UIKit

class AllChatTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}