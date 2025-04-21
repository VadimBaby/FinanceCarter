//
//  WalletTitleCellView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import Common

private struct Constants {
    static let padding = 10
}

final class WalletTitleCellView: UITableViewCell, Reusable {
    private lazy var walletTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        walletTitle.text = title
    }
}

// MARK: - Private Methods

private extension WalletTitleCellView {
    func setupViews() {
        contentView.addSubview(walletTitle)
    }
    
    func setupConstraints() {
        walletTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.padding)
            make.trailing.equalToSuperview()
        }
    }
}
