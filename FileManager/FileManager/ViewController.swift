//
//  ViewController.swift
//  FileManager
//
//  Created by Wejdan Alkhaldi on 18/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var switches: UISwitch!
    @IBOutlet weak var textfieldfolder: UITextField!
    @IBOutlet weak var tableVc: UITableView!
    @IBOutlet weak var entertext: UITextField!
    @IBOutlet weak var switchVc: UISwitch!
    var switchmove = 0
    var nameSend = ""
    var arrfolder : [String] = []
    var selectName = ""
    let file = FileManager.default
    override func viewDidLoad() {
        super.viewDidLoad()
        switchVc.setOn(false, animated: false)
        relodFolder()
        tableVc.delegate = self
        tableVc.dataSource = self
    }
    
    @IBAction func buttonfolder(_ sender: Any) {
        let file = FileManager.default
        let dirUrl = file.urls(for: .documentDirectory, in: .userDomainMask).first
        let directory = dirUrl?.appendingPathComponent(textfieldfolder.text!)
        print(dirUrl?.path)
        do {
            try file.createDirectory(at: directory!, withIntermediateDirectories: true , attributes: [:])
        }catch {
            print("Somthing wrong")
        }
        arrfolder.removeAll()
        relodFolder()
        tableVc.reloadData()
        
    }
    func relodFolder() {
        let file = FileManager.default
        
        let dirURL = file.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folders = try file.contentsOfDirectory(atPath: dirURL!.path)
            print(folders)
            
            for folder in folders {
                let test = dirURL?.appendingPathComponent(folder)
                if test?.hasDirectoryPath == true {
                    self.arrfolder.append(folder)
                }else{
                    print("sorry is not folder\(folder)")
                }
                
            }
            
        }catch{
            print("file")
        }
        
    }
    func creatDir(dieName:String){
        guard dieName.isEmpty == false else {return}
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = dirURL!.appendingPathComponent(dieName)
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            arrfolder.removeAll()
            relodFolder()
        }catch {
            print("ddddd")
        }
        
    }
    @IBAction func buttondis(_ sender: Any) {
        guard selectName != "" else {return}
        guard entertext.text!.isEmpty != true else {return}
        let file = FileManager.default
        let dirURL = file.urls(for:.documentDirectory, in: .userDomainMask).first
        let nameFile = dirURL?.appendingPathComponent(selectName).appendingPathComponent(entertext.text! + ".txt")
        let content = entertext.text?.data(using: .utf8)
        file.createFile(atPath: nameFile!.path, contents: content, attributes: [:])
        
    }
    
    @IBAction func switchVc(_ sender: Any) {
        if switchVc.isOn == true {
            view.backgroundColor = .lightGray
        }else{
            view.backgroundColor = .systemBrown
        }
        
    }
    
    @IBAction func switchesaction(_ sender: Any) {
      if switches.isOn == true {
            switchmove = 1
        }else{
            switchmove = 0
        }
    }
    
}




extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrfolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVc.dequeueReusableCell(withIdentifier: "CellVc") as! TableCell
        cell.labelVc.text = arrfolder[indexPath.row]
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if switchmove == 0 {
            selectName = arrfolder[indexPath.row]
        }else{
            nameSend = arrfolder[indexPath.row]
            self.performSegue(withIdentifier: "move", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "move"{
            let vc = segue.destination as! Newview
            vc.dir = nameSend
    }
    }
}
