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
}
