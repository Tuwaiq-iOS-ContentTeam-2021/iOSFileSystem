//
//  FilesVC.swift
//  FileManager_Practice
//
//  Created by WjdanMo on 24/11/2021.
//

import UIKit

class FilesVC : UIViewController {

    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var fileContent: UITextView!
    @IBOutlet weak var filesTableView: UITableView!
    
    var selectedFolderName : String = ""
    var filesArray : [String] = []
    let manager = FileManager.default
    var folderUrl : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filesTableView.delegate = self
        filesTableView.dataSource = self
        folderName.text = selectedFolderName
        print(selectedFolderName)
        folderUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileUrl = folderUrl!.appendingPathComponent(selectedFolderName)
        
        do {
            let files = try manager.contentsOfDirectory(atPath: fileUrl.path)
            self.filesArray = files
        }
        catch{
            print(error.localizedDescription)
        }
        
        filesTableView.layer.cornerRadius = 10
        fileContent.layer.cornerRadius = 10
    }
}

extension FilesVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fileCell = tableView.dequeueReusableCell(withIdentifier: "fileCell" , for: indexPath) as! FileCell
        fileCell.fileName.text = filesArray[indexPath.row]
        
        fileCell.layer.cornerRadius = 10
        
        return fileCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fileName.text = filesArray[indexPath.row]
        fileContent.text = filesArray[indexPath.row]
        showFileContent(fileName: filesArray[indexPath.row])
    }
    
}

extension FilesVC {
    
    func showFileContent(fileName : String){
        let Url = folderUrl!.appendingPathComponent(selectedFolderName).appendingPathComponent(fileName)
        
        do {
            let content = try String(contentsOf: Url, encoding: .utf8)
            fileContent.text = content
        }
        catch{
            print(error.localizedDescription )
        }
    }
}
