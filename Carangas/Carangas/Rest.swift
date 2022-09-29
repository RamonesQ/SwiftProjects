//
//  Rest.swift
//  Carangas
//
//  Created by Ramon Queiroz dos Santos on 28/09/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
	case url
	case taskError(error: Error)
	case noResponse
	case noData
	case responseStatusCode (code: Int)
	case invalidJson
}

enum RestOperation{
	case save
	case update
	case delete
}

class Rest {
	
	private static let basePath = "https://carangas.herokuapp.com/cars"
	
	private static let configuration: URLSessionConfiguration = {
		let config = URLSessionConfiguration.default
		config.allowsCellularAccess = false
		config.httpAdditionalHeaders = ["Conten-Type" : "application/json"]
		config.timeoutIntervalForRequest = 30.0
		config.httpMaximumConnectionsPerHost = 5
		return config
	}()
	
	private static let session = URLSession(configuration: configuration)
	
	class func loadCars(onComplete: @escaping ([Car]) -> (), onError: @escaping (CarError) -> ()) {
		guard let url = URL(string: basePath) else {
			onError(.url)
			return
		}
		let dataTask = session.dataTask(with: url) { (data, response, error) in
			if error == nil{
				guard let response = response as? HTTPURLResponse else {
					onError(.noResponse)
					return
				}
				if response.statusCode == 200 {
					guard let data = data else {return}
					do {
						let cars = try JSONDecoder().decode([Car].self, from: data)
						onComplete(cars)
					} catch {
						onError(.invalidJson)
					}
				} else {
					onError(.responseStatusCode(code: response.statusCode))
				}
			} else {
				onError(.taskError(error: error!))
			}
		}
		dataTask.resume()
	}
	
	class func save(car: Car, onComplete: @escaping (Bool) -> Void) {
		applyOperation(car: car, operation: .save, onComplete: onComplete)
	}
	
	class func update(car: Car, onComplete: @escaping (Bool) -> Void) {
		applyOperation(car: car, operation: .update, onComplete: onComplete)
	}
	
	class func delete(car: Car, onComplete: @escaping (Bool) -> Void) {
		applyOperation(car: car, operation: .delete, onComplete: onComplete)
	}
	
	private class func applyOperation(car: Car, operation: RestOperation,  onComplete: @escaping (Bool) -> Void){
		
		let urlString = basePath + "/" + (car.id ?? "")
		
		guard let url = URL(string: urlString) else {
			onComplete(false)
			return
		}
		
		var httpMethod: String = ""
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		switch operation {
		case .save:
			httpMethod = "POST"
		case .update:
			httpMethod = "PUT"
		case .delete:
			httpMethod = "DELETE"
		}
		
		request.httpMethod = httpMethod
		
		guard let json = try? JSONEncoder().encode(car) else {
			onComplete(false)
			return
		}
		request.httpBody = json
		
		let dataTask = session.dataTask(with: request) { data, response, error in
			if error == nil {
				guard let response = response as? HTTPURLResponse else {
					onComplete(false)
					return
				}
				if response.statusCode == 200 {
					guard let _ = data else {
						onComplete(false)
						return
					}
				}
				onComplete(true)
			} else {
				onComplete(false)
			}
		}
		dataTask.resume()
	}
	class func loadBrand(onComplete: @escaping ([Brand]?) -> ()) {
		guard let url = URL(string: "https://brasilapi.com.br/api/fipe/marcas/v1/carros") else {
			onComplete(nil)
			return
		}
		let dataTask = session.dataTask(with: url) { (data, response, error) in
			if error == nil{
				guard let response = response as? HTTPURLResponse else {
					print("response error")
					onComplete(nil)
					return
				}
				if response.statusCode == 200 {
					guard let data = data else {return}
					do {
						let brands = try JSONDecoder().decode([Brand].self, from: data)
						print(response.statusCode)
						onComplete(brands)
					} catch {
						print("erro no JAson")
						onComplete(nil)
					}
				} else {
					print("status code: \(response.statusCode)")
					onComplete(nil)
				}
			} else {
				print("erro na task")
				onComplete(nil)
			}
		}
		dataTask.resume()
	}
	
}

