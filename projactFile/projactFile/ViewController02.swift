//
//  ViewController02.swift
//  projactFile
//
//  Created by mac on 24/11/2021.
//

import UIKit

class ViewController02: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    

    var arrFiles: [String] = []
    
    let dirUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    let fileManager = FileManager.default
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var lableName: UILabel!
    var nameFolder = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        let dir = dirUrl.appendingPathComponent(nameFolder)
        do {
            let files = try fileManager.contentsOfDirectory(atPath: dir.path)
            self.arrFiles = files
        }catch {
            print("spmthing went wrong")
        }
        print(dirUrl)
        // Do any additional setup after loading the view.
    }
    func readFile(nameFile: String) {
        print(nameFolder)
        
        let dir = self.dirUrl.appendingPathComponent(nameFolder).appendingPathComponent(nameFile)
        do {
            let content = try String(contentsOf: dir, encoding: .utf8)
            
            print(content)
            self.textView.text = content
        }catch{
            print("somthing went wrong")
        }
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
extension ViewController02 {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFiles.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellClassTwo") as! cellClassTwoTableViewCell
        cell.lableForCell.text = arrFiles[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lableName.text = arrFiles[indexPath.row]
//        nameFolder = arrFiles[indexPath.row]
        readFile(nameFile: arrFiles[indexPath.row])
    }
}
