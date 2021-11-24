//
//  Cell.swift
//  FileManager_Practice
//
//  Created by WjdanMo on 23/11/2021.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var folderName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
