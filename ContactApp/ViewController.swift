//
//  ViewController.swift
//  ContactApp
//
//  Created by Mine Rala on 11.09.2021.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }

    @objc func addButtonTapped(){
        
    }


}

