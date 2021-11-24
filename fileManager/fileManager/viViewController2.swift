//
//  viViewController2.swift
//  fileManager
//
//  Created by TAGHREED on 19/04/1443 AH.
//

import UIKit

class viViewController2: UIViewController,UITableViewDelegate,UITableViewDataSource  {
  
    let fm = FileManager.default
    var dirUrl:URL?
    var nameFolder = ""
    var arrfiles:[String] = []
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print(nameFolder)
        tv.dataSource = self
        tv.delegate = self
         dirUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(dirUrl!)
        let dirofFile = dirUrl?.appendingPathComponent(nameFolder)
        do{
        let files = try fm.contentsOfDirectory(atPath: dirofFile!.path)//this is array
            self.arrfiles = files
        }catch{
            print("error")
        }
       
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrfiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell2
        cell.tvLable.text = arrfiles[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameLable.text = arrfiles [indexPath.row]
        readfile(namefile: arrfiles [indexPath.row])
    }
    func readfile(namefile:String){
        
        let dir = dirUrl?.appendingPathComponent(nameFolder).appendingPathComponent(namefile)
        do{
            let content = try String(contentsOf: dir!, encoding: .utf8)
            print(content)
            self.textArea.text = content
        }catch{
            print("")
        }
        

    }

}
