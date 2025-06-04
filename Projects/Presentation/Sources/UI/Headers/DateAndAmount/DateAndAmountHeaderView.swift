//
//  DateAndAmountHeaderView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 01.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import SnapKit
import Common

private struct Constants {
    static let padding = 10
    static let smallPadding = 5
}

final class DateAndAmountHeaderView: UIView {
    private var dateLabel = UILabel()
    private var amountLabel = UILabel()
    
    func configure(date: Date, amount: Double) {
        dateLabel.text = DateFomatter.toMonthAndDayString(from: date)
        amountLabel.text = NumbersFormatter.formatWithMinimalDecimals(amount) + .rubleSign
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Subviews

private extension DateAndAmountHeaderView {
    func setupViews() {
        backgroundColor = .tertiarySystemGroupedBackground
        addSubviews(dateLabel, amountLabel)
    }
    
    func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.smallPadding)
            make.leading.equalToSuperview().inset(Constants.padding)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.smallPadding)
            make.trailing.equalToSuperview().inset(Constants.padding)
        }
    }
}
