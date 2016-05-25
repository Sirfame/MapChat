//
//  OngoingChatTableViewCell.swift
//  MapChat
//
//  Created by iGuest on 5/24/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

// OngoingChatTableViewCell: Handles the cells of the TableView in the Chat Menu.

import UIKit

class OngoingChatTableViewCell: UITableViewCell {
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // IBOutlets //////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
        // lblOngoingChat: The text displayed in the cell, indicating an ongoing chat.
        @IBOutlet weak var lblOngoingChat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
