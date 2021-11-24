//
//  FileCell.swift
//  FileManager_Practice
//
//  Created by WjdanMo on 24/11/2021.
//

import UIKit

class FileCell: UITableViewCell {

    
    @IBOutlet weak var fileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
