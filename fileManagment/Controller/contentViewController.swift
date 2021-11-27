//
//  contentViewController.swift
//  fileManagment
//
//  Created by Rayan Taj on 24/11/2021.
//

import UIKit

class contentViewController: UIViewController {

    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
   
    var filename = ""
    var contentFiles = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        fileNameLabel.text = filename
        contentTextView.text = contentFiles
    
        
    }
    

}
