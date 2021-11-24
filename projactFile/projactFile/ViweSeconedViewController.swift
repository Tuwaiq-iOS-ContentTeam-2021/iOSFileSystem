//
//  ViweSeconedViewController.swift
//  projactFile
//
//  Created by Abrahim MOHAMMED on 24/11/2021.
//

import UIKit

class ViweSeconedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableViwe.dequeueReusableCell(withIdentifier: "TableViewCellTOW") as!TableViewCellTOW
        
        cell.lableee.text = arrFile[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lable.text = arrFile[indexPath.row]
        redFile(fileName: arrFile[indexPath.row])
    }
    
    var nameFolder = ""
    var arrFile :[String]=[]
    
    @IBOutlet weak var lable: UILabel!
    
    @IBOutlet weak var textArea:
    UITextView!
    
    @IBOutlet weak var MyTableViwe: UITableView!
    var fileManger = FileManager.default
    var dirURL:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
//print(nameFolder)
        MyTableViwe.dataSource = self
        MyTableViwe.delegate = self
        
        dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        
       let dir =  dirURL?.appendingPathComponent(nameFolder)
        
        do {
            
            let files = try fileManger.contentsOfDirectory(atPath: dir!.path)

            self.arrFile = files
            
            
        }catch {
            
            print("invled")
            
            
        }


    }
    
    func redFile(fileName:String){
        
        let dir = dirURL?.appendingPathComponent(nameFolder).appendingPathComponent(fileName)
        
        do{
            
            let countent = try String(contentsOf: dir!,encoding: .utf8)
            print(countent)
            
            self.textArea.text = countent
            
            
        }catch{
            print("some thing")
            
            
            
        }
        
        
    }

}
