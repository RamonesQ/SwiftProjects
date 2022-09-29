//
//  Car.swift
//  Carangas
//
//  Created by Ramon Queiroz dos Santos on 28/09/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

class Car: Codable {
	
	var id: String?
	var brand: String = ""
	var gasType: Int = 0
	var name: String = ""
	var price: Double = 0.0
	
	var gas: String {
		switch gasType {
		case 0:
			return "Flex"
		case 1:
			return "Álcool"
		default:
			return "Gasolina"
		}
	}
	enum CodingKeys: String, CodingKey {
		 case id = "_id"
		 case brand, gasType, name, price
	}
}


struct Brand: Codable {
	 let nome: String
}


