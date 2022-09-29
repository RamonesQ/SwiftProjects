//
//  QuotesManagert.swift
//  Frases
//
//  Created by Ramon Queiroz dos Santos on 09/09/22.
//

import Foundation

class QuotesManager {
	
	let quotes: [Quote]
	
	init(){
		let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json")!
		let jsonData = try! Data(contentsOf: fileURL)
		let JsonDecoder = JSONDecoder()
		quotes = try! JsonDecoder.decode([Quote].self, from: jsonData)
	}
	
	func getRandomQuote() -> Quote {
		let index = Int(arc4random_uniform(UInt32(quotes.count)))
		return quotes[index]
	}
}
