
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var foldersTableView : UITableView!
    
    @IBOutlet weak var name : UITextField! {
        didSet {
            let placeholder = NSAttributedString(string: "Folder or File name",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            
            name.attributedPlaceholder = placeholder
        }
    }
    @IBOutlet weak var errorMsg: UILabel!
    
    @IBOutlet weak var switchh: UISwitch!
    
    @IBOutlet weak var fileContent : UITextView!
    
    var myFolders : [String] = []
    
    var selectedItem = ""
    
    var selectItemName = ""
    
    var moveSwitch = 0
        
    let manager = FileManager.default

    override func viewDidLoad() {
                super.viewDidLoad()
        reloadFolderData()
        foldersTableView.delegate = self
        foldersTableView.dataSource = self
        fileContent.layer.cornerRadius = 10
        foldersTableView.layer.cornerRadius = 10
        
    }
    
    @IBAction func createFolderButtonClicked(_ sender: Any) {
        ctreatingFolders(name: name.text!)
        myFolders.removeAll()
        reloadFolderData()
        foldersTableView.reloadData()
    }
    
    @IBAction func createFileButtonClicked(_ sender: Any) {
        
        guard selectedItem != "" else { return errorMsg.text = "you have to select a folder"  }
        guard name.text!.isEmpty != true else { return errorMsg.text = "File name can not be empty"}
        
        let manager = FileManager.default
        let folderUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = folderUrl?.appendingPathComponent(selectedItem).appendingPathComponent(name.text! + ".txt")
        
        let content = fileContent.text.data(using: .utf8)
        manager.createFile(atPath: fileName!.path, contents: content, attributes: [:])
        errorMsg.text = "File added to \(selectedItem) ✔️"
        errorMsg.textColor = .white
        name.text = " "
        fileContent.text = " "
        
    }
    
    func ctreatingFolders (name : String){
        
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let folderUrl = url.appendingPathComponent(name)
        print(url.path)
        do {
            try? manager.createDirectory(at: folderUrl,
                                         withIntermediateDirectories: true,
                                         attributes: [:])
            myFolders.append(name)
        }
        
        catch {
            print(error)
        }
    }
    
//    func ctreatingFiles (name : String){
//        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
//
//        let folderUrl = url.appendingPathComponent(name)
//
//        do {
//            try? manager.createDirectory(at: folderUrl,
//                                         withIntermediateDirectories: true,
//                                         attributes: [:])
//            myFolders.append(name)
//        }
//
//        catch {
//            print(error)
//        }
//    }
    @IBAction func switched(_ sender: Any) {
        if switchh.isOn == true {
            moveSwitch = 1
        }
        else {
            moveSwitch = 0
        }
    }
}


extension ViewController : UITableViewDelegate , UITableViewDataSource{
    
    func reloadFolderData(){
        let manager = FileManager.default
        let folderUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        do {
            let folders = try manager.contentsOfDirectory(atPath: folderUrl!.path)
            print(folders)
            
            for folder in folders{
                let checkFolder = folderUrl?.appendingPathComponent(folder)
                if checkFolder?.hasDirectoryPath == true{
                    myFolders.append(folder)
                }else {
                    print("\(folder) is not a folder")
                }
            }
        }
        catch{
            print("smothing went wrong")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        cell.folderName.text = myFolders[indexPath.row]
        
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if moveSwitch == 0 {
            selectedItem = myFolders[indexPath.row]
        }
        else {
            selectItemName = myFolders[indexPath.row]
            self.performSegue(withIdentifier: "segue", sender:self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let nextVC = segue.destination as! FilesVC
            nextVC.selectedFolderName = selectItemName
        }
    }
}

