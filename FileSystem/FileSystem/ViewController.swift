//
//  ViewController.swift

//
//  Created by nouf on 23/11/2021.
//

import UIKit


class ViewController: UIViewController {
    
    
    let fileManager = FileManager.default // API
   
    var folderArray = [Any]()
    var selectName = ""
    var swithMove = 0
    
    @IBOutlet weak var nameFolder: UITextField!
    @IBOutlet weak var nameFile: UITextField!
    @IBOutlet weak var tabelViwe: UITableView!
    @IBOutlet weak var textViwe: UITextView!
    @IBOutlet weak var swithMovOutlet: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelViwe.delegate = self
        tabelViwe.dataSource = self
        relodFodel()
    }
    
    
    @IBAction func createFolderAction(_ sender: Any) {
        
        let dirUel = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first // path
        do{
         
            let newFolder = dirUel?.appendingPathComponent(nameFolder.text!)
            try fileManager.createDirectory(at: newFolder!, withIntermediateDirectories: true, attributes:[:])
        } catch {
            print("Error")
        }
        
        folderArray.removeAll()
        relodFodel()
        tabelViwe.reloadData()
    }
    
    @IBAction func createFileAction(_ sender: Any) {
        guard selectName != "" else {return}
        guard nameFile.text!.isEmpty != true else {return}
        let dirUel = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first // path
        
        let newFila = dirUel?.appendingPathComponent(selectName).appendingPathComponent(nameFile.text! + ".txt")
        let text = textViwe.text.data(using: .utf8)
        fileManager.createFile(atPath: newFila!.path , contents: text, attributes: [:])
    }
    
    
    @IBAction func swithMovAction(_ sender: Any) {
        
        if swithMovOutlet.isOn == true {
            swithMove = 1
        } else {
            swithMove = 0
        }
        
        
    }
    
    
    func  relodFodel(){
        
        let dirUel = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do{
            let folder = try fileManager.contentsOfDirectory(atPath: dirUel!.path)
     
            for folder in folder {
                let checkFolder = dirUel?.appendingPathComponent(folder)
                if checkFolder?.hasDirectoryPath == true {
                    self.folderArray.append(folder)
                } else {
                    print("Sorry not folder\(folder)")
                }
            }
        } catch {
            print("Error")
        }
    }
       

    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        cell.nameFolder.text = folderArray[indexPath.row] as? String
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if swithMove == 0 {
            selectName = folderArray[indexPath.row] as! String
        
        } else {
            selectName = folderArray[indexPath.row] as! String
            self.performSegue(withIdentifier: "moveOtherPage", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveOtherPage" {
            let vc = segue.destination as! ViewController2
            vc.nameFile = selectName
            
        }
    }
}

