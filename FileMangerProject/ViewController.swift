

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDetails: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mySwitch: UISwitch!

    var arrFolder:[String] = []
    var folderSelect = ""
    var folderAlowSelect = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folderAlowSelect = "NotAllow"
        mySwitch.isOn = false
        loadData()
    }
    
    @IBAction func CreateDirAction(_ sender: Any) {
        creatDir(dieName: textName.text!)
    }
    
    @IBAction func CreateFileAction(_ sender: Any) {
        createFile(dirName: folderSelect, fileName: textName.text!)
    }
    
    func loadData() {
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        do {
            let folders = try fileManger.contentsOfDirectory(atPath: dirURL!.path)
            print(folders)
            
            for folder in folders {
                if dirURL?.appendingPathComponent(folder).hasDirectoryPath == true {
                    self.arrFolder.append(folder)
                    print(folder)
                }
            }
            self.tableView.reloadData()
        }catch let error {
            print("Error: \(error)")
        }
    }
    
    func creatDir(dieName:String){
        guard dieName.isEmpty == false else {return}
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
          print(dirURL?.path)

        let url = dirURL!.appendingPathComponent(dieName)
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            arrFolder.removeAll()
            loadData()
        }catch {
            print("Error")
        }
    }
    
    func createFile(dirName:String,fileName:String){
        guard folderSelect != "" else {return}
        guard fileName.isEmpty != true else {return}
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        let file = dirURL?.appendingPathComponent(dirName).appendingPathComponent(fileName + ".txt")
        let data = textDetails.text.data(using: .utf8)
        fileManger.createFile(atPath: file!.path, contents: data, attributes: [:])
    }
    
    var sel = 0
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "NextVC" {
                let vc = segue.destination as! ViewController2
                vc.dir = folderSelect
        }
    }
    @IBAction func switchSelect(_ sender: Any) {
        if mySwitch.isOn {
            folderAlowSelect = "AllowSelect"
        }else{
            folderAlowSelect = "NotAllow"
        }
    }
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellName") as! ClassCell
        cell.LabelNameDir.text = arrFolder[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if folderAlowSelect == "AllowSelect" {
            folderSelect = arrFolder[indexPath.row]
        }else{
            folderSelect = arrFolder[indexPath.row]
            self.performSegue(withIdentifier: "NextVC", sender: self)
        }
    }
    
}
