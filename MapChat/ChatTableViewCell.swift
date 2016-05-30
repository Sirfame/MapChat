//
//  ChatTableViewCell.swift
//  MapChat
//
//  Created by iGuest on 5/24/16.
//  Copyright © 2016 Neward's Favs. All rights reserved.
//

// ChatTableViewCell: Handles the cells of the TableView in the Chat screen.

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // IBOutlets //////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////

    // lblMessage: The message of the cell.
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
