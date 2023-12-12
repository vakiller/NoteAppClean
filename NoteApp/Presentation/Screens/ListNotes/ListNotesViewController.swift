//
//  ListNotesViewController.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import SnapKit

class ListNotesViewController: UIViewController {
    var viewModel: ListNotesViewModel
    let loadListNotes: PublishSubject<Void> = PublishSubject<Void>()
    let searchListNotes: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    // UI Properties
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleApp: BaseLabel = {
        let label = BaseLabel()
        label.setStyle(style: .largeTitleText)
        label.textColor = .black
        label.text = "Notein"
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.searchBarStyle = UISearchBar.Style.prominent
        view.placeholder = " Search..."
        view.sizeToFit()
        view.isTranslucent = false
        view.layer.cornerRadius = 3.0
       view.backgroundImage = UIImage()
        view.delegate = self
        return view
        }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .gray
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    override func viewDidLoad() {
        self.loadListNotes.onNext(())
        self.setupUi()
    }
    
    init(viewModel: ListNotesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUi() {
        
        self.view.addSubview(headerView)
        headerView.backgroundColor = .red
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64)
        }
        
        self.headerView.addSubview(titleApp)
        titleApp.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
        
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(self.headerView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListNotesViewController: Bindable {
    
    func bindViewModel() {
        let output = self.viewModel.transform(input: ListNotesViewModel.Input(loadListNotes: loadListNotes, searchListNotes: searchListNotes))
        output.listNotes
            .withUnretained(self)
            .subscribe(onNext: { owner, listNotes in
                print("Data \(listNotes)")
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
}

extension ListNotesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.searchText.send(searchText)
    }
}
