//
//  MyTableViewCell.swift
//  FileManager
//
//  Created by Lola M on 11/23/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var dirNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
