//
//  ViewController2.swift
//  Files
//
//  Created by Sahab Alharbi on 19/04/1443 AH.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TVVC2.dequeueReusableCell(withIdentifier: "cell2") as! FolderTableViewCell2
        cell.fileName.text = filesArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        floderLabel.text = filesArr[indexPath.row]
        readFile(fileName: filesArr[indexPath.row] )
    }
    var fileManager = FileManager.default
    var filesArr: [String] = []
    var nameFolder = ""

    @IBOutlet weak var TVVC2: UITableView!
    @IBOutlet weak var folderTextView: UITextView!
    @IBOutlet weak var floderLabel: UILabel!
    
    var uRLdir:URL?
    
    func readFile(fileName:String){
        let fileDir = uRLdir?.appendingPathComponent(nameFolder).appendingPathComponent(fileName)
        do{
            let content = try String(contentsOf: fileDir!, encoding: .utf8)
            print(content)
            self.folderTextView.text = content
        }catch {
            print("wrong")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TVVC2.delegate = self
        TVVC2.dataSource = self
        uRLdir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileDir = uRLdir?.appendingPathComponent(nameFolder)
        do {
            let files = try fileManager.contentsOfDirectory(atPath: fileDir!.path)
            self.filesArr = files
        }catch{
            print(" error ")
        }
        
        print(uRLdir!)
        
       

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
