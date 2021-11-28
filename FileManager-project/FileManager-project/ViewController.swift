//
//  ViewController.swift
//  FileManager-project
//
//  Created by Badreah Saad on 23/11/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var folderTabel: UITableView!
    @IBOutlet weak var folderText: UITextField!
    
    let fileMang = FileManager.default
    var myFolderArray:[String] = []
    var slectedCell = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folderTabel.delegate = self
        folderTabel.dataSource = self
        reload()
    }
    
    
    @IBAction func creatFolder(_ sender: Any) {
        
        let url = fileMang.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do{
            let folder = url?.appendingPathComponent(folderText.text ?? "")
            try fileMang.createDirectory(at: folder!, withIntermediateDirectories: true, attributes: [:])
        } catch {
            print(error)
        }
        
        print(url!.path)
        
        myFolderArray.removeAll()
        reload()
        folderTabel.reloadData()
        
    }
    
    
    func reload() {
        
        let url = fileMang.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do {
            let myFolder = try fileMang.contentsOfDirectory(atPath: url!.path)
            print(myFolder)
            for folder in myFolder {
                let isFolder = url?.appendingPathComponent(folder)
                if isFolder?.hasDirectoryPath == true {
                    self.myFolderArray.append(folder)
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    
}



extension ViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFolderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = folderTabel.dequeueReusableCell(withIdentifier: "cellF") as! FolderCell
        
        cell.folderLabel.text = myFolderArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        slectedCell = myFolderArray[indexPath.row]
        self.performSegue(withIdentifier: "showFiles", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFiles" {
            let vc = segue.destination as! FolderContentVC
            vc.nameOfFile = slectedCell
            
        }
    }
    
    
    
}

