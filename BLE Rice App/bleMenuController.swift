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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ble.peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = ble.peripherals[indexPath.row].identifier.uuidString
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        ble.connectToPeripheral(ble.peripherals[indexPath.row])
        
        performSegue(withIdentifier: "segue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destination : bleTabBarController = segue.destination as! bleTabBarController
        destination.ble = self.ble
        (destination.viewControllers![0] as! bleMainViewController).ble = self.ble
        //(destination.viewControllers![1] as! bleGraphDataController).ble = self.ble
        
    }
    func blePeripheralsWasAltered()
    {
        tableView.reloadData()
    }
    func bleDidReceiveData(_ data: Data?)
    {
        
    }

    
    @IBAction func scan(_ sender: AnyObject)
    {
        ble.startScanning(3)
    }
}

