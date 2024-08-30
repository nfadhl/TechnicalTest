//
//  UsersListViewController.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 30/08/2024.
//

import Foundation
import UIKit
import Combine

final class UsersListViewController: UIViewController {
    
    private var viewModel = UsersListViewModel()
    private let refreshControl = UIRefreshControl()
    private var subscriptions = Set<AnyCancellable>()
    
    private let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setViews()
        setUpdateBinding()
    }
    
    // Sets up a binding to observe changes in the updateResult
    @MainActor private func setUpdateBinding() {
        viewModel.usersUpdated.sink { [weak self] value in
            if value {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                self?.tableView.isHidden = false
                self?.errorLabel.isHidden = true
            } else {
                self?.errorLabel.isHidden = false
                self?.tableView.isHidden = true
                self?.errorLabel.text = self?.viewModel.errorMessage
            }
        }.store(in: &subscriptions)
    }
}

// MARK: - Fonctions pour la gestion des vues
extension UsersListViewController {
    
    private func setupNavigationBar() {
        title = "Users"
        
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .orange
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar.tintColor = UIColor.white
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        
        navigationItem.titleView = {
            let titleLabel = UILabel()
            titleLabel.text = "Users"
            titleLabel.textColor = .white
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            return titleLabel
        }()
    }
    
    private func setViews() {
        
        errorLabel.textAlignment = .center
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true // Initially hidden
        view.addSubview(errorLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        
        // Set up constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Set up the refresh control
        refreshControl.addTarget(self, action: #selector(refreshUsers), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    
    @objc private func refreshUsers() {
        refreshControl.beginRefreshing()
        viewModel.refreshUsers()
        refreshControl.endRefreshing()
    }
}

// MARK: - Fonctions de la source de données pour le TableView
extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in your table
        return viewModel.usersViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UserTableViewCell {
            
            let userViewModel: UserViewModel = viewModel.usersViewModel[indexPath.row]
            
            // Configure the cell with your data
            cell.configureCell(userViewModel: userViewModel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension UsersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == viewModel.usersViewModel.count - 1 { // Last cell
                viewModel.fetchUsers()
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailVC = UserDetailViewController()
        let selectedUser = viewModel.usersViewModel[indexPath.row].user
        userDetailVC.user = selectedUser
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

