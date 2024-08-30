//
//  UserDetailsViewController.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 30/08/2024.
//

import UIKit

final class UserDetailViewController: UIViewController {

    var user: User?

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(user?.name.first ?? "") \(user?.name.last ?? "")"
        setupImageView()
        setupTableView()
    }

    private func setupImageView() {
        // Add the image view to the view hierarchy
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.loadImage(from: user?.picture.large)

        // Set up constraints for the image view
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])

        // Style the image view
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
            return 11 // Number of sections for different data categories
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0

            switch indexPath.section {
            case 0:
                cell.textLabel?.text = user?.gender
            case 1:
                if let name = user?.name {
                    cell.textLabel?.text = "\(name.title) \(name.first) \(name.last)"
                }
            case 2:
                if let location = user?.location {
                    cell.textLabel?.text = "\(location.street.number) \(location.street.name), \(location.city), \(location.state), \(location.country)"
                }
            case 3:
                cell.textLabel?.text = user?.email
            case 4:
                cell.textLabel?.text = user?.phone
            case 5:
                cell.textLabel?.text = user?.nat
            case 6:
                if let coordinates = user?.location.coordinates {
                    cell.textLabel?.text = "Latitude: \(coordinates.latitude), Longitude: \(coordinates.longitude)"
                }
            case 7:
                if let timezone = user?.location.timezone {
                    cell.textLabel?.text = "Offset: \(timezone.offset), Description: \(timezone.description)"
                }
            case 8:
                if let login = user?.login {
                    cell.textLabel?.text = "Username: \(login.username), UUID: \(login.uuid)"
                }
            case 9:
                if let dob = user?.dob {
                    cell.textLabel?.text = "Date of Birth: \(dob.date), Age: \(dob.age)"
                }
            case 10:
                if let registered = user?.registered {
                    cell.textLabel?.text = "Registered on: \(registered.date), Age: \(registered.age)"
                }
            default:
                cell.textLabel?.text = ""
            }

            return cell
        }

        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section {
            case 0:
                return "Gender"
            case 1:
                return "Name"
            case 2:
                return "Location"
            case 3:
                return "Contact Info"
            case 4:
                return "Phone Numbers"
            case 5:
                return "Nationality"
            case 6:
                return "Coordinates"
            case 7:
                return "Timezone"
            case 8:
                return "Login Details"
            case 9:
                return "Date of Birth"
            case 10:
                return "Registration Details"
            default:
                return nil
            }
        }
}
