

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var textDetails: UITextView!
    @IBOutlet weak var textFiled1: UITextField!
    @IBOutlet weak var texFiled2: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var arrayF:[String] = []
    var selectName:String = ""
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        reloadFolder()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func createFolder(_ sender: Any) {
        super.viewDidLoad()
        let direcUrl = fileManager.urls(for:.documentDirectory, in:.userDomainMask).first
        print(direcUrl?.path)

        do{
        let dir = direcUrl?.appendingPathComponent(textFiled1.text ?? "defult value")
        try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
        }
        catch{
            print("Error")
        }
        arrayF.removeAll()
        reloadFolder()
        tableView.reloadData()
    }
    
    @IBAction func createFile(_ sender: Any) {
        guard selectName != "" else {return}
        guard texFiled2.text!.isEmpty != true else {return}

        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let nameFile = dirURL?.appendingPathComponent(selectName).appendingPathComponent(texFiled2.text! + ".txt")
        let content = textDetails.text.data(using: .utf8)
        fileManager.createFile(atPath: nameFile!.path, contents: content, attributes: [:])
    }
    
    func reloadFolder(){
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do{ let folders = try fileManager.contentsOfDirectory(atPath: dirURL!.path)
          print(folders)
          for folder in folders {
              
            let checkFlolder = dirURL?.appendingPathComponent(folder)
            if checkFlolder?.hasDirectoryPath == true {
                self.arrayF.append(folder)
            }else{
                print(" Can't find folder \(folder)")
            }
          }
        }
        catch{
          print("Error")
        }
      }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayF.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        cell.celLabel.text = arrayF[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectName = arrayF[indexPath.row]
    }
}
