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
		navigationItem.title = "Pets list"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddPet))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIndetifier)
		tableView.backgroundColor = .darkBlueColor
		tableView.tableFooterView = UIView(frame: CGRect.zero)
		
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
		let nameCell = petName[indexPath.row]
		if let date = nameCell.date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MM/dd/yyyy"
			cell.textLabel?.text = nameCell.name! + " - " + dateFormatter.string(from: date)
//			let label = UILabel.init(frame: CGRect(x:0,y:0,width:30,height:44))
//			label.text = "99"
//			label.textColor = .white
//			cell.accessoryView = label
		}
//		cell.contentView.backgroundColor = .darkPinkColor
		let backgroundColorView = UIView()
		backgroundColorView.backgroundColor = .darkPinkColor
		UITableViewCell.appearance().selectedBackgroundView = backgroundColorView
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
		let petWalk = PetWalkOnTheStreetController()
		petWalk.petName = petName[indexPath.row]
		navigationController?.pushViewController(petWalk, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
			let petlist = self.petName[indexPath.row]
			
			self.petName.remove(at: indexPath.row)
			self.tableView.deleteRows(at: [indexPath], with: .automatic)
			
			// delete the company from Core Data
			let context = CoreDataManager.shared.persistentContainer.viewContext
			
			context.delete(petlist)
			
			do {
				try context.save()
			} catch let saveErr {
				print("Failed to delete name:", saveErr)
			}
		}
		deleteAction.backgroundColor = .darkPinkColor
		
		let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
		editAction.backgroundColor = .darkPurpleColor
		
		return [deleteAction, editAction]
	}
	
	private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
		let editPetName = EditPetNameViewController()
		editPetName.delegate = self
		editPetName.petName = petName[indexPath.row]
		let navBar = CustomNavigationController(rootViewController: editPetName)
		present(navBar, animated: true, completion: nil)
	}
	
	
}
