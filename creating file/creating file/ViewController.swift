//
//  ViewController.swift
//  creating file
//
//  Created by Ghada Fahad on 18/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterName: UITextField!
    
    @IBOutlet weak var textAreaWrite: UITextView!
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var tableFolder: UITableView!
    var folderArr : [String] = []
    var folderSelect = ""
    var folderAlow = ""
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folderAlow = "NotAllow"
        switchOutlet.isOn = false
        loadData()
//        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//         create folder
//        do {
//            let dir = dirUrl?.appendingPathComponent("document10")
//            try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
//        } catch {
//            print("somthing wrong")
//
//
//        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//        // crete folder
//        do {
//            let dir = dirUrl?.appendingPathComponent("document10")
//            try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
//        } catch {
//            print("somthing wrong")
//        }
//
//
//        // create file
//        let dirforFile = dirUrl?.appendingPathComponent("documentOne").appendingPathComponent("namr.text")
//        let text = "hi everyone".data(using: .utf8)
//        fileManager.createFile(atPath: dirforFile!.path, contents: text, attributes: [:])
//                print(dirUrl!.path)

    }
    @IBAction func createFolderAction(_ sender: Any) {
//        let fileManager = FileManager.default
//        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//        let newDir = dirURL?.appendingPathComponent(enterName.text!)
//        do {
//            try fileManager.createDirectory(at: newDir!, withIntermediateDirectories: true)
//        } catch {
//            print("somthing wong ")
//        }
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
                    self.folderArr.append(folder)
                    print(folder)
                }
            }
            self.tableFolder.reloadData()
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
            folderArr.removeAll()
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
                let vc = segue.destination as! second_view
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
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableFolder.dequeueReusableCell(withIdentifier: "myCell") as! tableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectNmae = folderArr[indexPath.row]
//        print(selectName)
        if folderAlow == "AllowSelect" {
            folderSelect = folderArr[indexPath.row]
        }else{
            folderSelect = folderArr[indexPath.row]
            self.performSegue(withIdentifier: "SegueOtherView", sender: self)
         

        }
    }
//    func removeAll()
//    func reloadFolder() {
//        let fileManager = FileManager.default
//        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//        do {
//            let folders = try
//            fileManager.contentsOfDirectory(atPath: dirURL!.path)
//            print(folders)
//            
//            for folder in folders{
//                let checkFolder = dirURL?.appendingPathComponent(folder)
//                if checkFolder? .hasDirectoryPath == true {
//                    self.folderArr.append(folder)
//                } catch {
//                    print("something wrong")
//                }
//            }
//        }
//        
//    }
   
  
}

