//
//  bleTabBarController.swift
//  BLE Rice App
//
//  Created by Vikram Mullick on 7/19/16.
//  Copyright © 2016 Vikram Mullick. All rights reserved.
//

import UIKit

class bleTabBarController: UITabBarController, BLEDelegate{
    
    var ble : BLE = BLE()
    var mainView : bleMainViewController = bleMainViewController()
    var graphDataView : bleGraphDataController = bleGraphDataController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainView = self.viewControllers![0] as! bleMainViewController
        graphDataView = self.viewControllers![1] as! bleGraphDataController
        ble.delegate = self
        graphDataView.loadView()
        graphDataView.startTime = CFAbsoluteTimeGetCurrent()

    }
    func bleDidUpdateState(){}
    func bleDidConnectToPeripheral(){}
    func bleDidDisconenctFromPeripheral(){}
    func blePeripheralsWasAltered(){}
    
    func bleDidReceiveData(data: NSData?)
    {
        var receivedString = String(NSString.init(data: data!, encoding: NSUTF8StringEncoding)!)
        receivedString = receivedString.stringByReplacingOccurrencesOfString("\r", withString: "", options: .RegularExpressionSearch)
        mainView.terminalTextView.text = mainView.terminalTextView.text + "received: " + receivedString + "\n"
        
        if receivedString.containsString(":")
        {
            let recievedStringArray = receivedString.componentsSeparatedByString(":")
            let content : String = recievedStringArray[1]
            if let identifier : Int = Int(recievedStringArray[0])
            {
                if identifier==2
                {
                    if let dataToSend : Double = Double(content)
                    {
                        graphDataView.addDataValue(dataToSend)
                    }
                }
            }
        }
    
        mainView.scrollDownTerminalTextView()
    }

    
    
    
}