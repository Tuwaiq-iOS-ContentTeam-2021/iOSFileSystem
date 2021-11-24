//
//  TableViewCell2.swift
//  fileManager
//
//  Created by TAGHREED on 19/04/1443 AH.
//

import UIKit

class TableViewCell2: UITableViewCell {
    
    @IBOutlet weak var tvLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
