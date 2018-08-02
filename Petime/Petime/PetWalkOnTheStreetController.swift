//
//  PetWalkOnTheStreetController.swift
//  Petime
//
//  Created by Pavel on 29/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import CoreData

class PetWalkOnTheStreetController: UITableViewController, CreatePetWalkOnTheStreetControllerDelegate {
	
	func addNewCell(petWalk: PetWalk) {
		petWalkList.append(petWalk)
		tableView.reloadData()
	}

	var petWalkList = [PetWalk]()
	var petName: PetName?
	
	func fetch() {
		guard let allPetsTime = petName?.petWalk?.allObjects as? [PetWalk] else { return }
		petWalkList = allPetsTime
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = petName?.name
		view.backgroundColor = .darkBlueColor
		let refreshItem = UIBarButtonItem(title: "Remove All", style: .plain, target: self, action: #selector(hangleRemove))
		let addItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(hangleAdd))
		navigationItem.setRightBarButtonItems([addItem, refreshItem], animated: true)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.tableFooterView = UIView(frame: CGRect.zero)
		fetch()
	}
	
	@objc func hangleRemove() {
		
	}
	
	@objc func hangleAdd() {
		let createPetWalkOnTheStreetController = CreatePetWalkOnTheStreetController()
		createPetWalkOnTheStreetController.pet = petName
		createPetWalkOnTheStreetController.delegate = self
		let navBar = CustomNavigationController(rootViewController: createPetWalkOnTheStreetController)
		present(navBar, animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petWalkList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.textColor = .white
		cell.backgroundColor = .darkBlueColor
		cell.selectionStyle = UITableViewCellSelectionStyle.none
		let nameCell = petWalkList[indexPath.row]
		if let date = nameCell.date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
			cell.textLabel?.text = dateFormatter.string(from: date)
		}
		return cell
	}
	
}
