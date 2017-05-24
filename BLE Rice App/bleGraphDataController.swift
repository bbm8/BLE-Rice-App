//
//  bleGraphDataController.swift
//  BLE Rice App
//
//  Created by Vikram Mullick on 7/19/16.
//  Copyright © 2016 Vikram Mullick. All rights reserved.
//
import UIKit

class bleGraphDataController: UIViewController{
    
    @IBOutlet weak var graphScrollView: UIScrollView!
    let radius : CGFloat = 10
    var startTime: CFAbsoluteTime = CFAbsoluteTime()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()


    }
  
    func addDataValue(_ data : Double)
    {
        
        let time = CFAbsoluteTimeGetCurrent() - startTime//gets time at which data was received
       
        //print("(\(time),\(data))")
        //testLabel.text = "(\(time),\(data))"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //draws circle on graph at x=time to represent a data point
        let ellipsePath = UIBezierPath(ovalIn: CGRect(x: CGFloat(time)*25-radius/2, y: (graphScrollView.contentSize.height)/2-CGFloat(data)/5-radius/2, width: radius, height: radius))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = ellipsePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        graphScrollView.layer.addSublayer(shapeLayer)
        graphScrollView.contentSize = CGSize(width: CGFloat(time)*25+radius*3, height: graphScrollView.contentSize.height)
        
        //shifts scroll view to the left
        if CGFloat(time)*25+radius*3 >= graphScrollView.frame.width
        {
            graphScrollView.contentOffset = CGPoint(x: CGFloat(time)*25-graphScrollView.frame.width+radius*2,y: graphScrollView.contentOffset.y)
        }
       

    }
    
    
    
}

