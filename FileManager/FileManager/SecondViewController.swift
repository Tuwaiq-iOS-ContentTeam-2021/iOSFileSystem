//
//  SecondViewController.swift
//  FileManager
//
//  Created by Taraf Bin suhaim on 22/04/1443 AH.
//

import UIKit

class SecondViewController: UIViewController {

    var name = ""
    var arrayFiles = [String]()
    
    @IBOutlet weak var tabelViewFile: UITableView!
    @IBOutlet weak var tArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelViewFile.dataSource = self
        tabelViewFile.delegate = self
        print(name)
        getFile()
    }
    
    func getFile(){
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        let append = dirURL?.appendingPathComponent(name)
        do {
            let files = try fileManger.contentsOfDirectory(atPath: append!.path)
            arrayFiles = files
            self.tabelViewFile.reloadData()
        }catch{}
    }

    func readFile(dirFile:String){
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let dirFile = dirURL?.appendingPathComponent(name).appendingPathComponent(dirFile)
        do {
            let fileContent = try String(contentsOf: dirFile!, encoding: .utf8)
            tArea.text = fileContent
        }catch {
            print("Eroor")
        }
    }
}



extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tabelViewFile.dequeueReusableCell(withIdentifier: "cell2") as! SecondTableViewCell
        cell.fileName.text = arrayFiles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        readFile(dirFile: arrayFiles[indexPath.row])
        
    }
}
