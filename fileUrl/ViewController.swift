//
//  ViewController.swift
//  fileUrl
//
//  Created by Areej on 18/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    let fileManager = FileManager.default

    override func viewDidLoad() {
        
        let dirUrl = fileManager.urls(for: .desktopDirectory, in: .userDomainMask).first
        
        do{
            
            let dir = dirUrl?.appendingPathComponent("document100")
            try fileManager.createDirectory(at: dir!, withIntermediateDirectories: true, attributes: [:])
        }catch {
            
            print("Somthing wrong")
        }
        
        let dirForFile =
            dirUrl?.appendingPathComponent("doucment10").appendingPathComponent("name.txt")
            let text = "hello".data(using: .utf8)
            fileManager.createFile(atPath: dirForFile!.path, contents: text, attributes: [:])
            print(dirUrl!.path)
          }
    
    


    }
    
    
    
  



