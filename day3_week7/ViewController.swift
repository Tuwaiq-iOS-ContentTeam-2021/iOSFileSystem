//
//  ViewController.swift
//  day3_week7
//
//  Created by AlDanah Aldohayan on 23/11/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let fileManager = FileManager.default
    var arrFolder: [String] = []
    var selectedFolder = ""
    
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var fileTextField: UITextField!
    @IBOutlet weak var dataTextField: UITextField!
    
    @IBAction func fileButton(_ sender: Any) {
        guard selectedFolder != "" else {return}
//        guard textName.text!.isEmpty != true else {return}
        
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let dirForFile = dirUrl?.appendingPathComponent(selectedFolder).appendingPathComponent(fileTextField.text ?? "buttonError")
        fileManager.createFile(atPath: dirForFile!.path, contents: dataTextField.text?.data(using: .utf8), attributes: [:])
    }
    
    @IBAction func folderCreating(_ sender: Any) {
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let dir = dirUrl?.appendingPathComponent(textName.text ?? "button#@%$")
            try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
        } catch {
            print("SOMETHING IS WRONG")
        }
        arrFolder.removeAll()
        reload()
        tableView.reloadData()
        print(dirUrl?.path)
    }
    func reload () {
        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folders = try fileManager.contentsOfDirectory(atPath: dirUrl!.path)
            print(folders)
            
            for f in folders {
                let test = dirUrl?.appendingPathComponent(f)
                if test?.hasDirectoryPath == true {
                    self.arrFolder.append(f)
                }else{
                    print("not avaliable")
                }
            }
        } catch {
            print("WHATEVER")
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        reload()
        
       /* let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do {
            let dir = dirUrl?.appendingPathComponent("documentOne")
            try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
        } catch {
            print("SOMETHING IS WRONG")
        }
        
        let dirForFile = dirUrl?.appendingPathComponent("documentOne").appendingPathComponent("name.txt")
        let textData = "hi hello bye".data(using: .utf8)
        fileManager.createFile(atPath: dirForFile!.path, contents: textData, attributes: [:]) */
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFolder.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCellFile
        cell.labelCell.text = arrFolder[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFolder = arrFolder[indexPath.row]
    }

}




/*
 
 
 */
