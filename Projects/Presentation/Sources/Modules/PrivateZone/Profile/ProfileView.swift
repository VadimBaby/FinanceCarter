//
//  ProfileView.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import SnapKit
import Common

protocol ProfileViewOutput: AnyObject {
    
}

protocol ProfileViewInput: AnyObject {
    var output: ProfileViewOutput? { get set }
}

final class ProfileView: UIViewController, ProfileViewInput {
    var output: ProfileViewOutput?
    
    private lazy var mainLabel = UILabel() &> {
        $0.text = Strings.Profile.systemTitle
        $0.font = .preferredFont(forTextStyle: .title1)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstaints()
    }
}

// MARK: - Private Methods

private extension ProfileView {
    func setupViews() {
        navigationItem.title = Strings.Profile.systemTitle
        view.backgroundColor = .systemBackground
        view.addSubviews(mainLabel)
    }
    
    func setupConstaints() {
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ProfileViewPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: ProfileModuleFactory.createMock()).asPreview()
    }
}
#endif
