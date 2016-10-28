//
//  ChoicesTableViewCell.swift
//  QuizTastic
//
//  Created by Wayne Rumble on 16/08/2016.
//  Copyright © 2016 Wayne Rumble. All rights reserved.
//

import UIKit

class ChoicesTableViewCell: UITableViewCell {
    
    @IBOutlet var choiceLabel: UILabel!
    @IBOutlet var selectedCellImage: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        selectedCellImage.image = nil
    }

}
