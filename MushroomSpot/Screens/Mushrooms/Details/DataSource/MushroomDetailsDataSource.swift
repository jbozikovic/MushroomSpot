//
//  MushroomDetailsDataSource.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import UIKit

class MushroomDetailsDataSource: NSObject {
    private let viewModel: MushroomDetailsViewModel

    init(viewModel: MushroomDetailsViewModel) {
        self.viewModel = viewModel
    }
}


// MARK: - UITableViewDataSource
extension MushroomDetailsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CaptionValueCell.reuseIdentifier, for: indexPath) as! CaptionValueCell
        if let item: CaptionValueCellViewModel = viewModel.getItemAtIndex(indexPath.row) {
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

