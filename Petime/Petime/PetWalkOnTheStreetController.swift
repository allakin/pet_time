//
//  PetWalkOnTheStreetController.swift
//  Petime
//
//  Created by Pavel on 29/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import CoreData

class PetWalkOnTheStreetController: UITableViewController {
	
	var titleName = ""
	var petWalk = [PetWalk]()
	var petName: PetName?
	
	func fetch() {
		guard let allPetsTime = petName?.petWalk?.allObjects as? [PetWalk] else { return }
		petWalk = allPetsTime
		//		let viewContext = CoreDataManager.shared.persistentContainer.viewContext
		//		let fetchRequest = NSFetchRequest<PetWalk>(entityName: "PetWalk")
		//		do {
		//			petWalk = try viewContext.fetch(fetchRequest)
		//		} catch let error {
		//			print(error)
		//		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = petName?.name
		view.backgroundColor = .darkBlueColor
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(hangleAdd))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		fetch()
	}
	
	@objc func hangleAdd() {
		let createPetWalkOnTheStreetController = CreatePetWalkOnTheStreetController()
		createPetWalkOnTheStreetController.pet = petName
		let navBar = CustomNavigationController(rootViewController: createPetWalkOnTheStreetController)
		present(navBar, animated: true, completion: nil)
		print("working!")
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petWalk.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.textColor = .white
		cell.backgroundColor = .darkBlueColor
		cell.selectionStyle = UITableViewCellSelectionStyle.none
		let nameCell = petWalk[indexPath.row]
		if let date = nameCell.date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
			cell.textLabel?.text = dateFormatter.string(from: date)
		}
		return cell
	}
	
}
