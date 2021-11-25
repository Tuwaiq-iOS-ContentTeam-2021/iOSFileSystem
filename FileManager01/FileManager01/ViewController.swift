//
//  ViewController.swift
//  FileManager01
//
//  Created by Taraf Bin suhaim on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var arrayFolders : [String] = []
    var selectName = ""
    var nameSend = ""
    var moveOrDisplay = 0
    let fileManager = FileManager.default
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var switchMove: UISwitch!
    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        relodFolder()
    }
    
 
    @IBAction func CreateFile(_ sender: Any) {
        
        guard selectName != "" else {return}
        guard textView.text!.isEmpty != true else {return}
        
        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let file = dirUrl?.appendingPathComponent(selectName)
            .appendingPathComponent(text.text! + ".txt")
        let context = textView.text.data(using: .utf8)
        fileManager.createFile(atPath: file!.path, contents: context, attributes: [:])
    }
    
    @IBAction func CreateFolder(_ sender: Any) {
        
        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let folder = dirUrl?.appendingPathComponent(text.text!)
        do {
            try fileManager.createDirectory(at: folder!, withIntermediateDirectories: true, attributes: [:])
        } catch {}
        print(dirUrl!.path)
        arrayFolders.removeAll()
        relodFolder()
        tabelView.reloadData()
    }
    @IBAction func moveTo(_ sender: Any) {
        
        if switchMove.isOn == true {
            moveOrDisplay = 1
        }else {
            moveOrDisplay = 0
        }
    }
    
    func relodFolder(){
        
        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folders =  try fileManager.contentsOfDirectory(atPath: dirUrl!.path)
            print(folders)
            
            for folder in folders {
                let check = dirUrl?.appendingPathComponent(folder)
                if check?.hasDirectoryPath == true {
                    self.arrayFolders.append(folder)
                } else {
                    print("sory is not folder \(folder)")
                }
            }
        } catch {}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "move" {
            let vc = segue.destination as! TwoViewConrtoller
            vc.name = nameSend
        }
    }
   
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.FolderLabel.text = arrayFolders[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if moveOrDisplay == 0 {
            selectName = arrayFolders[indexPath.row]
        } else {
            nameSend = arrayFolders[indexPath.row]
            self.performSegue(withIdentifier: "move", sender: self)
        }
    }
}

