//
//  NoteTableViewCell.swift
//  NoteApp
//
//  Created by Le Mai Viet Anh on 12/12/23.
//

import Foundation
import UIKit
import SnapKit

final class NoteTableViewCell: UITableViewCell, ReuseableCell {
    
    private lazy var bodyView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var colorHeaderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleNote: BaseLabel = {
        let label = BaseLabel()
        label.textColor = .black
        label.setStyle(style: .titleText)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var dateTitle: UILabel = {
        let label = BaseLabel()
        label.textColor = .gray
        label.setStyle(style: .caption)
        return label
    }()
    
    private lazy var iconNote: UIImageView = {
        let icon = UIImageView()
        icon.image = .init(systemName: "checkmark.circle.fill")
        icon.tintColor = .gray
        return icon
    }()
    
    private var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    private var bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.selectionStyle = .none
        self.contentView.addSubview(bodyView)
        
        bodyView.addSubview(colorHeaderView)
        bodyView.addSubview(bodyStackView)
        
        bodyView.layer.masksToBounds = true
        bodyView.layer.cornerRadius = 3
        bodyView.snp.makeConstraints { make in
            make.leading.top.equalTo(8)
            make.trailing.bottom.equalTo(-8)
        }
        
        colorHeaderView.clipsToBounds = true
        colorHeaderView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(6)
        }
        
        colorHeaderView.backgroundColor = .green
        
        bodyStackView.snp.makeConstraints { make in
            make.leading.equalTo(colorHeaderView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-18)
            make.top.bottom.equalToSuperview()
        }
        
        // setup stack view content
        contentStackView.addArrangedSubview(titleNote)
        contentStackView.addArrangedSubview(dateTitle)
        // setup stack view body
        
        bodyStackView.addArrangedSubview(contentStackView)
        bodyStackView.addArrangedSubview(iconNote)
        
        iconNote.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        
        
    }
    
    public func setData(noteModel: NoteModel?) {
        
        guard let noteModel else {
            return
        }
        
        self.titleNote.text = noteModel.content
        self.dateTitle.text = noteModel.lastUpdate?.convertToString(formated: .ddMMyyyySpaceHyphenhhmma)
        
        let colorGenerated = String(noteModel.content?.prefix(10) ?? "").color()
        let backgroundColor = colorGenerated.withAlphaComponent(0.1)
        
        self.colorHeaderView.backgroundColor = colorGenerated
        self.bodyView.backgroundColor = backgroundColor
        
    }
    
}
