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

protocol HomeHeaderViewInput: AnyObject {
    var output: HomeHeaderViewOutput? { get set }
    
    func updateUserName(_ name: String)
}

protocol HomeHeaderViewOutput: AnyObject {
    func viewDidConfigure()
}

final class HomeHeaderViewCell: UICollectionViewCell, Reusable, HomeHeaderViewInput {
    var output: HomeHeaderViewOutput?
    
    private lazy var nameLabel = UILabel() &> {
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
    
    func configure(with presenter: HomeHeaderViewOutput) {
        self.output = presenter
        output?.viewDidConfigure()
    }
    
    func updateUserName(_ name: String) {
        nameLabel.text = "Привет " + name
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
