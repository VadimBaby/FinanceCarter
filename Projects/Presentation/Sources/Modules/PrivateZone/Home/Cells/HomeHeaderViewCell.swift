//
//  HomeHeaderViewCell.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import SnapKit
import Reusable
import Common

final class HomeHeaderViewCell: UICollectionViewCell, Reusable {
    private lazy var nameLabel = UILabel() &> {
        $0.text = "Я Заголовок"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeHeaderViewCell {
    func setupViews() {
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraits() {
        nameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
    }
}
