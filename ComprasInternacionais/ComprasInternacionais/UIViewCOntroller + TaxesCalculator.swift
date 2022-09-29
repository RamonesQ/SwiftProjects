//
//  UIViewCOntroller + TaxesCalculator.swift
//  ComprasInternacionais
//
//  Created by Ramon Queiroz dos Santos on 08/09/22.
//

import Foundation
import UIKit

extension UIViewController {
	var tc: TaxesCalculator{
		return TaxesCalculator.shared
	}
}
