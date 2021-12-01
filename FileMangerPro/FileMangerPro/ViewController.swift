//
//  ViewController.swift
//  FileMangerPro
//
//  Created by Um Talal 2030 on 27/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var arrFolder:[String] = []
    var folderSelect = ""
    var folderAlow = ""
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var tableForDir: UITableView!
    @IBOutlet weak var switchOutlet: UISwitch!
    
    @IBOutlet weak var textAreaWrite: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folderAlow = "NotAllow"
        switchOutlet.isOn = false
        loadData()
        

    }
    
    
    @IBAction func CreateDirAction(_ sender: Any) {
        creatDir(dieName: enterName.text!)
    }
    
    @IBAction func CreateFileAction(_ sender: Any) {
        createFile(dirName: folderSelect, fileName: enterName.text!)
        
    }
    
    
    func loadData() {
        
        
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folders = try fileManger.contentsOfDirectory(atPath: dirURL!.path)
            print(folders)
            
            for folder in folders {
                if dirURL?.appendingPathComponent(folder).hasDirectoryPath == true {
                    self.arrFolder.append(folder)
                    print(folder)
                }
            }
            self.tableForDir.reloadData()
        }catch let error {
            print("some thing error : \(error)")
        }
    }
    
    func creatDir(dieName:String){
        guard dieName.isEmpty == false else {return}
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = dirURL!.appendingPathComponent(dieName)
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            arrFolder.removeAll()
            loadData()
        }catch {
            print("ddddd")
        }
        
    }
    
    func createFile(dirName:String,fileName:String){
        guard folderSelect != "" else {return}
        guard fileName.isEmpty != true else {return}
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        let file = dirURL?.appendingPathComponent(dirName).appendingPathComponent(fileName + ".txt")
        let data = textAreaWrite.text.data(using: .utf8)
        fileManger.createFile(atPath: file!.path, contents: data, attributes: [:])
    }
    
    var sel = 0
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "SegueOtherView" {
                let vc = segue.destination as! scendView
                vc.dir = folderSelect
            
        }
    }
    @IBAction func switchSelect(_ sender: Any) {
        if switchOutlet.isOn {
            folderAlow = "AllowSelect"
        }else{
            folderAlow = "NotAllow"
        }
    }
}




extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableForDir.dequeueReusableCell(withIdentifier: "CellName") as! ClassCell
        cell.LabelNameDir.text = arrFolder[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if folderAlow == "AllowSelect" {
            folderSelect = arrFolder[indexPath.row]
        }else{
            folderSelect = arrFolder[indexPath.row]
            self.performSegue(withIdentifier: "SegueOtherView", sender: self)
         

        }
        
    }
    
}
