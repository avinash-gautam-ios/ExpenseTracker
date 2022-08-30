//
//  RadioButtonOptionView.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import Foundation
import UIKit

protocol RadioButtonOptionViewDelegate: AnyObject {
    func didTapRadioButtonOption(_ view: RadioButtonOptionView, withOption option: RadioButtonOption)
}


final class RadioButtonOptionView: UIView {
    
    private let radioImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = Theme.Font.descriptionFont
        label.textAlignment = .left
        label.textColor = Theme.Color.descriptionColor
        return label
    }()
    
    private let touchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.Color.clearButton
        return button
    }()
    
    private let selectionImage: UIImage
    private let deselectionImage: UIImage
    private let option: RadioButtonOption
    private(set) var isSelected: Bool
    
    weak var delegate: RadioButtonOptionViewDelegate?
    
    init(selectionImage: UIImage,
         deselectionImage: UIImage,
         option: RadioButtonOption,
         isSelected: Bool = false) {
        self.selectionImage = selectionImage
        self.deselectionImage = deselectionImage
        self.option = option
        self.isSelected = isSelected
        
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(radioImageView)
        NSLayoutConstraint.activate([
            radioImageView.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Padding.padding5),
            radioImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Padding.padding5),
            radioImageView.heightAnchor.constraint(equalToConstant: Theme.IconSize.medium),
            radioImageView.widthAnchor.constraint(equalToConstant: Theme.IconSize.medium)
        ])
        
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Padding.padding5),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.Padding.padding5),
            descriptionLabel.leadingAnchor.constraint(equalTo: radioImageView.trailingAnchor, constant: Theme.Padding.padding10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.Padding.padding5)
        ])
     
        addSubview(touchButton)
        touchButton.addTarget(self, action: #selector(touchButtonDidTap), for: .touchUpInside)
        NSLayoutConstraint.activate([
            touchButton.topAnchor.constraint(equalTo: topAnchor),
            touchButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            touchButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            touchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        /// fill in data
        radioImageView.image = isSelected ? selectionImage : deselectionImage
        descriptionLabel.text = option.value
    }
    
    @objc private func touchButtonDidTap() {
        delegate?.didTapRadioButtonOption(self, withOption: option)
    }
    
    func setSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
        radioImageView.image = isSelected ? selectionImage : deselectionImage
    }
}
