
import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var tableFiles: UITableView!
    @IBOutlet weak var textArea: UITextView!
    
    var dir:String = ""
    var listFiles : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--------------------")
        print(dir)
        getFile()
    }
    
    func getFile(){
        let fileManger = FileManager.default
        let dirURL = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        let append = dirURL?.appendingPathComponent(dir)
        do {
            let files = try fileManger.contentsOfDirectory(atPath: append!.path)

            listFiles = files
            self.tableFiles.reloadData()
        }catch{
            print("error")
        }
    }

    func readFile(dirFile:String){
        let fileManager = FileManager.default
        let dirURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let dirFile = dirURL?.appendingPathComponent(dir).appendingPathComponent(dirFile)
        do {
            let fileContent = try String(contentsOf: dirFile!, encoding: .utf8)
            textArea.text = fileContent
        } catch {
            print("error")
        }
    }
}

extension ViewController2: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableFiles.dequeueReusableCell(withIdentifier: "CellName2") as! ClassCell2
        cell.fileName.text = listFiles[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        readFile(dirFile: listFiles[indexPath.row])
    }
}
