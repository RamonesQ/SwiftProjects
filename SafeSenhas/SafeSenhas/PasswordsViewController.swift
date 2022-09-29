//
//  PasswordsViewController.swift
//  SafeSenhas
//
//  Created by Ramon Queiroz dos Santos on 06/09/22.
//

import UIKit

class PasswordsViewController: UIViewController {

	@IBOutlet weak var tvPasswords: UITextView!
	
	var numberOfCharacters: Int = 10
	var numberOfPassWords: Int = 1
	var useLetters: Bool!
	var useNumbers: Bool!
	var useCapitalLetters: Bool!
	var useSpecialCharacters: Bool!
	
	var passwordGenerator: PasswordGenerator!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Total de senhas: \(numberOfPassWords)"
		passwordGenerator = PasswordGenerator(numberOfCharacters: numberOfCharacters, useLetters: useLetters, useNumbers: useNumbers, useCapitalLetters: useCapitalLetters, useSpecialCharacters: useSpecialCharacters)
		
		generatePasswords()
		

    }

	func generatePasswords(){
		tvPasswords.scrollRangeToVisible(NSRange(location: 0, length: 0))
		tvPasswords.text = ""
		let passwords = passwordGenerator.generate(total: numberOfPassWords)
		for password in passwords {
			tvPasswords.text.append(password + "\n\n")
		}
		print(numberOfPassWords)
		print(passwords)
	}
	
	@IBAction func generate(_ sender: UIButton) {
		generatePasswords()
	}
	
}
