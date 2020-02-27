//
//  TimetableTVCell.swift
//  Murtazaliev
//
//  Created by Murtazaliev Shamil on 27/02/2020.
//  Copyright © 2020 Shamil Murtazaliev. All rights reserved.
//

import UIKit

class TimetableTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
