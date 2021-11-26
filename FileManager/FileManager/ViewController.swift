//
//  ViewController.swift
//  FileManager
//
//  Created by Areej Mohammad on 18/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    var arrFolder : [String] = []
    var selectname = ""
    var switchmove = 0
    var nameSend = ""
    let filemanger = FileManager.default

    
    @IBOutlet weak var tableFolder: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameOfFolder: UITextField!
    @IBOutlet weak var switchmoveOutlet: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableFolder.delegate = self
        tableFolder.dataSource = self
        reloadFolder()
    }
    
    @IBAction func creatfolder(_ sender: Any) {
        let dirUrl = filemanger.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let dir = dirUrl?.appendingPathComponent(nameOfFolder.text!)
            try filemanger.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
        }catch {
            print("Something error")
        }
        arrFolder.removeAll()
        reloadFolder()
        tableFolder.reloadData()
//        print(dirUrl)
    }
    
    @IBAction func createFile(_ sender: Any) {
        
        guard selectname != "" else {return}
        guard nameOfFolder.text?.isEmpty != true else {return}
        let filemanger = FileManager.default
        
        let dirUrl = filemanger.urls(for: .documentDirectory, in: .userDomainMask).first

        let nameFile = dirUrl?.appendingPathComponent(nameOfFolder.text! + ".txt")
        
        let content = nameOfFolder.text?.data(using: .utf8)
                filemanger.createFile(atPath: nameFile!.path , contents: content, attributes: [:])
                print(dirUrl!.path)
        arrFolder.removeAll()
        reloadFolder()
        tableFolder.reloadData()
    }
    
    func reloadFolder(){
        let filemanger = FileManager.default
        let dirURL = filemanger.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folders = try filemanger.contentsOfDirectory(atPath: dirURL!.path)
            print("FOLDER=============" , folders)
            for folder in folders {
                let test = dirURL?.appendingPathComponent(folder)
                if test?.hasDirectoryPath == true {
                    self.arrFolder.append(folder)
                }else {
                    print("This is not Folder")

                }
            }
        }catch {
            print("Something error")
        }
    }
    
    @IBAction func switchMoveAtion(_ sender: Any) {
        if switchmoveOutlet.isOn == true{
            switchmove = 1
        }else{
            switchmove = 0
        }
    }
}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableFolder.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! ClassTableCell
        cell.nameFolder.text = arrFolder[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if switchmove == 0 {
        selectname = arrFolder[indexPath.row]
        }else{
            nameSend = arrFolder[indexPath.row]
            self.performSegue(withIdentifier: "moveOther", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveOther" {
            let vc = segue.destination as! VC2
            vc.nameFolder = nameSend
        }
    }
}

