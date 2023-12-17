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
import RxSwiftExt
import RxCocoa
import SnapKit

class ListNotesViewController: UIViewController {
    var viewModel: ListNotesViewModel
    
    let goToNoteDetail: PublishSubject<NoteModel?> = PublishSubject<NoteModel?>()
    
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
    
    private lazy var actionHeaderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var iconApp: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "header_icon")
        return imageView
    }()
    
    private lazy var buttonSortByDate: UIButton = {
        let button = UIButton()
        button.setImage(SortValue.asc.getImageButton(), for: .normal)
        button.tintColor = .black
        return button
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
        tableView.keyboardDismissMode = .onDrag
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var addNoteButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        configuration.image = UIImage(systemName: "pencil.line")
        configuration.baseBackgroundColor = .systemBlue
        configuration.background.cornerRadius = 32
        configuration.cornerStyle = .fixed
        button.configuration = configuration
        return button
    }()
    
    override func viewDidLoad() {
        self.setupUi()
        self.viewModel.startRequestGetListNotes()
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
        
        self.actionHeaderStackView.addArrangedSubview(iconApp)
        self.actionHeaderStackView.addArrangedSubview(buttonSortByDate)
        
        iconApp.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        buttonSortByDate.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        self.headerView.addSubview(self.actionHeaderStackView)
        
        self.actionHeaderStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
        
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(self.headerView.snp.bottom)
        }
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        addNoteButton.tintColor = .white
        addNoteButton.backgroundColor = .systemBlue
        addNoteButton.layer.cornerRadius = 32
        
        self.view.addSubview(addNoteButton)
        addNoteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-32)
            make.height.width.equalTo(64)
        }
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTap(sender:)))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
        
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        self.searchBar.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListNotesViewController: Bindable {
    
    func bindViewModel() {
        
        self.addNoteButton.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.goToNoteDetail.onNext(nil)
        })
        .disposed(by: self.viewModel.disposeBag)
        
        self.buttonSortByDate.rx.tap
            .withUnretained(self)
            .subscribe { ( owner, _) in
                let sortValueNow = owner.viewModel.input.sortByDate.value
                if sortValueNow == .asc {
                    owner.viewModel.sortByDate.accept(.des)
                } else {
                    owner.viewModel.sortByDate.accept(.asc)
                }
                owner.buttonSortByDate.setImage(sortValueNow.getImageButton(), for: .normal)
                
                
            }
            .disposed(by: self.viewModel.disposeBag)
        
        self.searchBar.rx.text.bind(to: self.viewModel.searchListNotes)
            .disposed(by: self.viewModel.disposeBag)
        
        self.viewModel.output.listNotes
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: self.viewModel.disposeBag)
    }
    
}

extension ListNotesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}

extension ListNotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.output.listNotes.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        print("SELECTED INDEX \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteDataInCell = self.viewModel.output.listNotes.value?[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifier, for: indexPath) as? NoteTableViewCell {
            cell.setData(noteModel: noteDataInCell)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.viewModel.isHasLoadMore.value == false {
            return
        }
        guard let count = self.viewModel.output.listNotes.value?.count else {
            return
        }

        guard indexPath.row == count - 1 else {
            return
        }
        self.viewModel.input.loadMore.onNext(())
            
        
    }
    
}

extension SortValue {
    func getImageButton() -> UIImage? {
        switch self {
        case .asc:
            return UIImage(named: "sort_asc")
        case .des:
            return UIImage(named: "sort_des")
        }
    }
}
