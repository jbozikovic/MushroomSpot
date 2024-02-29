//
//  MushroomsDataSource.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit

class MushroomsDataSource: NSObject {
    private let viewModel: MushroomsViewModel

    init(viewModel: MushroomsViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource
extension MushroomsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MushroomsCell.reuseIdentifier, for: indexPath) as! MushroomsCell
        if let item: MushroomCellViewModel = viewModel.getItemAtIndex(indexPath.row) {
            cell.configure(item)
        }
        return cell
    }
                
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
}
