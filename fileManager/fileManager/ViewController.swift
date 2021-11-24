//
//  ViewController.swift
//  fileManager
//
//  Created by Abdullah AlRashoudi on 11/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableFolder: UITableView!
    
    let fileManager = FileManager.default
    var arrayfolder: [String] = []
    @IBOutlet weak var folderName: UITextField!
    @IBOutlet weak var fileContent: UITextField!
    @IBOutlet weak var fileName: UITextField!
    @IBOutlet weak var folderOrFile: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func creatFolder() {
     
        let fileManager = FileManager.default
        let directoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let directory = directoryUrl?.appendingPathComponent(folderName.text!)
        do {
            try fileManager.createDirectory(at: directory!, withIntermediateDirectories: true, attributes: [:])

        } catch {
            print("Someting wrong")
            
        }
        print(directoryUrl!.path)
    }
    
    func createFile(){

        let fileManager = FileManager.default
        let directoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
//        directoryUrl?.appendingPathComponent(folderName.text!)
        let creatMyFile = directoryUrl?.appendingPathComponent(folderName.text!).appendingPathComponent(fileName.text! + ".txt")
        let text = fileContent.text!.data(using: .utf8)
        fileManager.createFile(atPath: creatMyFile!.path, contents: text, attributes: nil)
        
        print(directoryUrl!.path)
    }
    
    @IBAction func chooseFolderOrFile(_ sender: Any) {
        
    
        
        if folderOrFile.selectedSegmentIndex == 1 {
            createFile()
            folderName.text = ""
            arrayfolder.append(fileName.text!)
            tableFolder.reloadData()
        } else if folderOrFile.selectedSegmentIndex == 0 {

            creatFolder()
            fileName.text = ""
            fileContent.text = ""
            arrayfolder.append(folderName.text!)
            tableFolder.reloadData()
        }
        
        
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayfolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableFolder.dequeueReusableCell(withIdentifier: "cellFolderName") as! FolderNameCell
        cell.labelFolder.text = arrayfolder[indexPath.row]
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fileManager = FileManager.default
        let directoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        print(directoryUrl!.path)
        tableFolder.reloadData()
            }
    
}
