//
//  ViewController.swift
//  fileManage
//
//  Created by Nora on 18/04/1443 AH.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let fileManager = FileManager.default
        
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    
    var arrFolder: [String] = []
    
    var selectedFld = ""
    
    @IBAction func fileCreating(_ sender: Any) {
        
        guard selectedFld != "" else { return }
        guard textName.text!.isEmpty != true else { return }
        
        let manager = FileManager.default
        let folderUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = folderUrl?.appendingPathComponent(selectedFld).appendingPathComponent(textName.text! + ".txt")
        let content = txtArea.text?.data(using: .utf8)
        manager.createFile(atPath: fileName!.path, contents: content, attributes: [:])
    }
    
    @IBAction func folderCreating(_ sender: Any) {
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let fileManger = FileManager.default
            let dir = dirUrl?.appendingPathComponent(textName.text ?? "button#@%$")
            try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
        } catch {
            print("SOMETHING IS WRONG")
        }
        arrFolder.removeAll()
        reload()
        tableView.reloadData()
        print(dirUrl?.path)
    }
    func reload () {
        let fileManager = FileManager.default
        let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folders = try fileManager.contentsOfDirectory(atPath: dirUrl!.path)
            print(folders)
            
            for f in folders {
                let test = dirUrl?.appendingPathComponent(f)
                if test?.hasDirectoryPath == true {
//                    print("there\(f)")
                    self.arrFolder.append(f)
                }else{
                    print("not avaliable")
                }
            }
        } catch {
            print("WHATEVER")
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        reload()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFolder.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.Celli.text = arrFolder[indexPath.row]
        return cell
    }
    
}
