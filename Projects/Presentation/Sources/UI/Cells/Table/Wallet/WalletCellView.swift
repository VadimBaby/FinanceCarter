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
import MyCommon
import Domain

final class WalletCellView: UITableViewCell, Reusable {
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
    
    func configure(with wallet: WalletEntity) {
        walletTitle.text = wallet.title
        walletBalance.text = NumbersFormatter.formatWithMinimalDecimals(wallet.balance).appendRubleSign()
    }
}

// MARK: - Private Methods

private extension WalletCellView {
    func setupViews() {
        contentView.addSubviews(walletTitle, walletBalance)
    }
    
    func setupConstraints() {
        walletTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(AppConstants.innerPadding)
            make.centerY.equalToSuperview()
        }
        
        walletBalance.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(AppConstants.innerPadding)
            make.centerY.equalToSuperview()
        }
    }
}
