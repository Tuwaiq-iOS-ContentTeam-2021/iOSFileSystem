//
//  ViewController.swift
//  firstApp
//
//  Created by loujain on 23/11/2021.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var textC: UITextView!
    
    @IBOutlet weak var TextFiled: UITextField!
    
    @IBOutlet weak var TexFiled2: UITextField!
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var switchMoveOutlet: UISwitch!
    
    var switchMove = 0
    
    var arrayF:[String] = []
    
    var selectName:String = ""
    var nameSend:String = ""
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        reloadFolder()
        TableView.delegate = self
        TableView.dataSource = self
    }
    
    @IBAction func createFolder(_ sender: Any) {
        super.viewDidLoad()
        let dirUrl = fileManager.urls(for:.documentDirectory, in:.userDomainMask).first
        print(dirUrl?.path)
//create folder
        do{
        let dir = dirUrl?.appendingPathComponent(TextFiled.text ?? "defult value")
        try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
        }catch{
            print("Somrthing wrong")
        }
        
        arrayF.removeAll()
        reloadFolder()
        TableView.reloadData()
    }
    
    @IBAction func createFile(_ sender: Any) {
        guard selectName != "" else {return}
        guard TexFiled2.text!.isEmpty != true else {return}

//create file
        //Api for FileManager
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//        let nameFile = dirURL?.appendingPathComponent(TexFiled2.text! + ".txt")
        let nameFile = dirURL?.appendingPathComponent(selectName).appendingPathComponent(TexFiled2.text! + ".txt")
        let content = textC.text.data(using: .utf8)
        fileManager.createFile(atPath: nameFile!.path, contents: content, attributes: [:])
    }
    
    func reloadFolder(){
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do{
          let folders = try fileManager.contentsOfDirectory(atPath: dirURL!.path)
          print(folders)
          for folder in folders {
              
// print folders
            let checkFlolder = dirURL?.appendingPathComponent(folder)
            if checkFlolder?.hasDirectoryPath == true {
                
                self.arrayF.append(folder)
            }else{
                print(" Not find folder \(folder)")
            }
          }
        }
        catch{
          print("Error")
      }
    }
    
    @IBAction func switchMove(_ sender: Any) {
        if switchMoveOutlet.isOn == true{
            switchMove = 1
        }else{
            switchMove = 0

        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayF.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.celLabel.text = arrayF[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if switchMove == 0 {
            selectName = arrayF[indexPath.row]
//        }else{
            //print("*****\(arrayF)")
            nameSend = arrayF[indexPath.row]
          

            self.performSegue(withIdentifier: "move", sender: self)
//        }
        
    }
    
        override func prepare (for segue:UIStoryboardSegue, sender:Any?){
            if segue.identifier == "move" {
                
                let vc = segue.destination as! ViewController2
                print("my text \(nameSend)")

                vc.nameFolder = nameSend
                print("vc.nameFolder \(vc.nameFolder )")
                print("vc.nameFolder \(nameSend)")
        }
    }
}
