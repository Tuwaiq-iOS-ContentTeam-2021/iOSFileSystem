//
//  FileListViewController.swift
//  iOSFileSystem
//
//  Created by Ebtesam Alahmari on 24/11/2021.
//

import UIKit

class FileListViewController: UIViewController {
    
    var folderName = ""
    var selectedFile = ""
    var filesArray:[String] = []
    let fileManager = FileManager.default
    var dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = folderName + " Files"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dir = dirURL?.appendingPathComponent(folderName)
        do {
            let files = try fileManager.contentsOfDirectory(atPath: dir!.path)
            self.filesArray = files
        }catch {
            print("something error")
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFile" {
            let destination = segue.destination as! ContentViewController
            destination.fileName = selectedFile
            destination.folderName = folderName
        }
        if segue.identifier == "addSegue" {
            let destination = segue.destination as! AddFileViewController
            destination.folderName = folderName
        }
    }
}
    



//MARK: -UITableView
extension FileListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileCell") as! UITableViewCell
        cell.textLabel?.text = filesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFile = filesArray[indexPath.row]
        performSegue(withIdentifier: "showFile", sender: nil)
    }
    
}
