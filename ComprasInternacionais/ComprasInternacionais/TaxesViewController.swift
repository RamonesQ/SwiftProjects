//
//  TaxesViewController.swift
//  ComprasInternacionais
//
//  Created by Ramon Queiroz dos Santos on 08/09/22.
//

import UIKit

class TaxesViewController: UIViewController {

	@IBOutlet weak var lbDolar: UILabel!
	@IBOutlet weak var lbStateTax: UILabel!
	@IBOutlet weak var lbTaxDescriprtion: UILabel!
	@IBOutlet weak var lbIof: UILabel!
	@IBOutlet weak var lbIofDescription: UILabel!
	@IBOutlet weak var swCreditCard: UISwitch!
	@IBOutlet weak var lbReal: UILabel!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
	calculateTaxes()
	}
	

	@IBAction func ChangeIof(_ sender: UISwitch) {
		calculateTaxes()
	}

	func calculateTaxes(){
		lbTaxDescriprtion.text = "Imposto do Estado (\(tc.getFormattedValue(of: tc.stateTax, whithCurrency: ""))"
		lbIof.text = "Imposto do Estado (\(tc.getFormattedValue(of: tc.iof, whithCurrency: ""))"
		
		lbDolar.text = tc.getFormattedValue(of: tc.shoppingValue, whithCurrency: "US$ ")
		lbStateTax.text = tc.getFormattedValue(of: tc.stateTax, whithCurrency: "US$ ")
		lbIof.text = tc.getFormattedValue(of: tc.iofValue, whithCurrency: "US$ ")
		
		let real = tc.calculate(usingCreditCard: swCreditCard.isOn)
		lbReal.text = tc.getFormattedValue(of: real, whithCurrency: "R$ ")
	}
}
