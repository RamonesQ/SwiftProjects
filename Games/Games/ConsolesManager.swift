//
//  ConsolesManager.swift
//  Games
//
//  Created by Ramon Queiroz dos Santos on 12/09/22.
//

import Foundation
import CoreData

struct ConsolesManager {
	
		static let shared = ConsolesManager()
		var consoles: [Console] = []
	
	let mainContext: NSManagedObjectContext

	init(mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
		 self.mainContext = mainContext
	}

//	@discardableResult
	func createConsole(name: String) -> Console? {
		 let console = Console(context: mainContext)
		console.name = name
		 do {
			  try mainContext.save()
			  return console
		 } catch let error {
			  print("Failed to create: \(error)")
		 }
		 return nil
	}
	
	func fetchConsole(withName name: String) -> Console? {
		 let fetchRequest = NSFetchRequest<Console>(entityName: "Console")
		 fetchRequest.fetchLimit = 1
		 fetchRequest.predicate = NSPredicate(format: "firstName == %@", name)
		 
		 do {
			  let console = try mainContext.fetch(fetchRequest)
			  return console.first
		 } catch let error {
			  print("Failed to fetch: \(error)")
		 }
		 
		 return nil
	}
	
	func fetchConsoles() -> [Console]? {
		 let fetchRequest = NSFetchRequest<Console>(entityName: "Console")
		 do {
			  let console = try mainContext.fetch(fetchRequest)
			  return console
		 } catch let error {
			  print("Failed to fetch companies: \(error)")
		 }
		 
		 return nil
	}
	func deleteConsoles(console: Console) {
		 mainContext.delete(console)
		 do {
			  try mainContext.save()
		 } catch let error {
			  print("Failed to delete: \(error)")
		 }
	}
	
	
	
	
	
//	static let shared = ConsolesManager()
//	var consoles: [Console] = []
//
//	
//	func loadConsoles(with context: NSManagedObjectContext){
//		let fetchRequest: NSFetchRequest<Console> = Console.fetchRequest()
//		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//		fetchRequest.sortDescriptors = [sortDescriptor]
//		
//		do {
//			consoles = try context.fetch(fetchRequest)
//		} catch  {
//			print(error.localizedDescription)
//		}
//	}
//	
//	func deleteConsole(index: Int, context: NSManagedObjectContext) {
//		let console = consoles[index]
//		context.delete(console)
//		do {
//			try context.save()
//		} catch {
//			print(error.localizedDescription)
//		}
//	}
//	
//	private init() {
//		
//	}
}
