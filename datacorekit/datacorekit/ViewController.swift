//
//  ViewController.swift
//  datacorekit
//
//  Created by Areej on 19/04/1443 AH.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    
    var arrayProduct = [Product]()
    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableV: UITableView!
    
    @IBOutlet weak var cearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV.delegate = self
        tableV.dataSource = self
        cearchBar.delegate = self
        loadData()
    }
    
    
    func saveData(){
        do{
            try context.save()
        }catch{
            
            print (error)
        }
    }
    func loadData() {
        
        let request : NSFetchRequest<Product> = Product.fetchRequest()
        do{
            arrayProduct = try context.fetch( request)
        }catch {
            print(error)
        }
        tableV.reloadData()
    }
    
    @IBAction func addProduct(_ sender: Any) {
        
        var textField = UITextField()
        var alert = UIAlertController(title: "Alert", message: "Please add new product ", preferredStyle: .alert)
        //
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new product"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "OK", style: .default) { action in
            var newProduct = Product(context: self.context)
            newProduct.name = textField.text
            self.arrayProduct.append(newProduct)
            self.saveData()
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}





extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = arrayProduct[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(arrayProduct[indexPath.row])
            arrayProduct.remove(at: indexPath.row)
            self.saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var textfield = UITextField()
        let alert = UIAlertController (title: "update product", message: "add new product", preferredStyle: .alert)
        alert.addTextField {alertTextFeild in
            alertTextFeild.placeholder = "add new product"
            textfield = alertTextFeild
        }
        let action = UIAlertAction(title: "Update", style: .default) {action  in
            self.arrayProduct[indexPath.row].setValue(textfield.text, forKey: "name")
            self.saveData()
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
}


extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text?.count == 0{
            let alart = UIAlertController(title: "Empty", message: "please enter somthing", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alart.addAction(action)
            present(alart, animated: true, completion: nil)
            
        } else {
            print (searchBar.text!)
            let request = Product.fetchRequest() // to search in coreData
            request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending : true)]
            do{
                arrayProduct = try context.fetch( request)
            }catch{
                print(error)
            }
            tableV.reloadData()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar.text?.count == 0{
            loadData()
        }
    }
    
}
