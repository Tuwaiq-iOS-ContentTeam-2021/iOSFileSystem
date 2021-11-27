//
//  Newview.swift
//  FileManager
//
//  Created by Wejdan Alkhaldi on 19/04/1443 AH.
//

import UIKit

class Newview: UIViewController {

    @IBOutlet weak var tablevcc: UITableView!
var dir:String = ""
var listFiles : [String] = []
    @IBOutlet weak var textArea: UITextView!
override func viewDidLoad() {
    super.viewDidLoad()
    print("")
    print(dir)
    getFile()

}


func getFile(){
    let file = FileManager.default
    let dirURL = file.urls(for: .documentDirectory, in: .userDomainMask).first
    let append = dirURL?.appendingPathComponent(dir)
    do {
        let files = try file.contentsOfDirectory(atPath: append!.path)

        listFiles = files
        self.tablevcc.reloadData()
    }catch{
        print("someThing")
    }
    
    
}


func readFile(dirFile:String){
    let file = FileManager.default
    let dirURL = file.urls(for: .documentDirectory, in: .userDomainMask).first
    let dirFile = dirURL?.appendingPathComponent(dir).appendingPathComponent(dirFile)
    do {
        let fileContent = try String(contentsOf: dirFile!, encoding: .utf8)
        textArea.text = fileContent
    }catch {
        print("some thing wrong")
    }
}
}



extension Newview: UITableViewDelegate,UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listFiles.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tablevcc.dequeueReusableCell(withIdentifier: "NewCell") as! TableCell2
    cell.labelcell.text = listFiles[indexPath.row]
    return cell
}



func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    readFile(dirFile: listFiles[indexPath.row])
    
}
}
