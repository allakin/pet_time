//
//  PetTableViewController.swift
//  Petime
//
//  Created by Pavel on 16/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class PetTableViewController: UITableViewController {
	
	let cellIndetifier = "cell"
	let array = ["1", "1", "1", "1", "1", "1"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Pets name"
//		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddPet))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIndetifier)
		tableView.backgroundColor = .darkBlueColor
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return array.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath)
		cell.textLabel?.text = array[indexPath.row]
		cell.textLabel?.textColor = .white
		cell.backgroundColor = .darkBlueColor
		return cell
	}
	
	@objc func handleReset() {
		
	}
	
	@objc func handleAddPet() {
		let createPetController = CreatePetController()
		let navController = CustomNavigationController(rootViewController: createPetController)
		present(navController, animated: true, completion: nil)
	}
	
}
