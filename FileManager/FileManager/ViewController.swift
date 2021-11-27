//
//  ViewController.swift
//  FileManager
//
//  Created by Taraf Bin suhaim on 22/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var ArrayFolders = [String]()
    var folderSelect = ""
    var folderAlow = ""
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        switchOutlet.isOn = false
        folderAlow = "NotAllow"
        loadData()
    }
    
    @IBAction func craeteFolder(_ sender: Any) {
        creatDir(dieName: textName.text!)
    }
    
    @IBAction func craeteFile(_ sender: Any) {
        createFile(dirName: folderSelect, fileName: textName.text!)
    }
    
    @IBAction func move(_ sender: Any) {
        if switchOutlet.isOn {
            folderAlow = "Allow"
        }else{
            folderAlow = "NotAllow"
        }
    }
    
    func loadData(){
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folders = try fileManger.contentsOfDirectory(atPath: dirURL!.path)
            print(folders)
            
            for folder in folders {
                if dirURL?.appendingPathComponent(folder).hasDirectoryPath == true {
                  self.ArrayFolders.append(folder)
                  print(folder)
                }
            }
            self.tabelView.reloadData()
        }catch {}
    }
    
    func creatDir(dieName:String){
        guard dieName.isEmpty == false else {return}
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = dirURL!.appendingPathComponent(dieName)
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            ArrayFolders.removeAll()
            loadData()
            } catch{}
         }
    
    func createFile(dirName:String,fileName:String){
        guard folderSelect != "" else {return}
        guard fileName.isEmpty != true else {return}
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        let file = dirURL?.appendingPathComponent(dirName).appendingPathComponent(fileName + ".txt")
        let data = textArea.text.data(using: .utf8)
        fileManger.createFile(atPath: file!.path, contents: data, attributes: [:])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "Segue" {
                let vc = segue.destination as! SecondViewController
                vc.name = folderSelect
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayFolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FirstTableViewCell
        cell.LabelNameDir.text = ArrayFolders[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if folderAlow == "Allow" {
            folderSelect = ArrayFolders[indexPath.row]
        }else{
            folderSelect = ArrayFolders[indexPath.row]
            self.performSegue(withIdentifier: "Segue", sender: self)
        }
    }
}

