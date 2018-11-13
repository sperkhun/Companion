//
//  SkillCell.swift
//  Companion
//
//  Created by Serhii PERKHUN on 10/18/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressSkill: UIProgressView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
