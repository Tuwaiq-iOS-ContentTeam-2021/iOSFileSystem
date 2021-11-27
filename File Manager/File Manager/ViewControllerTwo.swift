//
//  ViewControllerTwo.swift
//  File Manager
//
//  Created by Najla Talal on 11/24/21.
//

import UIKit

class ViewControllerTwo: UIViewController,UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewForFile.dequeueReusableCell(withIdentifier: "MyCell")as! CellClassTwoTableViewCell
        
        cell.label2.text = arrFiles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lableName.text = arrFiles[indexPath.row]
        readfile(nameFile: arrFiles[indexPath.row])
        
    }


var NameFolder = ""
let fileManager = FileManager.default
var arrFiles:[String] = []
var dirURL:URL?
@IBOutlet weak var textArea: UITextView!
@IBOutlet weak var TableViewForFile: UITableView!
@IBOutlet weak var lableName: UILabel!

override func viewDidLoad() {
    super.viewDidLoad()
    TableViewForFile.delegate = self
    TableViewForFile.dataSource = self
    print(NameFolder)
    dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let dir = dirURL?.appendingPathComponent(NameFolder)
    do {
        let files = try fileManager.contentsOfDirectory(atPath: dir!.path)
        self.arrFiles = files
    } catch {
        print("Something Wrong")
    }
    //        print(dirURL!)
    
}

func readfile(nameFile: String){
    let dir = dirURL?.appendingPathComponent(NameFolder).appendingPathComponent(nameFile)
    do {
        let content =  try String(contentsOf: dir!, encoding: .utf8)
        print(content)
        self.textArea.text = content
    }catch {
        print("Something")
    }
}


}

