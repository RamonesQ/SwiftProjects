//
//  SettingsViewController.swift
//  ComprasInternacionais
//
//  Created by Ramon Queiroz dos Santos on 08/09/22.
//

import UIKit

class SettingsViewController: UIViewController {
	
	@IBOutlet weak var tfDolar: UITextField!
	@IBOutlet weak var tfIof: UITextField!
	@IBOutlet weak var tfStateTaxes: UITextField!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		 tfDolar.text = tc.getFormattedValue(of: tc.dolar, whithCurrency: "")
		 tfIof.text = tc.getFormattedValue(of: tc.iof, whithCurrency: "")
		 tfStateTaxes.text = tc.getFormattedValue(of: tc.stateTax, whithCurrency: "")
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}

	func setValues() {
		tc.dolar = tc.convertToDouble(tfDolar.text!)
		tc.iof = tc.convertToDouble(tfIof.text!)
		tc.stateTax = tc.convertToDouble(tfDolar.text!)
	}
    
}

extension SettingsViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		setValues()
	}
}
