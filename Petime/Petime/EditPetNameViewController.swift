//
//  EditPetNameViewController.swift
//  Petime
//
//  Created by Pavel on 18/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

protocol EditPetNameViewControllerDelegate {
	func editPetName(name: String)
}

class EditPetNameViewController: UIViewController {
	
	var petName = ""
	var delegate : EditPetNameViewControllerDelegate?
	
	let namePetLabel: UILabel = {
		let label = UILabel()
		label.text = "Pet Name"
		label.textColor = .darkPurpleColor
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let namePetTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Enter your pet name"
		textField.textAlignment = .left
		textField.textColor = .darkPurpleColor
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		namePetTextField.text = petName
		navigationItem.title = "Edit Pet Name"
		view.backgroundColor = .darkBlueColor
		setupUI()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(hangleEdit))
	}
	
	@objc func hangleEdit() {
		dismiss(animated: true) {
			guard let name = self.namePetTextField.text else {return}
			self.delegate?.editPetName(name: name)
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
		backgroundView.heightAnchor.constraint(equalToConstant: 250).isActive = true
		view.addSubview(namePetLabel)
		namePetLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
		namePetLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 16).isActive = true
		namePetLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
		namePetLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
		view.addSubview(namePetTextField)
		namePetTextField.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
		namePetTextField.leftAnchor.constraint(equalTo: namePetLabel.rightAnchor).isActive = true
		namePetTextField.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -16).isActive = true
		namePetTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}

	
}
