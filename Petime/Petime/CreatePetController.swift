//
//  CreatePetController.swift
//  Petime
//
//  Created by Pavel on 16/07/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class CreatePetController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Create Pet"
		view.backgroundColor = .darkBlueColor
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(hangleSave))
	}
	
	@objc func hangleSave() {
		dismiss(animated: true, completion: nil)
	}
	
}
