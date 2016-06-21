//
//  ChatCell.swift
//  ParseChat
//
//  Created by Baula Xu on 6/21/16.
//  Copyright © 2016 Baula Xu. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
