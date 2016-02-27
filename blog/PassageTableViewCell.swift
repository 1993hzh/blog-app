//
//  PassageTableViewCell.swift
//  blog
//
//  Created by Leo on 2/27/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit

class PassageTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var postDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
