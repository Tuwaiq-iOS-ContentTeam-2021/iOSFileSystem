//
//  ViewController.swift
//  iOSFileSystem
//
//  Created by Ebtesam Alahmari on 23/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var folderName: UITextField!
    @IBOutlet weak var fileName: UITextField!
    @IBOutlet weak var fileContent: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var foldersArray: [String] = []
    var selected = ""
    var fileManager = FileManager.default
    let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        reloadData()
    }
    
    
    @IBAction func addFolder(_ sender: UIButton) {
        saveFolder()
        foldersArray.removeAll()
        reloadData()
        tableView.reloadData()
        folderName.text = ""
    }
    
    @IBAction func addFile(_ sender: UIButton) {
        saveFile()
    }
  
    
    func alertMassage() {
        let alert = UIAlertController(title: "Error", message: "Missing information", preferredStyle: .alert)
        let OkBtu = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OkBtu)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: -UITableView
extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foldersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblFolderNames.text = foldersArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = foldersArray[indexPath.row]
    }
}

//MARK: -FileManager
extension ViewController {
    
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
    
    func saveFile() {
        if selected != "" {
            if fileName.text == "" {
                alertMassage()
            }else {
                let dir = dirURL?.appendingPathComponent(selected).appendingPathComponent(fileName.text!+".txt")
                let contents = fileContent.text!.data(using: .utf8)
                fileManager.createFile(atPath: dir!.path, contents: contents, attributes: [:])
            }
        }else {
            let alert = UIAlertController(title: "Error", message: "Please select a folder", preferredStyle: .alert)
            let OkBtu = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OkBtu)
            present(alert, animated: true, completion: nil)
        }
    }
    func saveFolder() {
        if folderName.text == "" {
            alertMassage()
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
    
}
