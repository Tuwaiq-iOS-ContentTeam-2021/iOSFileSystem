//
//  tableViewCell.swift
//  creating file
//
//  Created by Ghada Fahad on 18/04/1443 AH.
//

import UIKit

class tableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var nameFolder: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
