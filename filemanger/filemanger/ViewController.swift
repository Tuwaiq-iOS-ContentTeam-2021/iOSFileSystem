//
//  ViewController.swift
//  filemanger
//
//  Created by esho on 18/04/1443 AH.
//

import UIKit

class ViewController: UIViewController ,  UITableViewDataSource , UITableViewDelegate {

    
    @IBOutlet weak var tablefolder: UITableView!
    
    @IBOutlet weak var lablecell: UILabel!
    @IBOutlet weak var imgee: UIImageView!
    
    @IBOutlet weak var enterfilename: UITextField!
    
    @IBOutlet weak var textfile: UITextView!
    @IBOutlet weak var segmentswitch: UISegmentedControl!
    
    
    var arrfolder : [String] = []
    var selectName:String = ""
    let fileManager = FileManager.default
    var folderSelect = ""
    var folderAlow = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        relodFolder()
        tablefolder.delegate = self
        tablefolder.dataSource = self
        segmentswitch.selectedSegmentIndex = 0
    }
   

    @IBAction func creatNewfolder(_ sender: Any) {
        let fileManger = FileManager.default
        let dirUrl = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let addDir = dirUrl?.appendingPathComponent(enterfilename.text!)
        do {
            
            try fileManger.createDirectory(at: addDir! , withIntermediateDirectories: true , attributes: [:])
        } catch {
            print("something wrong")
        }
        arrfolder.removeAll()
        relodFolder()
        tablefolder.reloadData()
        folderAlow = "just file"
 
        
        
        
    }
    
    @IBAction func createfile(_ sender: Any) {
        
        createFile(dirName: folderSelect, fileName: enterfilename.text!)
    }
    
    func relodFolder() {
        let filemanger = FileManager.default
        
        let dirUrl = filemanger.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folder = try filemanger.contentsOfDirectory(atPath: dirUrl!.path)
            print(folder)
            
            for i in folder {
                let test = dirUrl?.appendingPathComponent(i)
                if test?.hasDirectoryPath == true {
//                    print("this is folder name \(i)")
                    self.arrfolder.append(i)
                } else {
                    print("sorry not folder \(i)")
            }
            }
        }catch {
            print("error")
        
    }
    }
    func createFile(dirName:String,fileName:String){
        guard folderSelect != "" else {return}
        guard fileName.isEmpty != true else {return}
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        let file = dirURL?.appendingPathComponent(dirName).appendingPathComponent(fileName + ".txt")
        let data = textfile.text.data(using: .utf8)
        fileManger.createFile(atPath: file!.path, contents: data, attributes: [:])
    }
  
    
    @IBAction func segaction(_ sender: Any) {
        if segmentswitch.selectedSegmentIndex == 0 {
            folderAlow = "just folder"
        }else{
            folderAlow = "just file"
        }
    }
    
}
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrfolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablefolder.dequeueReusableCell(withIdentifier: "mycell")as! CellV
        cell.lablecell.text = arrfolder[indexPath.row]
        
        return cell
        
    }
    

    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrfolder.remove(at: indexPath.row)
            tablefolder.reloadData()


        }
    }
}

