//
//  MushroomDetailsViewController.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit
import Combine
import SnapKit

class MushroomDetailsViewController: UIViewController, ViewControllerProtocol {
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
        
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: MushroomDetailsViewModel
    var dataSource: MushroomDetailsDataSource? {
        didSet {
            setTableViewDataSourceAndReload()
        }
    }

    init(viewModel: MushroomDetailsViewModel) {
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
        title = AppStrings.details.localized
        setupNavigationBar()
        setupNavigationBarItems()
        setupBackground()
        setupTableView()
        setupConstraints()
    }

    //  MARK: - Table view (list)
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear//AppUI.defaultBgColor
        tableView.delegate = self
        setupTableViewCell()
        setupTableViewHeader()
    }

    private func setupTableViewCell() {
        tableView.register(CaptionValueCell.self, forCellReuseIdentifier: CaptionValueCell.reuseIdentifier)
        tableView.estimatedRowHeight = CaptionValueCell.estimatedHeight
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupTableViewHeader() {
        tableView.register(MushroomDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: MushroomDetailsHeaderView.reuseIdentifier)
        tableView.estimatedSectionHeaderHeight = MushroomDetailsHeaderView.estimatedHeight
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
        
    private func setTableViewDataSourceAndReload() {
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    private func loadData() {
        self.dataSource = MushroomDetailsDataSource(viewModel: viewModel)
    }
}


//  MARK: - Constraints
private extension MushroomDetailsViewController {
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
private extension MushroomDetailsViewController {
    func setupViewModel() {
        handleShouldReloadDataPublisher()
    }
    
    private func handleShouldReloadDataPublisher() {
        viewModel.shouldReloadData.sink { [weak self] in
            guard let weakSelf = self else { return }            
            weakSelf.tableView.reloadData()
            weakSelf.tableView.isHidden = false
        }.store(in: &cancellables)
    }
}


//  MARK: - UITableViewDelegate
extension MushroomDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MushroomDetailsHeaderView.reuseIdentifier) as? MushroomDetailsHeaderView else { return nil }
        if let vm = viewModel.headerViewModel {
            headerView.configure(vm)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension // EmployeeDetailsHeaderView.estimatedHeight
    }
}



