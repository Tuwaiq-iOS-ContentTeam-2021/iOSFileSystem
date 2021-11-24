//
//  ViewController.swift
//  FileManager
//
//  Created by Lola M on 11/23/21.
//


//Problems I need to Fix:
// All Files of all folders shown!! I want to view only files of this folder!
// I want to show content of file in thirdViewController. edit, and Save!


import UIKit

class ViewController: UIViewController {
    
    var arrOfFolders = [""]
//    var arrOfFolders = [""] {
//        didSet {
//            myTableView.reloadData()
//        }
//    }
    
    var selected = ""
    var sendeValue = ""
    
    @IBOutlet weak var textFiled: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadDirs()
        navigationItem.title = "Folders"
    }
    
    
    @IBAction func AddDirBtn(_ sender: Any) {
        
        guard
            textFiled.text!.isEmpty != true else { return }
        
        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let newDir = dirUrl!.appendingPathComponent(textFiled.text!)
        
        do {
            try fileManager.createDirectory(at: newDir, withIntermediateDirectories: true, attributes: [:])
        } catch {
            print(".......")
        }
        
        let dirFile = dirUrl?.appendingPathComponent(newDir.path).appendingPathComponent("myFile.txt")
        
        arrOfFolders.removeAll()
        reloadDirs()
        myTableView.reloadData()
        print(dirUrl!.path)
        
    }
    
    
    func reloadDirs() {
        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//        print(dirUrl?.path)
        do {
            let dirs = try fileManager.contentsOfDirectory(atPath: dirUrl!.path)
            
            for dir in dirs {
                let checkFolder = dirUrl?.appendingPathComponent(selected).appendingPathComponent(dir)
                if  checkFolder?.hasDirectoryPath == true {
                    self.arrOfFolders.append(dir)
                    print("This is a directory \(dir)")
                } else {
                    print("This is not a directory \(dir)")
                }
            }
            
        } catch {
            print(".......")
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOfFolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell") as! MyTableViewCell
        
        cell.dirNameLabel.text = arrOfFolders[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = arrOfFolders[indexPath.row]
        sendeValue = arrOfFolders[indexPath.row]

        performSegue(withIdentifier: "dirsToFiles", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "dirsToFiles" {
            let nextVC = segue.destination as! ListOfFilesViewController
//            let destination = segue.destination as! ListOfFilesViewController
        }
    }

}


