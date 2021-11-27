//
//  ViewController.swift
//  fahadPro
//
//  Created by Qahtani's MacBook Pro on 11/24/21.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var LabelName: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let failManeger = FileManager.default
    var dirURL: URL?
    var urlForDataBase:URL?
    
    
    var arrPath = [Files]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPath.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelViewFile.dequeueReusableCell(withIdentifier: "cell-id") as! TableViewCell
        cell.LabelName.text = arrPath[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(dirURL!.path)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(arrPath[indexPath.row])
            arrPath.remove(at: indexPath.row)
            self.tabelViewFile.reloadData()
            save()
        }
    }
    @IBOutlet weak var failname: UITextField!
    @IBOutlet weak var tabelViewFile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabelViewFile.delegate = self
        tabelViewFile.dataSource = self
        
         dirURL = failManeger.urls(for: .documentDirectory, in: .userDomainMask).first
        
        reload()
    }


    
    

    @IBAction func creataction(_ sender: Any) {
        
        let dir = dirURL!.appendingPathComponent(failname.text! + ".txt")
        
        let content = "here is the text".data(using: .utf8)
        
        failManeger.createFile(atPath: dir.path, contents: content, attributes: [:])
        AddItem(url: "\(dir.path)")
        self.reload()
        self.tabelViewFile.reloadData()
        
    }
    
    @IBAction func folderCreate(_ sender: Any) {
        let folder = dirURL?.appendingPathComponent(failname.text!)
        do {
        try failManeger.createDirectory(at: folder!, withIntermediateDirectories: true, attributes: [:])
            AddItem(url: "\(folder!.path)")
        }
       
        catch {
            
            print(error.localizedDescription)
        }
       reload()
        tabelViewFile.reloadData()
        print(dirURL?.path)
        print("----")
        print(folder)
    }
    

      func save(){
          do{
              try context.save()
          }catch{
              print(error)
          }
}
    
    
    func AddItem(url:String) {
        let dataBase = Files(context:context)
        dataBase.puth = "\(url)"
        dataBase.name = failname.text!
        self.save()
    }
    
    func reload(){
        do{
            arrPath = try context.fetch(Files.fetchRequest())
            
        }catch{
            print(error)
        }
    }
    
    
    

}
