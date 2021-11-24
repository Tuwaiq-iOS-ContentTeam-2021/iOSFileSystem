//
//  ViewController.swift
//  fileManager
//
//  Created by TAGHREED on 18/04/1443 AH.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    var fArr : [String] = []
    let fm = FileManager.default
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var enterFile: UITextField!
    @IBOutlet weak var switchMoveOut: UISwitch!
    @IBOutlet weak var entertext: UITextView!
    var nameSend = ""
    var selectName = ""
    var switchMove = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        relodFolder()
        tv.dataSource = self
        tv.delegate = self
        
    }
    
   
 
    
    @IBAction func create(_ sender: Any) {
        
        let dirUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do {
            
            let dir = dirUrl?.appendingPathComponent(enterFile.text ?? "")
            try fm.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
            print(dirUrl)
            
            
        }catch{
            print("somthing wrong")
        }
        
        
        fArr.removeAll()
        relodFolder()
        tv.reloadData()
        print("-----------------------")
        print(dirUrl!.path)
        // create file
        //        let dirForFile = dirUrl?.appendingPathComponent("doc-1").appendingPathComponent("name.txt")
        //        let text = "hi every one".data(using: .utf8)
        //        fm.createFile(atPath: dirForFile!.path, contents: text , attributes: [:])
        //        print(dirUrl!.path)
        //
    }
    
    
    func relodFolder (){
        let dirURL = fm.urls(for: .documentDirectory, in: .userDomainMask ).first
        do {
            
            let folders = try fm.contentsOfDirectory(atPath: dirURL!.path)
            print(folders)
            
            
            
            for folder in folders {
                let checkFolder = dirURL?.appendingPathComponent(folder)
                if checkFolder?.hasDirectoryPath == true{
                    self.fArr.append(folder)
                }
                
            }
        }catch{
            print("ym")
        }
        
    }
    
    
    @IBAction func createFile(_ sender: Any) {
        guard selectName != "" else {return}//did delect
        guard enterFile.text!.isEmpty != true  else {return}
        let dirurl = fm.urls(for: .documentDirectory, in: .userDomainMask).first
        let namefile = dirurl?.appendingPathComponent(selectName).appendingPathComponent(enterFile.text! + ".txt")
        let content = entertext.text.data(using: .utf8)//تشفير محتوى الملف
        fm.createFile(atPath: namefile!.path, contents: content, attributes: [ : ])
        
        
        
    }
    
  
    
    
    @IBAction func switchMoveAction(_ sender: Any) {
        if switchMoveOut.isOn == true {
            switchMove = 1
        }else{
            switchMove = 0
        }
            
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.lb.text = fArr[indexPath.row]
        cell.layer.cornerRadius = 20
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if switchMove == 0 {
            selectName = fArr [indexPath.row]//create
        }else{
            nameSend = fArr[indexPath.row]
            self.performSegue(withIdentifier: "seg", sender: self)//move
        }
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg" {
            let vc = segue.destination as! viViewController2
            vc.nameFolder = nameSend
            
        }
        
        
    }
    
    
    
}
    
    
    
    

