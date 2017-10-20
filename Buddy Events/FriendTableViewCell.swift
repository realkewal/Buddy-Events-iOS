//
//  FriendTableViewCell.swift
//  Buddy Events
//
//  Created by Kewal on 20/10/17.
//  Copyright © 2017 Kewal. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

	@IBOutlet weak var frindImage: UIImageView!
	@IBOutlet weak var friendName: UILabel!
	@IBOutlet weak var friendAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
