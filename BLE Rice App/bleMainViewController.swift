//
//  bleMainViewController.swift
//  BLE Rice App
//
//  Created by Vikram Mullick on 7/6/16.
//  Copyright © 2016 Vikram Mullick. All rights reserved.
//


import UIKit

class bleMainViewController: UIViewController, UITextFieldDelegate{
    
    var ble : BLE = BLE()
    @IBOutlet weak var terminalTextView: UITextView!
    @IBOutlet weak var terminalTextField: UITextField!
    
    @IBOutlet weak var editToggle: UISwitch!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var one: ConfigurableButton!
    @IBOutlet weak var two: ConfigurableButton!
    @IBOutlet weak var three: ConfigurableButton!
    @IBOutlet weak var four: ConfigurableButton!
    @IBOutlet weak var five: ConfigurableButton!
    @IBOutlet weak var six: ConfigurableButton!
    @IBOutlet weak var seven: ConfigurableButton!
    @IBOutlet weak var eight: ConfigurableButton!
    @IBOutlet weak var nine: ConfigurableButton!
    @IBOutlet weak var ten: ConfigurableButton!
    @IBOutlet weak var eleven: ConfigurableButton!
    @IBOutlet weak var twelve: ConfigurableButton!
    
    var configurableButtons = [ConfigurableButton]()
    
    var configurableButtonToEdit : ConfigurableButton = ConfigurableButton()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        terminalTextField.delegate = self
        terminalTextView.editable = false
        
        configurableButtons = [one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve]
        
        setNamesOfConfigurableButtons()
        setupConfigurableButtons()
     
        
    }
    func setupConfigurableButtons()
    {
        for button:ConfigurableButton in configurableButtons
        {
            button.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)

        }
    }
    func buttonTapped(sender:ConfigurableButton!)
    {
        if(editToggle.on)
        {
            configurableButtonToEdit = sender
            
            performSegueWithIdentifier("segueConfigure", sender: nil)
            
        }
        else
        {
            if let outString = defaults.stringForKey(sender.serialCommand)
            {
                BLEwrite(outString)
            }
            
        }

    }
    func setNamesOfConfigurableButtons()
    {
        one.name = "one"
        two.name = "two"
        three.name = "three"
        four.name = "four"
        five.name = "five"
        six.name = "six"
        seven.name = "seven"
        eight.name = "eight"
        nine.name = "nine"
        ten.name = "ten"
        eleven.name = "eleven"
        twelve.name = "twelve"
        
        one.serialCommand = "oneSerial"
        two.serialCommand = "twoSerial"
        three.serialCommand = "threeSerial"
        four.serialCommand = "fourSerial"
        five.serialCommand = "fiveSerial"
        six.serialCommand = "sixSerial"
        seven.serialCommand = "sevenSerial"
        eight.serialCommand = "eightSerial"
        nine.serialCommand = "nineSerial"
        ten.serialCommand = "tenSerial"
        eleven.serialCommand = "elevenSerial"
        twelve.serialCommand = "twelveSerial"
        
        for button:ConfigurableButton in configurableButtons
        {
            button.layer.cornerRadius = 20
            if let nameString = defaults.stringForKey(button.name)
            {
                button.setTitle(nameString, forState: UIControlState.Normal)
            }
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        BLEwrite(textField.text!)
        return true
    }
    func BLEwrite(outString : String)
    {
        let data = outString.dataUsingEncoding(NSUTF8StringEncoding)
        ble.write(data: data!)
        terminalTextView.text = terminalTextView.text + "sent: " + outString + "\n"
        scrollDownTerminalTextView()
        
    }
    func scrollDownTerminalTextView()
    {
        let range = NSMakeRange(terminalTextView.text.characters.count, 0)
        terminalTextView.scrollRangeToVisible(range)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let destination = segue.destinationViewController as! configureMenu
        destination.button = configurableButtonToEdit
        destination.defaults = self.defaults
    }
   
    @IBAction func tapToResignKeyboard(sender: AnyObject)
    {
        terminalTextField.resignFirstResponder()
    }
    
    
}
