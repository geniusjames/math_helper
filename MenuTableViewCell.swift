//
//  MenuTableViewCell.swift
//  Math Helper
//
//  Created by Geniusjames on 09/01/2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {

        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = .clear
        self.textLabel?.textColor = .white
        self.textLabel?.font = .boldSystemFont(ofSize: 20)
        // Configure the view for the selected state
    }

}
