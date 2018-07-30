//
//  CoreDataManager.swift
//  Petime
//
//  Created by Pavel on 18/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
	static let shared = CoreDataManager()
	let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "PetimeDataBase")
		container.loadPersistentStores { (storeDescription, err) in
			if let err = err {
				fatalError("Loading of store failed: \(err)")
			}
		}
		return container
	}()
	
	func savePetNameInCoreData(name: String, date: Date) -> (PetName?, Error?) {
		let viewContext = persistentContainer.viewContext
		let entity = NSEntityDescription.insertNewObject(forEntityName: "PetName", into: viewContext) as! PetName
		entity.setValue(name, forKey: "name")
		entity.setValue(date, forKey: "date")
		do {
			try viewContext.save()
			return (entity, nil)
		} catch let error {
			print(error)
			return (nil, nil)
		}
	}
	
	func savePetWalkInCoreData(date: Date, pet: PetName) -> (PetWalk?, Error?) {
		let viewContext = persistentContainer.viewContext
		let entity = NSEntityDescription.insertNewObject(forEntityName: "PetWalk", into: viewContext) as! PetWalk
		entity.petName = pet
		entity.setValue(date, forKey: "date")
		do {
			try viewContext.save()
			return (entity, nil)
		} catch let error {
			print(error)
			return (nil, nil)
		}
	}
	
}
