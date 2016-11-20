//
//  bleGraphDataController.swift
//  BLE Rice App
//
//  Created by Vikram Mullick on 7/19/16.
//  Copyright © 2016 Vikram Mullick. All rights reserved.
//
import UIKit

class bleGraphDataController: UIViewController{
    
    @IBOutlet weak var testLabel: UILabel!
    var startTime: CFAbsoluteTime = CFAbsoluteTime()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    func addDataValue(data : Double)
    {
        let time = CFAbsoluteTimeGetCurrent() - startTime
       
        print("(\(time),\(data))")
        testLabel.text = "(\(time),\(data))"
    }
    
    
    
}

