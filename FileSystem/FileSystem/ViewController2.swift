//
//  ViewController2.swift
//  FileSystem
//
//  Created by nouf on 24/11/2021.
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let fileManager = FileManager.default
        var dirUrl : URL?
    
    var nameFile = ""
    var arrayFiles = [String]()
    
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var tableViewFile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewFile.dataSource = self
        tableViewFile.delegate = self
        
        dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(dirUrl!)
        
        let dir = dirUrl?.appendingPathComponent(nameFile)
        do {
        let files = try fileManager.contentsOfDirectory(atPath: dir!.path)
        self.arrayFiles = files
            print(files)
        } catch{
            print("Error")
        }
        print(dirUrl!)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFile.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath) as! TableViewCell2
        cell.nameFile.text = arrayFiles[indexPath.row]
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        labelName.text = arrayFiles[indexPath.row]
        readFile(nameFiles: arrayFiles[indexPath.row])
    }
    
    func readFile(nameFiles:String){
        let dir = dirUrl?.appendingPathComponent(nameFile).appendingPathComponent(nameFiles)
        do {
            let content = try String(contentsOf: dir!, encoding: .utf8)
            print(content)
            self.textArea.text = content
        } catch {
            
        }
    }
    
    
}

