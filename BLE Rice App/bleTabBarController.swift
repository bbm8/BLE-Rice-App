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

    var colors = [UIColor]()
    var currentIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainView = self.viewControllers![0] as! bleMainViewController
        graphDataView = self.viewControllers![1] as! bleGraphDataController
        ble.delegate = self
        graphDataView.loadView()
        graphDataView.startTime = CFAbsoluteTimeGetCurrent()
        graphDataView.graphScrollView.contentSize = graphDataView.graphScrollView.frame.size

        colors = [UIColor.red, UIColor(red: 0, green: 0.5, blue: 0, alpha: 1), UIColor(red: 138/255, green: 43/255, blue: 226/255, alpha: 1), UIColor.orange]

    }
    override func viewDidLayoutSubviews() {
        colors = [UIColor.red, UIColor(red: 0, green: 0.5, blue: 0, alpha: 1), UIColor(red: 138/255, green: 43/255, blue: 226/255, alpha: 1), UIColor.orange, mainView.terminalTextView.backgroundColor!]
    }
    func bleDidUpdateState(){}
    func bleDidConnectToPeripheral(){}
    func bleDidDisconenctFromPeripheral(){}
    func blePeripheralsWasAltered(){}
    
    func bleDidReceiveData(_ data: Data?)
    {
        var receivedString = String(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)!)
        receivedString = receivedString.replacingOccurrences(of: "\r", with: "", options: .regularExpression)
        
        if receivedString.contains(":")//Checks if incoming string has a ':'
        {
            let recievedStringArray = receivedString.components(separatedBy: ":")//creates 2 element array separated by ':'
            let content : String = recievedStringArray[1]//creates a content string equal to second element in array
            if let identifier : Int = Int(recievedStringArray[0])//creates an identifier int equal to the first element in the array
            {
                if identifier == 1
                {
                    mainView.terminalTextView.text = mainView.terminalTextView.text + "received: " + content + "\n"//adds response to terminal
                    
                }
                if identifier == 2
                {
                    if let dataToSend : Double = Double(content)//typecastes content to a double
                    {
                        graphDataView.addDataValue(dataToSend)//calls addDataValue function to graph data point
                    }
                }
                if identifier == 3
                {
                    if content == "Clr"
                    {
                        print(3)
                        currentIndex = (currentIndex + 1)%colors.count
                        mainView.terminalTextView.backgroundColor = colors[currentIndex]
                        mainView.terminalFieldView.backgroundColor = colors[currentIndex]
                        mainView.editModeView.backgroundColor = colors[currentIndex]
                        mainView.configurableButtonView.backgroundColor = colors[currentIndex]
                        for button in mainView.configurableButtons{
                            button.backgroundColor = colors[currentIndex].darker(by: 30)
                        }
                    }
                    
                }
               
            }
        }
    
        mainView.scrollDownTerminalTextView()//autoscrolls the terminal view
    }
    
}
extension UIColor {
    
    func lighter(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=30.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
}
