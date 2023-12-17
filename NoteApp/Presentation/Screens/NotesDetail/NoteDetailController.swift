//
//  NoteDetailController.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/13/23.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class NoteDetailController: UIViewController {
    
    var viewModel: NoteDetailViewModel
    
    var updateNoteCompleted: PublishSubject<NoteModel?> = PublishSubject<NoteModel?>()
    
    // UI Properties
    
    lazy var noteDetailHeader: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var headerActions: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .boldSystemFont(ofSize: 20)
        textField.text = "Welcome to Notein"
        textField.placeholder = "Note title here..."
        textField.borderStyle = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    lazy var editedLabel: BaseLabel = {
        let editedLabel = BaseLabel()
        editedLabel.setStyle(style: .caption)
        editedLabel.textColor = .gray
        editedLabel.text = "Adding new note"
        return editedLabel
    }()
    
    private lazy var iconNote: UIImageView = {
        let icon = UIImageView()
        icon.image = .init(systemName: "checkmark.circle.fill")
        icon.tintColor = .gray
        return icon
    }()
    
    lazy var noteInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var sperateLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray.withAlphaComponent(0.1)
        return line
    }()
    
    private lazy var noteTextView: UITextView = {
        let textView = UITextView()
        
        textView.layer.borderWidth = 0
        textView.font = .systemFont(ofSize: 18)
        
        return textView
    }()
    
    private lazy var dismissView: UIView = {
        let view = UIView()
        return view
        
    }()
    
    private lazy var saveNoteButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)
        configuration.image = UIImage(systemName: "checkmark")
        configuration.baseBackgroundColor = .systemBlue
        configuration.background.cornerRadius = 32
        configuration.cornerStyle = .fixed
        button.configuration = configuration
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    init(viewModel: NoteDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        self.setupUi()
        self.configData()
        
        let tapGesture = UITapGestureRecognizer()
        dismissView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { [weak self] recognizer in
            self?.titleTextField.resignFirstResponder()
            self?.noteTextView.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        self.viewModel.getNoteDetai()
        
    }
    
    deinit {
        print("\(self) deinited")
    }
    
    func setupUi() {
        self.view.backgroundColor = .white
        let buttonIconCircle = UIButton()
        buttonIconCircle.setImage(UIImage(systemName: "circle.circle.fill")?.withTintColor(.blue), for: .normal)
        
        let buttonPin = UIButton()
        buttonPin.setImage(UIImage(systemName: "pin")?.withTintColor(.gray), for: .normal)
        buttonPin.tintColor = .black
        
        let buttonOption = UIButton()
        buttonOption.setImage(UIImage(systemName: "ellipsis")?.withTintColor(.gray), for: .normal)
        buttonOption.tintColor = .black
        
        headerActions.addArrangedSubview(buttonIconCircle)
        headerActions.addArrangedSubview(buttonPin)
        headerActions.addArrangedSubview(buttonOption)
        
        self.view.addSubview(noteDetailHeader)
        
        noteDetailHeader.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        noteDetailHeader.addSubview(headerActions)
        
        headerActions.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(56)
        }
        
        self.view.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(noteDetailHeader.snp.bottom)
        }
        
        self.view.addSubview(noteInfoStackView)
        
        noteInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        noteInfoStackView.addArrangedSubview(editedLabel)
        noteInfoStackView.addArrangedSubview(iconNote)
        
        iconNote.snp.makeConstraints { make in
            make.height.width.equalTo(16)
        }
        
        self.view.addSubview(sperateLine)
        
        sperateLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(noteInfoStackView.snp.bottom).offset(16)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        self.view.addSubview(noteTextView)
        
        noteTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(sperateLine.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
        
        self.view.addSubview(dismissView)
        
        dismissView.snp.makeConstraints { make in
            make.bottom.equalTo(noteTextView.snp.top)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.view.bringSubviewToFront(titleTextField)
        
        saveNoteButton.tintColor = .white
        saveNoteButton.backgroundColor = .systemBlue
        saveNoteButton.layer.cornerRadius = 32
        
        self.view.addSubview(saveNoteButton)
        saveNoteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-32)
            make.height.width.equalTo(64)
        }
    }
    
    private func configData() {
        
    }
    
}

extension NoteDetailController: Bindable {
    
    func bindViewModel() {
     
        self.viewModel.output.noteDetail
            .withUnretained(self)
            .subscribe(onNext: { owner, noteData in
                owner.titleTextField.text = noteData?.title
                owner.noteTextView.text = noteData?.content
                owner.editedLabel.text = "Edited: \(noteData?.lastUpdate?.convertToString(formated: .ddMMyyyyAthhmma) ?? "Adding new note")"
            })
            .disposed(by: self.viewModel.disposeBag)

        self.viewModel.output.updateNoteCompleted.bind(to: updateNoteCompleted)
            .disposed(by: self.viewModel.disposeBag)
        
        let inputCombineData = Observable.combineLatest(self.titleTextField.rx.text, self.noteTextView.rx.text)

        self.saveNoteButton.rx.tap.withLatestFrom(inputCombineData)
            .map({ [weak self] titleString, contentString in
                self?.viewModel.addOrUpdateNote(title: titleString, content: contentString)
            })
            .subscribe()
            .disposed(by: self.viewModel.disposeBag)
        
    }
    
}
