
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var foldersTableView : UITableView!
    @IBOutlet weak var fileFolderName : UITextField! {
        didSet {
            let placeholder = NSAttributedString(string: "Folder or File name",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            
            fileFolderName.attributedPlaceholder = placeholder
        }
    }
    
    
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
        ctreatingFolders(name: fileFolderName.text!)
        myFolders.removeAll()
        reloadFolderData()
        foldersTableView.reloadData()
    }
    
    @IBAction func createFileButtonClicked(_ sender: Any) {
        ctreatingFiles(name: fileFolderName.text!)
    }
    
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let folderCell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath) as! FolderCell
        
        folderCell.folderName.text = myFolders[indexPath.row]
        
        folderCell.layer.cornerRadius = 10
        
        return folderCell
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
            let filesVC = segue.destination as! FilesVC
            filesVC.selectedFolderName = selectItemName
        }
    }
}

extension ViewController {
    
    func ctreatingFolders (name : String){
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let folderUrl = url.appendingPathComponent(name)
        
        do {
            try manager.createDirectory(at: folderUrl,
                                         withIntermediateDirectories: true,
                                         attributes: [:])
            myFolders.append(name)
        }
        catch {
            print(error)
        }
    }
    
    func ctreatingFiles (name : String){
        
        guard selectedItem != "" else { return
            popAlert(title: "Friendly Note", message: "Please select a folder for your file." )}
        guard name.isEmpty != true else { return
            popAlert(title: "Friendly Note", message: "Please enter a file name :3")}

        let manager = FileManager.default
        let folderUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = folderUrl?.appendingPathComponent(selectedItem).appendingPathComponent(name + ".txt")
        
        let content = fileContent.text.data(using: .utf8)
        manager.createFile(atPath: fileName!.path, contents: content, attributes: [:])
        popAlert(title: "Done", message: "File added to \(selectedItem)")
        fileFolderName.text = ""
        fileContent.text = ""
    }
    
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
            print("Directory not found. Error : \(error.localizedDescription)")
        }
    }
    
    func popAlert(title : String, message : String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil ))
        self.present(alertController, animated: true) {
            
        }
    }
}
