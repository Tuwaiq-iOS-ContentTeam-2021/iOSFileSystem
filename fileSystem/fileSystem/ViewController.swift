//
//  ViewController.swift
//  fileSystem
//
//  Created by Ahmad MacBook on 23/11/2021.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayFolder.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellkey", for: [indexPath.row]) as! classFotTV
        
        cell.label.text = arrayFolder[indexPath.row]
        
        reloadFolder()
        
        return cell
        
        
        
    }
    
    
    
    
    
    @IBOutlet weak var enterName: UITextField!
    
    @IBOutlet weak var fileName: UITextField!
    
   
    @IBOutlet weak var descr: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayFolder : [String] = []
    
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadFolder()
        overrideUserInterfaceStyle = .light
        
        
        //        //path
        //        let dirUrl = fileManager.urls(for: .documentDirectory , in: .userDomainMask).first
        //
        //        //create folder
        //        do {
        //            let dir = dirUrl?.appendingPathComponent("documentsByAhmad")
        //
        //             try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:] )
        //
        //        } catch {
        //
        //            print("Something error")
        //        }
        //
        //        // create file
        //        let text = "Hi Ahmad".data(using: .utf8) // utf
        //
        //        let dirFile = dirUrl?.appendingPathComponent("documentsByAhmad").appendingPathComponent("name.txt")
        //        fileManager.createFile(atPath: dirFile!.path , contents: text , attributes: [:])
        //
        //
        //        print(dirUrl!.path)
        
    }//end of the didLoad
    
    //file
    var selectName = ""

    
    @IBAction func createFile(_ sender: Any) {
       
        guard selectName != "" else {return}
        guard enterName.text?.isEmpty != true else {return}
        let fileManager = FileManager.default
        
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first

        let nameFile = dirURL?.appendingPathComponent(fileName.text! + ".txt")
        let content = descr.text?.data(using: .utf8)
        fileManager.createFile(atPath: nameFile!.path, contents: content, attributes: [:] )
//
        arrayFolder.removeAll()
        reloadFolder()
        tableView.reloadData()
        
    }
    
    
    //folder
    @IBAction func createButton(_ sender: Any) {
        
        let fileManger = FileManager.default
        
        let dirUrl = fileManager.urls(for: .documentDirectory , in: .userDomainMask).first
        
        //create folder
        
        do {
            let dir = dirUrl?.appendingPathComponent(enterName.text!)
            
            try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:] )
            
        } catch {
            
            print("Something error")
        }
        arrayFolder.removeAll()
        reloadFolder()
        tableView.reloadData()
        
    }
    
    func reloadFolder(){
        
        let fileManger = FileManager.default
        
        let dirUrl = fileManger.urls(for: .documentDirectory, in: .userDomainMask ).first
        
        do {
            let folders = try fileManger.contentsOfDirectory(atPath: dirUrl!.path)
            print("FOLDER=============" , folders)
            
            for folder in folders {
                
                let check = dirUrl?.appendingPathComponent(folder)
                
                if check?.hasDirectoryPath == true {
                    
                    self.arrayFolder.append(folder)
                    
                }else {
                    
                    print("This is not Folder")
                }
            }
        }
        catch  {
            print("Something error")
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectName = arrayFolder[indexPath.row]
        print(selectName)
    }
    
    
    
    
}//end of class

