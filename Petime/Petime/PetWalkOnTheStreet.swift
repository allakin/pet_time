//
//  PetWalkOnTheStreet.swift
//  Petime
//
//  Created by Pavel on 23/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class PetWalkOnTheStreet: UITableViewController {
	
	var cellIndetifier = "cell"
	var date = [Date]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Pets Walk"
		view.backgroundColor = .darkBlueColor
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Walk", style: .plain, target: self, action: #selector(hanglerTimeToWalk))
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIndetifier)
	}
	
	@objc func hanglerTimeToWalk() {
		date.append(Date())
		tableView.reloadData()
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
		cell.textLabel?.text = "\(dateFormeter.string(from: date[indexPath.row]))"
//		tableView.reloadData()
		return cell
	}
}
