//
//  NextVC.swift
//  FileManager
//
//  Created by Lola M on 11/23/21.
//

import UIKit

class NextVC: ListOfFilesViewController {
    
    let previousVC = ListOfFilesViewController()

    @IBOutlet weak var mytextView: UITextView!
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "FileTitle"
        mytextView.text = "Type Your Text.."

        ReadFile(fileName: selected)
    }
    
    @IBAction func saveFileContent(_ sender: Any) {
        WriteFiles()
        dismiss(animated: true)
        mytextView.text = previousVC.sendedContent
    }
    
    
    func WriteFiles() {
        let fileName = selected
        let content = mytextView.text
        
        let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl = dir.appendingPathComponent(fileName)
        
        do {
            try content?.write(to: fileUrl, atomically: false, encoding: .utf8)
        } catch {
            print("........")
        }
    }

    
}

