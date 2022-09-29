//
//  Quoute.swift
//  Frases
//
//  Created by Ramon Queiroz dos Santos on 09/09/22.
//

import Foundation

struct Quote: Codable {
	let quote: String
	let author: String
	let image: String
	
	var quoteFormatted: String {
		return "❝" + quote + "❞"
	}
	
	var authorFormatted: String{
		return "--" + author + "--"
	}
}
