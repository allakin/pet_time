//
//  PetWalkOnTheStreet.swift
//  Petime
//
//  Created by Pavel on 23/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import CoreData

protocol PetWalkOnTheStreetDelegate {
	func addDateInTheTable(date:PetWalk)
}

class PetWalkOnTheStreet: UITableViewController {
	
	var cellIndetifier = "cell"
	var date = [PetWalk]()
	var petName = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = petName
		view.backgroundColor = .darkBlueColor
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Walk", style: .plain, target: self, action: #selector(hanglerTimeToWalk))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIndetifier)
		fetchTimeList()
		print(date.count)
	}
	
	@objc func hanglerTimeToWalk() {
		let tuple = CoreDataManager.shared.savePetWalkInCoreData(date: Date())
		fetchTimeList()
	}
	
	private func fetchTimeList() {
		let context = CoreDataManager.shared.persistentContainer.viewContext
		let fetch = NSFetchRequest<PetWalk>(entityName: "PetWalk")
		do {
			date = try context.fetch(fetch)
			tableView.reloadData()
		} catch let error {
			print(error)
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return date.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIndetifier, for: indexPath)
		cell.backgroundColor = .darkBlueColor
		cell.textLabel?.textColor = .white
		let dateFormeter = DateFormatter()
		dateFormeter.dateFormat = "MM dd, HH:mm:ss"
		cell.textLabel?.text = "\(dateFormeter.string(from: date[indexPath.row].date!))"
		//		tableView.reloadData()
		return cell
	}
}
