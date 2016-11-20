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
    var defaults : NSUserDefaults = NSUserDefaults()
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var serialField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureMenu.layer.borderWidth = 1
        configureMenu.layer.borderColor = UIColor.whiteColor().CGColor
        
        if let serialString = defaults.stringForKey(button.serialCommand)
        {
            serialField.text = serialString
        }
        if let nameString = defaults.stringForKey(button.name)
        {
            nameField.text = nameString
        }
        
        

    }
    @IBAction func cancelButton(sender: AnyObject)
    {
       
        self.dismissViewControllerAnimated(true, completion: {});

    }
    
    @IBAction func tap(sender: AnyObject)
    {
        nameField.resignFirstResponder()
        serialField.resignFirstResponder()
    }
   
    @IBAction func set(sender: AnyObject)
    {
        button.setTitle(nameField.text, forState: UIControlState.Normal)
        
        defaults.setValue(serialField.text, forKey: button.serialCommand)
        defaults.setValue(nameField.text, forKey: button.name)
        defaults.synchronize()
        self.dismissViewControllerAnimated(true, completion: {});

    }
    
    
}
