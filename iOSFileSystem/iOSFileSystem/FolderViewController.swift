//
//  FolderViewController.swift
//  iOSFileSystem
//
//  Created by Ebtesam Alahmari on 24/11/2021.
//

import UIKit

class FolderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var folderName: UITextField!
    
    var foldersArray: [String] = []
    var fileManager = FileManager.default
    let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    var selectedFolder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        reloadData()
    }
    
    @IBAction func addFolder(_ sender: Any) {
        saveFolder()
        foldersArray.removeAll()
        reloadData()
        tableView.reloadData()
        folderName.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFileVC" {
            let destination = segue.destination as! FileListViewController
            destination.folderName = selectedFolder
        }
    }
}


//MARK: -UITableView
extension FolderViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foldersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        cell.lblFolderNames.text = foldersArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFolder = foldersArray[indexPath.row]
        performSegue(withIdentifier: "toFileVC", sender: nil)
        
    }
}

//MARK: -FileManager
extension FolderViewController {
    func saveFolder() {
        if folderName.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please add folder name", preferredStyle: .alert)
            let OkBtu = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OkBtu)
            present(alert, animated: true, completion: nil)
        }else {
            do {
                let dir = dirURL?.appendingPathComponent(folderName.text!)
                try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
                
            }catch {
                print("There is an error")
            }
            print(dirURL!.path)
        }
    }
    
    func reloadData() {
        do {
            let folders = try fileManager.contentsOfDirectory(atPath: dirURL!.path)
            for folder in folders {
                let check = dirURL?.appendingPathComponent(folder)
                if check?.hasDirectoryPath == true {
                    foldersArray.append(folder)
                }
            }
        }catch {
            print("There is an error")
        }
    }
    
}
