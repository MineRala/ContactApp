//
//  ViewController.swift
//  ContactApp
//
//  Created by Mine Rala on 11.09.2021.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate,UITableViewDataSource,UITableViewDelegate {
    var models: [Person] = []

    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero)
        table.frame = view.bounds
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.view.addSubview(table)

    }

    @objc func addButtonTapped(){
        let vc = CNContactPickerViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = contact.givenName + " " + contact.familyName
        let identifier = contact.identifier
        let model = Person(name: name, id: identifier, source: contact)
        models.append(model)
        table.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = models[indexPath.row].source
        let vc = CNContactViewController(for: contact)
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)

    }

}

