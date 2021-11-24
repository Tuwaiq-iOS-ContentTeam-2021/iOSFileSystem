//
//  ContentViewController.swift
//  iOSFileSystem
//
//  Created by Ebtesam Alahmari on 24/11/2021.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var contentView: UITextView!
    
    var fileName = ""
    var folderName = ""
    var fileManager = FileManager.default
    var dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = fileName
        readFile()
    }
    
    func readFile()  {
        let dir = (dirURL?.appendingPathComponent(folderName).appendingPathComponent(fileName))!
        do {
            let content = try String(contentsOf: dir, encoding: .utf8)
            contentView.text = content
        }catch {
            print("Error")
        }
    }
}
