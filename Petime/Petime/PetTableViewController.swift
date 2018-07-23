//
//  PetTableViewController.swift
//  Petime
//
//  Created by Pavel on 16/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import CoreData

class PetTableViewController: UITableViewController, CreatePetControllerDelegate, EditPetNameViewControllerDelegate {
	func editPetName(name: PetName) {
		let row = petName.index(of: name)
		let indexPath = IndexPath(row: row!, section: 0)
		tableView.reloadRows(at: [indexPath], with: .middle)
	}
	
	
	func createPetName(name: PetName) {
		petName.append(name)
		let indexPath = IndexPath(row: petName.count-1, section: 0)
		tableView.insertRows(at: [indexPath], with: .automatic)
	}
	
	let cellIndetifier = "cell"
	var petName = [PetName]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Pets name"
//		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddPet))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIndetifier)
		tableView.backgroundColor = .darkBlueColor
		
		let viewContext = CoreDataManager.shared.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<PetName>(entityName: "PetName")
		do {
			petName = try viewContext.fetch(fetchRequest)
		} catch let error {
			print(error)
		}
		
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petName.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath)
		let name = petName[indexPath.row]
		if let date = name.date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MM/dd/yyyy"
			cell.textLabel?.text = "\(name.name! ?? "") - \(dateFormatter.string(from: date))"
		}
		cell.textLabel?.textColor = .white
		cell.backgroundColor = .darkBlueColor
		return cell
	}
	
	@objc func handleAddPet() {
		let createPetController = CreatePetController()
		createPetController.delegate = self
		let navController = CustomNavigationController(rootViewController: createPetController)
		present(navController, animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let petWalk = PetWalkOnTheStreet()
		navigationController?.pushViewController(petWalk, animated: true)
//		let editPetName = EditPetNameViewController()
//		editPetName.delegate = self
//		editPetName.petName = petName[indexPath.row]
//		let navBar = CustomNavigationController(rootViewController: editPetName)
//		present(navBar, animated: true, completion: nil)
	}
	
}
