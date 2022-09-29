//
//  ViewController.swift
//  ComprasInternacionais
//
//  Created by Ramon Queiroz dos Santos on 08/09/22.
//

import UIKit

class ShoppingViewController: UIViewController {
	
	@IBOutlet weak var tfDolar: UITextField!
	@IBOutlet weak var lbRealDescription: UILabel!
	@IBOutlet weak var lbReal: UILabel!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setAmount()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		tfDolar.resignFirstResponder()
		setAmount()
	}
	
	func setAmount(){
		tc.shoppingValue = tc.convertToDouble(tfDolar.text!)
		lbReal.text = tc.getFormattedValue(of: tc.shoppingValue * tc.dolar, whithCurrency: "R$ ")
		let dolar = tc.getFormattedValue(of: tc.dolar, whithCurrency: "")
		lbRealDescription.text = "Valor sem impostos (dolár \(dolar))"
	}

}

