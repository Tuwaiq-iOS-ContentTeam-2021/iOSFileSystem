//
//  FolderTableViewCell.swift
//  Files
//
//  Created by Sahab Alharbi on 18/04/1443 AH.
//

import UIKit

class FolderTableViewCell: UITableViewCell {

    @IBOutlet weak var folder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
