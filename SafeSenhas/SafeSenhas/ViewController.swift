//
//  ViewController.swift
//  SafeSenhas
//
//  Created by Ramon Queiroz dos Santos on 06/09/22.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tfTotalPasswords: UITextField!
	@IBOutlet weak var tfNumberOfCharacters: UITextField!
	@IBOutlet weak var swLetters: UISwitch!
	@IBOutlet weak var swNumbers: UISwitch!
	@IBOutlet weak var swCapitalLetters: UISwitch!
	@IBOutlet weak var swSpecial: UISwitch!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let passwordsViewController = segue.destination as! PasswordsViewController
		if let numberOfPasswords = Int(tfTotalPasswords.text!){
			passwordsViewController.numberOfPassWords = numberOfPasswords
		}
		if let numberOfCharacters = Int(tfNumberOfCharacters.text!){
			passwordsViewController.numberOfCharacters = numberOfCharacters
		}
		passwordsViewController.useLetters = swLetters.isOn
		passwordsViewController.useNumbers = swNumbers.isOn
		passwordsViewController.useCapitalLetters = swCapitalLetters.isOn
		passwordsViewController.useSpecialCharacters = swSpecial.isOn
		view.endEditing(true)
	}

}

