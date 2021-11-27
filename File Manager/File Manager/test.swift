////
////  test.swift
////  File Manager
////
////  Created by Najla Talal on 11/24/21.
////
//
//
//import UIKit
//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//  let fileManager = FileManager.default
//  var selectName = “”
//  var swithMove = 0
//  var Arrayfolders : [String] = []
//  @IBOutlet weak var EnterText: UITextField!
//  @IBOutlet weak var tabelView: UITableView!
//  @IBOutlet weak var textView: UITextView!
//  @IBOutlet weak var switchMoveOutlet: UISwitch!
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    tabelView.delegate = self
//    tabelView.dataSource = self
//    relodFolder()
//  }
//  @IBAction func createFile(_ sender: Any) {
//    guard selectName != “” else {return}
//    guard textView.text!.isEmpty != true else {return}
//    let fileManager = FileManager.default
//    let dirUre = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//    let file = dirUre?.appendingPathComponent(selectName)
//      .appendingPathComponent(EnterText.text! + “.txt”)
//    // التشفير حق الملف
//    let contest = textView.text.data(using: .utf8)
//    fileManager.createFile(atPath: file!.path, contents: contest, attributes: [:])
//  }
//  @IBAction func createFolder(_ sender: Any) {
//    // variable to deal with proprity of interface for file manager + proparity api
//    let fileManager = FileManager.default
//    // this is the path of var require two thing 1. place 2.domain
//    let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//    // to create folder
//    let newDir = dirUrl?.appendingPathComponent(EnterText.text!)
//    do {
//      // name of folder ,
//      try fileManager.createDirectory(at: newDir!, withIntermediateDirectories: true, attributes: [:])
//    } catch{}
//    print(dirUrl!.path)
//    Arrayfolders.removeAll()
//    relodFolder()
//    tabelView.reloadData()
//  }
//  @IBAction func switchMove(_ sender: Any) {
//    if switchMoveOutlet.isOn == true {
//      swithMove = 1
//    } else {
//      swithMove = 0
//    }
//  }
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return Arrayfolders.count
//  }
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: “cell”, for: indexPath) as! TableViewCell
//    cell.label.text = Arrayfolders[indexPath.row]
//    return cell
//  }
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    if swithMove == 0 {
//      selectName = Arrayfolders[indexPath.row]
//    } else {
//      self.performSegue(withIdentifier: “moveOther”, sender: self)
//    }
//  }
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == “moveOther” {
//      let vc = segue.destination as! secViewController
//    }
//  }
//  func relodFolder(){
//    let fileManager = FileManager.default
//    let dirUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//    do {
//      // path and return all folders
//      // is the path contain folders?
//      let folders = try fileManager.contentsOfDirectory(atPath: dirUrl!.path)
//      print(folders)
//       //dirUrl is path
//      // to check is a folder or not
//      for folder in folders {
//        let check = dirUrl?.appendingPathComponent(folder)
//        if check?.hasDirectoryPath == true {
//          self.Arrayfolders.append(folder)
//        } else {
//          print(“sory is not folder \(folder)“)
//        }
//      }
//    } catch {}
//  }
//}
