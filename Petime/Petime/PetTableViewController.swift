//
//  PetTableViewController.swift
//  Petime
//
//  Created by Pavel on 16/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class PetTableViewController: UITableViewController, CreatePetControllerDelegate, EditPetNameViewControllerDelegate {
	func editPetName(name: String) {
		let row = petName.index(of: name)
		let indexPath = IndexPath(row: row!, section: 0)
		tableView.reloadRows(at: [indexPath], with: .middle)
	}
	
	
	func createPetName(name: String) {
		petName.append(name)
		let indexPath = IndexPath(row: petName.count-1, section: 0)
		tableView.insertRows(at: [indexPath], with: .automatic)
	}
	
	let cellIndetifier = "cell"
	var petName = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Pets name"
//		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddPet))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIndetifier)
		tableView.backgroundColor = .darkBlueColor
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return petName.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath)
		cell.textLabel?.text = petName[indexPath.row]
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
		let editPetName = EditPetNameViewController()
		editPetName.petName = petName[indexPath.row]
		let navBar = CustomNavigationController(rootViewController: editPetName)
		present(navBar, animated: true, completion: nil)
	}
	
}
