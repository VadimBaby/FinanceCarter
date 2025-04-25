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
import Domain

private struct Constants {
    static let padding = 10
}

final class WalletTitleCellView: UITableViewCell, Reusable {
    private lazy var walletTitle = UILabel()
    private lazy var walletBalance = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wallet: Wallet) {
        walletTitle.text = wallet.title
        walletBalance.text = NumbersFormatter.formatWithMinimalDecimals(wallet.balance)
    }
}

// MARK: - Private Methods

private extension WalletTitleCellView {
    func setupViews() {
        contentView.addSubviews(walletTitle, walletBalance)
    }
    
    func setupConstraints() {
        walletTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.padding)
            make.trailing.equalTo(walletBalance.snp.leading)
            make.centerY.equalToSuperview()
        }
        
        walletBalance.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.padding)
            make.centerY.equalToSuperview()
        }
    }
}
