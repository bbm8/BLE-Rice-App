//
//  ViewController.swift
//  BLE Rice App
//
//  Created by Vikram Mullick on 7/5/16.
//  Copyright © 2016 Vikram Mullick. All rights reserved.
//

import UIKit

class bleMenuController: UIViewController, UITableViewDataSource, BLEDelegate, UITableViewDelegate{

    var ble = BLE.init()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        ble.delegate = self

    }

       func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ble.peripherals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = ble.peripherals[indexPath.row].identifier.UUIDString
        return cell
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        ble.connectToPeripheral(ble.peripherals[indexPath.row])
        
        performSegueWithIdentifier("segue", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let destination : bleTabBarController = segue.destinationViewController as! bleTabBarController
        destination.ble = self.ble
        (destination.viewControllers![0] as! bleMainViewController).ble = self.ble
        //(destination.viewControllers![1] as! bleGraphDataController).ble = self.ble
        
    }
    func blePeripheralsWasAltered()
    {
        tableView.reloadData()
    }
    func bleDidReceiveData(data: NSData?)
    {
        
    }

    
    @IBAction func scan(sender: AnyObject)
    {
        ble.startScanning(3)
    }
}

