//
//  AddFileViewController.swift
//  iOSFileSystem
//
//  Created by Ebtesam Alahmari on 24/11/2021.
//

import UIKit

class AddFileViewController: UIViewController {
    
    var folderName = ""
    let fileManager = FileManager.default
    var dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    @IBOutlet weak var fileNameLable: UITextField!
    @IBOutlet weak var contentFile: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveFile(_ sender: UIButton) {
        saveFile()
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveFile() {
        if fileNameLable.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please add file name", preferredStyle: .alert)
            let OkBtu = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OkBtu)
            present(alert, animated: true, completion: nil)
        }else {
            let dir = dirURL?.appendingPathComponent(folderName).appendingPathComponent(fileNameLable.text!+".txt")
            let contents = contentFile.text!.data(using: .utf8)
            fileManager.createFile(atPath: dir!.path, contents: contents, attributes: [:])
        }
    }
}
