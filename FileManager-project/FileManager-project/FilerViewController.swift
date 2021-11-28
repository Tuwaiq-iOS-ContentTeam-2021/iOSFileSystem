//
//  FilerViewController.swift
//  FileManager-project
//
//  Created by Badreah Saad on 24/11/2021.
//

import UIKit

class FilerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var fileTabel: UITableView!
    @IBOutlet weak var fileText: UITextField!
    @IBOutlet weak var fileTextV: UITextView!
    
    let fileMange = FileManager.default
    var myFileArray :[String] = []
    var selectedFolder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileTabel.delegate = self
        fileTabel.dataSource = self
        reload()
    }
    
    
    @IBAction func creatFile(_ sender: Any) {
        
        guard selectedFolder != "" else {return}
        guard fileText.text?.isEmpty != true else {return}
        
        let Url = fileMange.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let file = Url?.appendingPathComponent(selectedFolder).appendingPathComponent(fileText.text ?? "" + ".txt")
        let text = fileTextV.text.data(using: .utf8)
        fileMange.createFile(atPath: file!.path, contents: text, attributes: [:])
        
    }
    
    
    func reload() {
        
        let url = fileMange.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do {
            let myFile = try fileMange.contentsOfDirectory(atPath: url!.path)
            print(myFile)
            for file in myFile {
                let isFile = url?.appendingPathComponent(file)
                if isFile?.hasDirectoryPath == true {
                    self.myFileArray.append(file)
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    
    
}


extension FilerViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fileTabel.dequeueReusableCell(withIdentifier: "cell") as! FileCell
        
        cell.fileLabel.text = myFileArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFolder = myFileArray[indexPath.row]
        print(selectedFolder)
    }
    
    
}
