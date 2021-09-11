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
        table.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var emptyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Empty List"
        label.textColor = .red
        label.font = UIFont(name: "Helvetica", size: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.view.addSubview(table)
        self.view.addSubview(emptyLabel)
        emptyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        table.tableFooterView = UIView()
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
        self.reloadTable()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.updateCell(person: models[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = models[indexPath.row].source
        let vc = CNContactViewController(for: contact)
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    private func reloadTable() {
        if models.count > 0 {
            table.isHidden = false
            emptyLabel.isHidden = true
        }else{
            table.isHidden = true
            emptyLabel.isHidden = false
        }
        table.reloadData()
    }
}

