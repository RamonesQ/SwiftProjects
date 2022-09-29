//
//  TestCoreDataStack.swift
//  GamesTests
//
//  Created by Ramon Queiroz dos Santos on 13/09/22.
//

import Foundation
import CoreData
import XCTest
@testable import Games

class TestCoreDataStack: NSObject {

	let mainContext: NSManagedObjectContext
	
	init(mainContext: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
		 self.mainContext = mainContext
	}
	
	 lazy var persistentContainer: NSPersistentContainer = {
		  let description = NSPersistentStoreDescription()
		  description.url = URL(fileURLWithPath: "/dev/null")
		  let container = NSPersistentContainer(name: "Games")
		  container.persistentStoreDescriptions = [description]
		  container.loadPersistentStores { _, error in
				if let error = error as NSError? {
					 fatalError("Unresolved error \(error), \(error.userInfo)")
				}
		  }
		  return container
	 }()
}
