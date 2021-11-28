//
//  FolderContentVC.swift
//  FileManager-project
//
//  Created by Badreah Saad on 24/11/2021.
//

import UIKit

class FolderContentVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var contentTabel: UITableView!
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var fileContent: UITextView!
    
    let fileManager = FileManager.default
    var url:URL?
    var contentArray:[String] = []
    var nameOfFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTabel.delegate = self
        contentTabel.dataSource = self
        
        url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let content = url?.appendingPathComponent(nameOfFile)
        do {
            let contentOfFile = try fileManager.contentsOfDirectory(atPath: content!.path)
            print(contentOfFile)
            self.contentArray = contentOfFile
        } catch {
            print(error)
        }
        print(url!)
        
    }
    
    
    func readFileContent(nameFile:String) {
        
        let content = url?.appendingPathComponent(nameOfFile).appendingPathComponent(nameFile)
        do {
            let contentOfFile = try String(contentsOf: content!, encoding: .utf8)
            print(contentOfFile)
            self.fileContent.text = contentOfFile
        }catch {
            print(error)
        }
        
    }
    
    
    
}


extension FolderContentVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTabel.dequeueReusableCell(withIdentifier: "cellC") as! ContentCell
        
        cell.folderContent.text = contentArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fileName.text = contentArray[indexPath.row]
        readFileContent(nameFile: contentArray[indexPath.row])
    }
    
    
}


