//
//  ListOfFilesViewController.swift
//  FileManager
//
//  Created by Lola M on 11/23/21.
//

import UIKit

class ListOfFilesViewController: UIViewController {
    
    var arrOfFiles = [""]
    var selected = ""
    var content = ""
    var sendedContent = ""
    
    @IBOutlet weak var myTableView2: UITableView!
    @IBOutlet weak var myTextField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReloadFiles()
        navigationItem.title = "Files"
    }
    
    
    @IBAction func CreateFile(_ sender: Any) {
        
        guard
            myTextField2.text!.isEmpty != true else { return }
        
        let fileManager = FileManager.default
        let fileUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let newFile = fileUrl?.appendingPathComponent(myTextField2.text! + ".txt")
        let fileContent = content.data(using: .utf8)
        
        fileManager.createFile(atPath: newFile!.path, contents: fileContent, attributes: [:])
        
        let file = fileUrl?.appendingPathComponent("myNewFile").appendingPathComponent("myFile.txt")
        
        arrOfFiles.removeAll()
        ReloadFiles()
        myTableView2.reloadData()
        print(fileUrl!.path)
    }
    
    
    func ReloadFiles() {
        let fileManager = FileManager.default
        let fileUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let files = try fileManager.contentsOfDirectory(atPath: fileUrl!.path)
            
            for file in files {
                let checkFile = fileUrl?.appendingPathComponent(selected).appendingPathComponent(file)
                
                if checkFile?.hasDirectoryPath != true {
                    if file != ".DS_Store" {
                        self.arrOfFiles.append(file)
                        print("This is a File \(file)")
                    }
                } else {
                    print("This is not a file \(file)")
                }
            }
            
        } catch {
            print(".......")
        }
    }
    
    
    func ReadFile(fileName: String) {
        let fileManager = FileManager.default
        let fileUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let file = fileUrl?.appendingPathComponent(fileName)
        
        do {
            content = try String(contentsOf: file!, encoding: .utf8)
            print(content)
            let nextVc = NextVC()
            nextVc.mytextView.text = content
        } catch {
            print(".......")
        }
    }
}



// TableView Extension
extension ListOfFilesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOfFiles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! MyTableViewCell2
        
        cell.FileNameLabel.text = arrOfFiles[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = arrOfFiles[indexPath.row]
        sendedContent = content
        
        performSegue(withIdentifier: "filesToContent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filesToContent" {
            let nextVC = segue.destination as! NextVC
            nextVC.selected = content
            
            let destination = segue.destination as! NextVC
//            destination.sendedContent = mytextView.text
        }
    }
}
