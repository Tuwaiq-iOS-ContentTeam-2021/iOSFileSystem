//
//  ViewController2.swift
//  firstApp
//
//  Created by loujain on 24/11/2021.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var TextArea: UITextView!
    
    @IBOutlet weak var TableView2: UITableView!
    let fileManger = FileManager.default
    var dirURL:URL? = nil
    var nameFolder:String = ""
    var arrFiles:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(nameFolder)
        label3.text = nameFolder
        TableView2.delegate = self
        TableView2.dataSource = self
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dir = dirURL.appendingPathComponent(nameFolder)
        do{
            let files = try fileManger.contentsOfDirectory(atPath: dir.path)
            self.arrFiles = files
        print(files)
        }catch{
            print("some thing wrong")
         }
        print(dirURL)

       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! TableViewCell2
        cell.labelTableView.text = arrFiles[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        label3.text = arrFiles[indexPath.row]
       readfile(nameFile: arrFiles[indexPath.row])
        
    }
//    func readfile (){
//        let dir = dirURL?.appendingPathComponent(nameFolder).appendingPathComponent("test")
//        let content = String(contentsOf: dir)
//    }
    func readfile(nameFile:String){
         let dir = dirURL!.appendingPathComponent(nameFolder).appendingPathComponent(nameFile) 
        do{
            let content = try String(contentsOf: dir , encoding: .utf8)
            print(content)
            self.TextArea.text = content
        }catch{
            print("some thing")
        }
    }

}
