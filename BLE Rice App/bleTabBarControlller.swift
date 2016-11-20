//
//  bleTabBarControlller.swift
//  BLE Rice App
//
//  Created by Vikram Mullick on 7/9/16.
//  Copyright © 2016 Vikram Mullick. All rights reserved.
//

import UIKit

class bleTabBarController: UITabBarController, BLEDelegate{
    
    var ble : BLE = BLE()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ble.delegate = self
        
        
    }
    
   
    func bleDidUpdateState()
    {
        
    }
    func bleDidConnectToPeripheral()
    {
        
    }
    func bleDidDisconenctFromPeripheral()
    {
        
        
    }
    func blePeripheralsWasAltered()
    {
        
    }
    func bleDidReceiveData(data: NSData?)
    {
        
        
        
    }
 
}
