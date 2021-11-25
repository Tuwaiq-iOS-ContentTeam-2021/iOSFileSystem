//
//  ViewController.swift
//  projactFile
//
//  Created by Abrahim MOHAMMED on 23/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var switchMoveOutlet: UISwitch!
    @IBOutlet weak var MyViweTexte: UITextView!
    
    @IBOutlet weak var textFiled: UITextField!
    var switchMove = 0
    var getName = ""
    var nameSend = ""
    let fileManager = FileManager.default
    
    var arrFolder:[String] = []
    
    @IBOutlet weak var tableViwe: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableViwe.dataSource = self
       tableViwe.delegate = self
        relodFolder()
    
    }


    @IBAction func createFolder(_ sender: Any) {
       addFolder()
    }
    
    
    @IBAction func createFile(_ sender: Any) {
        NewFile()
    }
    
    
    func relodFolder(){
        
        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        print(dirUrl)
       
        
        //withe path file
        
        
        //creat folder

        
        do {
         
            let folders = try fileManager.contentsOfDirectory(atPath: dirUrl!.path)

            
            
            
            for  folder in folders {
                
                
                let check = dirUrl?.appendingPathComponent(folder)
                
                if check?.hasDirectoryPath == true {
                    self.arrFolder.append(folder)
                    
                    
                }else {
                    
                    
                    print("sorey is not folder \(folder)")
                }
                self.tableViwe.reloadData()
                print(self.arrFolder)
            }
            
            
            
            
            
        }catch{
            print("something wrong")
            
            
        }

        
    }
    
   
    
    func addFolder(){
        
        do {
            let fileManger = FileManager.default
            let dirUrl = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
            
            let dir = dirUrl?.appendingPathComponent(textFiled.text!)
       
       
               try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
       
       
       
               }catch{
                   print("something wrong")
       
       
               }
        arrFolder.removeAll()
        relodFolder()
        tableViwe.reloadData()
               
    }
    
    func NewFile(){
        
        guard getName != "" else {return}
        guard textFiled.text!.isEmpty != true else{return}
        let fileManger = FileManager.default

        let dirUrl = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let newFile = dirUrl?.appendingPathComponent(getName).appendingPathComponent(textFiled.text! + ".txt")
        
        let contnet = MyViweTexte.text.data(using: .utf8)
        
        fileManger.createFile(atPath: newFile!.path, contents: contnet, attributes: [:])

    }
        
    @IBAction func switchMoveAction(_ sender: Any) {
        if switchMoveOutlet.isOn == true {
            switchMove = 1
        }else {
            switchMove = 0
        }
    }
    
    }
    


extension ViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFolder.count
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableTableViewCell
           
        cell.lable.text = arrFolder[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if switchMove == 0 {
            getName = arrFolder[indexPath.row]
        }else {
            nameSend = arrFolder[indexPath.row]
            self.performSegue(withIdentifier: "SegueOne", sender: self)
        }
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueOne" {
            let vc = segue.destination as! ViewController02
            vc.nameFolder = nameSend
        }
    }
}
