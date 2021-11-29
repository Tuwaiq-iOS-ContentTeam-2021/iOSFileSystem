//
//  ViewController.swift
//  Files
//
//  Created by Sahab Alharbi on 18/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var folderTV: UITableView!
   
    @IBOutlet weak var viewText: UITextView!
    @IBOutlet weak var folderName: UITextField!
    @IBOutlet weak var switchOutlet: UISwitch!

    let fileManager = FileManager.default
    var switching = ""
    var folderArr: [String] = []
    var select = ""
    var sendNme = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        sendNme = "NotAllow"
        reloaded()
        folderTV.delegate = self
        folderTV.dataSource = self
        switchOutlet.isOn = false
   
     
        
        
    }
    @IBAction func saveFile(_ sender: Any) {
        guard select.isEmpty != true else {return}
        let fileManager = FileManager.default
        let dUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let filename = dUrl?.appendingPathComponent(select).appendingPathComponent(folderName.text!+".txt")
        let content = viewText.text.data(using: .utf8)
        fileManager.createFile(atPath: filename!.path, contents: content, attributes: [:])
    }
    
    @IBAction func createFile(_ sender: Any) {
        //API الجهاز اللي نتحكم بكل
        let fileManager = FileManager.default
// المسار حق الفايل
        let dUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let ndir = dUrl!.appendingPathComponent(folderName.text!)
        do{
            
            try fileManager.createDirectory(at: ndir, withIntermediateDirectories: true, attributes: [:])
            folderArr.removeAll()
            reloaded()
        } catch{
        print("SomethingWrong")
      
    }
    
 }

    func reloaded (){
        let fileManager = FileManager.default
        let dURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
        let folderr = try fileManager.contentsOfDirectory(atPath: dURL!.path)
            print(folderr)
            
            for fold in folderr {
//                let check = dURL?.appendingPathComponent(fold)
                if dURL?.appendingPathComponent(fold).hasDirectoryPath == true {
                    self.folderArr.append(fold)
                    print(fold)
                }
            }
            self.folderTV.reloadData()
        } catch let error {
            print("something \(error)")
        }
 }

    
    
    @IBAction func switchAction(_ sender: Any) {
       if  switchOutlet.isOn == true {
            switching = "AllwoSelect"
            
        } else {
            switching = "NotAllow"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveTo" {
            let vc = segue.destination as! ViewController2
            vc.nameFolder = select
        }
    }
    
}

extension ViewController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell") as! FolderTableViewCell
        cell.folder.text = folderArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if switching == "AllwoSelect" {
            select = folderArr[indexPath.row]
        } else {
            sendNme = folderArr[indexPath.row]
            self.performSegue(withIdentifier: "moveTo", sender: self)
            
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            folderArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
          
        }
    }
    
}


