//
//  ViewController.swift
//  File Manager
//
//  Created by Najla Talal on 11/23/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var switchButton: UISwitch!
    
    var arrFolder:[String] = []
    
    let fileManager = FileManager.default
    var selectName = ""
    var switchNext = 0
    var nameSend = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadFolder()
    }
    //        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    //
    //     //create folder
    //        do {
    //
    //        let dir = dirUrl?.appendingPathComponent("documentOne")
    //        try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
    //
    //
    //    } catch {
    //        print("Something wrong")
    //    }
    //        //create file
    //        let dirForFile = dirUrl?.appendingPathComponent("documentOne").appendingPathComponent("name.txt")
    //        let text = "hi every one".data(using: .utf8)
    //        fileManager.createFile(atPath: dirForFile!.path, contents: text, attributes: [:])
    //        print(dirUrl!.path)
    //
    //    }
    
    
    @IBAction func AddFolderAction(_ sender: Any) {
//        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        //create folder
        do {
            
            let dir = dirUrl?.appendingPathComponent(enterName.text ?? "error")
            try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
            
            
        } catch {
            print("Something wrong")
        }
        print(dirUrl!.path)
        arrFolder.removeAll()
           reloadFolder()
        tableView.reloadData()


    }
    

    @IBAction func SwitchMove(_ sender: Any) {
        if switchButton.isOn == true {
            switchNext = 1
        }else{
            
            switchNext = 0
        }
    }
    
    @IBAction func AddFile(_ sender: Any) {
        guard selectName != "" else {return}
        guard enterName.text?.isEmpty != true else {return}
    let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
       
        let NameFile = dirUrl?.appendingPathComponent(selectName).appendingPathComponent(enterName.text! + ".text")
        let content = TextView.text.data(using: .utf8)
        fileManager.createFile(atPath: NameFile!.path,contents: content ,attributes: [:])
    }
func reloadFolder(){
    let fileManager = FileManager.default
    let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    do {
        let folders = try fileManager.contentsOfDirectory(atPath: dirUrl!.path)
        print(folders)
        for folder in folders {
            let checkFolder = dirUrl?.appendingPathComponent(folder)
            if checkFolder?.hasDirectoryPath == true {
                self.arrFolder.append(folder)
            } else {
                
                print("Sorry is not folder ")
                
            }
        }
    } catch {
        print("Dddd")
        
        
    }
}
    
    
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! ClassTableViewCell
        cell.myLable.text = arrFolder[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if switchNext == 0 {
            nameSend = arrFolder[indexPath.row]
            print(nameSend)
        }else{
            nameSend = arrFolder[indexPath.row]
            self.performSegue(withIdentifier: "move", sender: self)
        }
   
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveOther" {
            let vc = segue.destination as! ViewControllerTwo
            vc.NameFolder = nameSend
        }
    }
}


