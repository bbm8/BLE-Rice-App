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
    @IBOutlet weak var terminalFieldView: UIView!
    @IBOutlet weak var configurableButtonView: UIView!
    @IBOutlet weak var editModeView: UIView!
    
    @IBOutlet weak var terminalTextField: UITextField!
    
    @IBOutlet weak var editToggle: UISwitch!
    
    let defaults = UserDefaults.standard
    
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
        terminalTextField.autocorrectionType = .no

        terminalTextView.isEditable = false
        
        configurableButtons = [one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve]
        
        setNamesOfConfigurableButtons()
        setupConfigurableButtons()
        
        for button in configurableButtons{
            button.backgroundColor = terminalTextView.backgroundColor?.darker(by: 30)
        }
     
        
    }
    func setupConfigurableButtons()
    {
        for button:ConfigurableButton in configurableButtons
        {
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
 
        }
    }
    
    func buttonTapped(_ sender:ConfigurableButton!)
    {
        if(editToggle.isOn)
        {
            configurableButtonToEdit = sender
            
            performSegue(withIdentifier: "segueConfigure", sender: nil)
            
        }
        else
        {
            if let outString = defaults.string(forKey: sender.serialCommand)
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
            if let nameString = defaults.string(forKey: button.name)
            {
                button.setTitle(nameString, for: UIControlState())
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        BLEwrite(textField.text!)
        return true
    }
    func BLEwrite(_ outString : String)
    {
        let data = outString.data(using: String.Encoding.utf8)
        ble.write(data: data!)
        terminalTextView.text = terminalTextView.text + "sent: " + outString + "\n"
        scrollDownTerminalTextView()
        
    }
    func scrollDownTerminalTextView()
    {
        let range = NSMakeRange(terminalTextView.text.characters.count, 0)
        terminalTextView.scrollRangeToVisible(range)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destination = segue.destination as! configureMenu
        destination.button = configurableButtonToEdit
        destination.defaults = self.defaults
    }
   
    @IBAction func tapToResignKeyboard(_ sender: AnyObject)
    {
        terminalTextField.resignFirstResponder()
    }
    
    
}
