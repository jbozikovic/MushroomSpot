//
//  MushroomsViewController.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit
import Combine
import SnapKit

class MushroomsViewController: UIViewController, ViewControllerProtocol {
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: MushroomsViewModel
    var dataSource: MushroomsDataSource? {
        didSet {
            setTableViewDataSourceAndReload()
        }
    }
    
    init(viewModel: MushroomsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupGUI()
        setupViewModel()
        loadData()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    //  MARK: - Setup GUI
    func setupGUI() {
        title = AppStrings.mushrooms.localized
        setupNavigationBar()
        setupNavigationBarItems()
        setupBackground()
        setupRightBarButtonItems()
        setupTableView()
        setupConstraints()
    }
        
    //  MARK: - Table view (list)
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = AppUI.defaultBgColor
        tableView.separatorColor = AppUI.separatorColor
        tableView.delegate = self
        setupTableViewCell()
    }
    
    private func setupTableViewCell() {
        tableView.register(MushroomsCell.self, forCellReuseIdentifier: MushroomsCell.reuseIdentifier)
        tableView.estimatedRowHeight = MushroomsCell.estimatedHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
        
    private func setTableViewDataSourceAndReload() {
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    private func loadData() {
        dataSource = MushroomsDataSource(viewModel: viewModel)
    }
}

//  MARK: - Navigation bar item
private extension MushroomsViewController {
    private func setupRightBarButtonItems() {
        navigationItem.rightBarButtonItems = [Utility.createBarButtonItem(image: AppImages.user
            .image, target: self, action: #selector(barButtonItemTapped), identifier: "")]
    }
    
    @objc func barButtonItemTapped(sender: UIBarButtonItem) {
        viewModel.didTapProfileButton.send()
    }
}


//  MARK: - Constraints
private extension MushroomsViewController {
    func setupConstraints() {
        setupTableViewConstraints()
    }
        
    func setupTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}
    
//  MARK: - View model, callbacks
private extension MushroomsViewController {
    func setupViewModel() {
        handleLoadingStatusUpdated()
        handleFailurePublisher()
        handleShouldReloadDataPublisher()
    }

    func handleFailurePublisher() {
        viewModel.failure.sink { [weak self] (error) in
            guard let weakSelf = self else { return }
            weakSelf.handleError(error)
        }.store(in: &cancellables)
    }

    private func handleShouldReloadDataPublisher() {
        viewModel.shouldReloadData.sink { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.tableView.reloadData()
        }.store(in: &cancellables)
    }

    func handleLoadingStatusUpdated() {
        viewModel.loadingStatusUpdated.sink { [weak self] (isLoading) in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {                
                isLoading ? weakSelf.showActivityIndicator() : weakSelf.hideActivityIndicator()
            }
        }.store(in: &cancellables)
    }
}


//  MARK: - UITableViewDelegate
extension MushroomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.userSelectedRow(index: indexPath.row)
    }
}
