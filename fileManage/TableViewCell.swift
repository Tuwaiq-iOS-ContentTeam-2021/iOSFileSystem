//
//  TableViewCell.swift
//  fileManage
//
//  Created by Nora on 18/04/1443 AH.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Celli: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
