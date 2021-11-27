//
//  ViewController2.swift
//  fileManagment
//
//  Created by Rayan Taj on 24/11/2021.
//

import UIKit

class ViewController2: UIViewController {
   
    @IBOutlet weak var filesTableView: UITableView!
    @IBOutlet weak var folderNameLabel: UILabel!
    
    var folderName : String = " "
    var foldersArray :[String] = []
    
    let fileManager = FileManager.default
    
    var  appFilesDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        folderNameLabel.text = folderName
        
    print(foldersArray)
        relodFiles()

   
        
    }
    

    func relodFiles()  {
                
        do {

            let desiredFolderDirectory = appFilesDirectory?.appendingPathComponent(folderName)
            let fileURLs = try fileManager.contentsOfDirectory(atPath: desiredFolderDirectory!.path)
//            foldersArray.removeAll()
            print(fileURLs)
            
            foldersArray = fileURLs
            
            filesTableView.reloadData()
            
            
        } catch {
            print("Error while enumerating files \(appFilesDirectory!.path): \(error.localizedDescription)")
        }
    }
}



extension ViewController2 : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foldersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fileCell = filesTableView.dequeueReusableCell(withIdentifier: "FileTableViewCell") as! FileTableViewCell
        
        fileCell.layer.cornerRadius = 15
        
        
        fileCell.fileNameLabel.text = foldersArray[indexPath.row]
        
        return fileCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        do {
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "contentViewController") as? contentViewController
            
            let desiredFolderDirectory = appFilesDirectory?.appendingPathComponent(folderName).appendingPathComponent(foldersArray[indexPath.row], isDirectory: false)

        let fileContent = try String(contentsOf: desiredFolderDirectory!, encoding: .utf8)
            print("content : " , fileContent)
            
            vc?.contentFiles = fileContent
            
            vc?.filename = foldersArray[indexPath.row]
            
            self.navigationController?.pushViewController(vc!, animated: true)
        } catch  {
            
        }
   
        
        
        
        
    }

    
    
    
}

