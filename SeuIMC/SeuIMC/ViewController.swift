//
//  ViewController.swift
//  SeuIMC
//
//  Created by Ramon Queiroz dos Santos on 29/08/22.
//

import UIKit

class ViewController: UIViewController {
	
	
	@IBOutlet weak var pesoTextField: UITextField!
	@IBOutlet weak var alturaTextField: UITextField!
	@IBOutlet weak var resultLabel: UILabel!
	@IBOutlet weak var imageResult: UIImageView!
	@IBOutlet weak var ivResult: UIView!
	
	var imc: Double = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	@IBAction func calcular(_ sender: Any) {
		if let peso =  Double(pesoTextField.text!), let altura = Double(alturaTextField.text!){
			imc = peso / pow(altura, 2)
			mostraResultado()
		}
	}
	
	func mostraResultado(){
		var resultado: String = ""
		var imagem: String = ""
		switch imc {
			case 0..<16:
				resultado = "Magreza"
				imagem = "abaixo"
			case 16..<18.5:
				resultado = "Abaixo do peso"
				imagem = "abaixo"
			case 18.5..<25:
				resultado = "Peso ideal"
				imagem = "ideal"
			case 25..<30:
				resultado = "Sobrepeso"
				imagem = "sobre"
			default :
				resultado = "Obesidade"
				imagem = "obesidade"
		}
		resultLabel.text = "\(Int(imc)): \(resultado)"
		imageResult.image = UIImage(named: imagem)
		ivResult.isHidden = false
		view.endEditing(true)
	}
}

