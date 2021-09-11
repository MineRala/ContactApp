//
//  TableCell.swift
//  ContactApp
//
//  Created by Mine Rala on 11.09.2021.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0.1405182679, alpha: 1)
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        self.contentView.addSubview(label)
        label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
    }

    func updateCell(person: Person){
        label.text = person.name
    }
}
