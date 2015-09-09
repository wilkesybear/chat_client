//
//  MessageCell.swift
//  chat_client
//
//  Created by Andrew Wilkes on 9/9/15.
//  Copyright (c) 2015 Andrew Wilkes. All rights reserved.
//

import UIKit
import Parse

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageCell: UILabel!
    
    var message: PFObject! {
        didSet {
            var text = ""
            if let user = message["user"] as? PFUser {
                text = user.username! + ": "
            }
            text += (message["text"] as? String)!
            messageCell.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
