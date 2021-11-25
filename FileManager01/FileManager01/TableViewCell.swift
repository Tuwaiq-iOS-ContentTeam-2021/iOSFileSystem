//
//  TableViewCell.swift
//  FileManager01
//
//  Created by Taraf Bin suhaim on 19/04/1443 AH.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var FolderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
