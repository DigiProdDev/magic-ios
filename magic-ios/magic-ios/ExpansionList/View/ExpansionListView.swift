//
//  ExpansionListView.swift
//  magic-ios
//
//  Created by  on /07/22.
//

import UIKit
import SnapKit

class ExpansionListViewController: UIViewController {
    
    // MARK: - Private variables
    
    var viewModel: ExpansionListViewModel
    
    // MARK: - UI Elements
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let expansionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Expansion"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {

        let uiTableView = UITableView(frame: .zero)
        uiTableView.backgroundColor = .clear
        uiTableView.translatesAutoresizingMaskIntoConstraints = false
        return uiTableView
    }()
    
    public init(viewModel: ExpansionListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cyclep
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        setupCollectionView()
        bindViewModel()
    }
    // MARK: - Helpers
    
    private func setupView() {
        view.backgroundColor = .darkGray
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        tableView.register(ExpansionListTableViewCell.self, forCellReuseIdentifier: ExpansionListTableViewCell.identifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func bindViewModel() {
        self.viewModel.delegate = self
        viewModel.getExpansionList()
    }
}

extension ExpansionListViewController: ExpansionListManager {
    func getCardsSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getCardsError() {
    }
}


extension ExpansionListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        to do
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ExpansionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpansionListTableViewCell.identifier, for: indexPath) as? ExpansionListTableViewCell else
        { return UITableViewCell() }
        
//        let section = viewModel.expansionListBySection[indexPath.section]
        
//        let index = section.index(section.startIndex, offsetBy: indexPath.row)
//        cell.configure(text: section[index])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cardNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.expansionListBySection[section].count
    }
}
