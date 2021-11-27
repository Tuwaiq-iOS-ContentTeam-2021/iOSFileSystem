//
//  FileTableViewCell.swift
//  fileManagment
//
//  Created by Rayan Taj on 23/11/2021.
//

import UIKit

class FileTableViewCell: UITableViewCell {

    @IBOutlet weak var fileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
