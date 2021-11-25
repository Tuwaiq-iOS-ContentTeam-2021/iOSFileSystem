//
//  ViewController.swift
//  UserDefaultTest
//
//  Created by dev on 22/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //flag
        flag = UserDefaults.standard.bool(forKey: "colorStyle")
        if flag {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light

        }
        //1. check the dafult
        //2. present it
        
    }
    
    @IBAction func action(_ sender: Any) {
        
        flag.toggle()
        UserDefaults.standard.set(flag,forKey: "colorStyle")
        if flag {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }
        
        //1. clicked
        //2. toggle (Value)
        
        //3. save
        //4. change background
        
    }

}
