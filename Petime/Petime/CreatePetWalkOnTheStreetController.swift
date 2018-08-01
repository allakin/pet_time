//
//  CreatePetWalkOnTheStreetController.swift
//  Petime
//
//  Created by Pavel on 29/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

protocol CreatePetWalkOnTheStreetControllerDelegate {
	func addNewCell(petWalk: PetWalk)
}

class CreatePetWalkOnTheStreetController: UIViewController {
	
	var pet : PetName?
	var delegate: CreatePetWalkOnTheStreetControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Add Walk Time"
		view.backgroundColor = .darkBlueColor
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(hangleCancel))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(hangleSave))
		setupUI()
	}
	
	@objc func hangleCancel() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func hangleSave() {
		guard let pet = self.pet else {return}
		let tuple = CoreDataManager.shared.savePetWalkInCoreData(date: Date(), pet: pet)
		if let error = tuple.1 {
			print(error)
		} else {
			dismiss(animated: true) {
				self.delegate?.addNewCell(petWalk: tuple.0!)
			}
		}
	}
	
	private func setupUI() {
		let backgroundView = UIView()
		backgroundView.backgroundColor = .lightBlue
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(backgroundView)
		backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		backgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
}
