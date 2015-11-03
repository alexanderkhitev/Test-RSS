//
//  MainTableViewCell.swift
//  Test RSS
//
//  Created by Alexsander  on 11/2/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
