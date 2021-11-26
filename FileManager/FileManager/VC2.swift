//
//  VC2.swift
//  FileManager
//
//  Created by Areej Mohammad on 19/04/1443 AH.
//

import UIKit

class VC2: UIViewController , UITableViewDelegate , UITableViewDataSource{
    var arrFiles : [String] = []
    var nameFolder = ""
    let filemanger = FileManager.default
    @IBOutlet weak var labelview: UILabel!
    @IBOutlet weak var textview1: UITextView!
    @IBOutlet weak var tableview2: UITableView!
    
    var dirURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview2.delegate = self
        tableview2.dataSource = self
        print(nameFolder)
        dirURL = filemanger.urls(for: .documentDirectory, in: .userDomainMask).first
        let dir = dirURL?.appendingPathComponent(nameFolder)
        do {
            let files = try filemanger.contentsOfDirectory(atPath: dir!.path)
            self.arrFiles = files
        }catch{
            print("some thing wrong")
        }
    }
    func readfile(nameFile : String){
        let dir = dirURL?.appendingPathComponent(nameFolder).appendingPathComponent(nameFile)
        do {
            let content = try String(contentsOf: dir!, encoding: .utf8)
            print(content)
            self.textview1.text = content
        }catch{
            print("Some thing")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview2.dequeueReusableCell(withIdentifier: "CellName") as! callClass2
        cell.label1.text = arrFiles[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        labelview.text = arrFiles[indexPath.row]
        readfile(nameFile: arrFiles[indexPath.row])
    }
}
