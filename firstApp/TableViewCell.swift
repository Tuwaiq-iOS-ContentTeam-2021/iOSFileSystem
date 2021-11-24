//
//  TableViewCell.swift
//  firstApp
//
//  Created by loujain on 23/11/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var celLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
