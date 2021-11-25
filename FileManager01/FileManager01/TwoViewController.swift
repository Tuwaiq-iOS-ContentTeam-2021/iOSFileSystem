//
//  TwoViewController.swift
//  FileManager01
//
//  Created by Taraf Bin suhaim on 19/04/1443 AH.
//

import UIKit

class TwoViewConrtoller : UIViewController {
    
    var arrayFiles = [String]()
    var name = ""
    let fileManager = FileManager.default
    var dirUrl : URL?
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var tabelViewFile: UITableView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        tabelViewFile.dataSource = self
        tabelViewFile.delegate = self
        print(name)
        dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(dirUrl!)
        let dir = dirUrl?.appendingPathComponent(name)
        do {
        let files = try fileManager.contentsOfDirectory(atPath: dir!.path)
        self.arrayFiles = files
        } catch{
            print("Wrong")
        }
        print(dirUrl!)
    }
    
    func readFile(nameFile:String){
        let dir = dirUrl?.appendingPathComponent(name).appendingPathComponent(nameFile)
        do {
            let content = try String(contentsOf: dir!, encoding: .utf8)
            print(content)
            self.textArea.text = content
        } catch {}
    }
}


extension TwoViewConrtoller : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelViewFile.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as! TwoTableViewCell
        cell.labelN.text = arrayFiles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        labelName.text = arrayFiles[indexPath.row]
        readFile(nameFile: arrayFiles[indexPath.row])
    }
}

