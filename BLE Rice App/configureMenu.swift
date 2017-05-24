//
//  configureMenu.swift
//  BLE Rice App
//
//  Created by Vikram Mullick on 7/11/16.
//  Copyright © 2016 Vikram Mullick. All rights reserved.
//

import UIKit

class configureMenu: UIViewController
{
    
    @IBOutlet weak var configureMenu: UIView!
    
    var button : ConfigurableButton = ConfigurableButton()
    var defaults : UserDefaults = UserDefaults()
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var serialField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureMenu.layer.borderWidth = 1
        configureMenu.layer.borderColor = UIColor.white.cgColor
        
        if let serialString = defaults.string(forKey: button.serialCommand)
        {
            serialField.text = serialString
        }
        if let nameString = defaults.string(forKey: button.name)
        {
            nameField.text = nameString
        }
        
        

    }
    @IBAction func cancelButton(_ sender: AnyObject)
    {
       
        self.dismiss(animated: true, completion: {});

    }
    
    @IBAction func tap(_ sender: AnyObject)
    {
        nameField.resignFirstResponder()
        serialField.resignFirstResponder()
    }
   
    @IBAction func set(_ sender: AnyObject)
    {
        button.setTitle(nameField.text, for: UIControlState())
        
        defaults.setValue(serialField.text, forKey: button.serialCommand)
        defaults.setValue(nameField.text, forKey: button.name)
        defaults.synchronize()
        self.dismiss(animated: true, completion: {});

    }
    
    
}
