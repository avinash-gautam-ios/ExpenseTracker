//
//  RadioButtonView.swift
//  ExpenseTracker
//
//  Created by Avinash on 29/08/22.
//

import UIKit

/**
 * Radio button option, describing the value for each radio item
 */

struct RadioButtonOption {
    let value: String
}

extension RadioButtonOption: Equatable { }

extension RadioButtonOption: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value: value)
    }
}


/**
 *`RadioButtonLayout` describes the radio button layout
 * For radio button options more than 2, the layout is automatically set to vertical
 * This is done because there is limited width on mobile devices
 */

enum RadioButtonLayout {
    case horizontal, vertical
}


protocol RadioButtonViewDelegate: AnyObject {
    func didFinishSelectingRadioOption(_ view: RadioButtonView,
                                       option: RadioButtonOption,
                                       optionIndex: Int)
}


final class RadioButtonView: UIView {
    
    private enum Constants {
        static let defaultOptionSelectedIndex: Int = -1
        static let defaultLayout: RadioButtonLayout = .vertical
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = Theme.Font.titleFont
        label.textAlignment = .left
        label.textColor = Theme.Color.descriptionColor
        return label
    }()
    
    private let title: String
    private let options: [RadioButtonOption]
    private let layout: RadioButtonLayout
    private let selectionImage: UIImage
    private let deselectionImage: UIImage
    private var selectedIndexOption: Int
    private var optionViews: [RadioButtonOptionView] = []
    
    weak var delegate: RadioButtonViewDelegate?
    
    init(title: String,
         selectionImage: UIImage,
         deselectionImage: UIImage,
         options: [RadioButtonOption],
         layout: RadioButtonLayout = Constants.defaultLayout,
         defaultSelectedOptionIndex: Int = Constants.defaultOptionSelectedIndex) {
        self.title = title
        self.selectionImage = selectionImage
        self.deselectionImage = deselectionImage
        self.options = options
        self.layout = layout
        self.selectedIndexOption = defaultSelectedOptionIndex
        
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        /// add label
        addSubview(titleLabel)
        titleLabel.text = title
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Padding.padding10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Padding.padding5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.Padding.padding5)
        ])
        
        /// add options
        
        if (options.count < 2) {
            fatalError("RadioButtonView: You are trying to create a radio button options for less than 2 options, please check if this is correct or this is what you want")
        }
        
        /// if excatly 2 options, render based on layout set
        if (options.count == 2) {
            switch layout {
            case .horizontal:
                configureUIForHorizontalLayout(option1: options[0],
                                               option2: options[1])
            case .vertical:
                configureUIForVerticalLayout()
            }
        } else {
            /// always render vertically
            configureUIForVerticalLayout()
        }
    }
    
    /// it is expected that this function receives 2 values only as
    ///
    private func configureUIForHorizontalLayout(option1: RadioButtonOption,
                                                option2: RadioButtonOption) {
        let isSelected1 = (selectedIndexOption == 0)
        let optionView1 = RadioButtonOptionView(selectionImage: selectionImage,
                                                deselectionImage: deselectionImage,
                                                option: option1,
                                                isSelected: isSelected1)
        optionView1.translatesAutoresizingMaskIntoConstraints = false
        optionView1.delegate = self
        
        let width = (UIScreen.main.bounds.width * 0.5) - (2 * Theme.Padding.padding5) - Theme.Padding.padding5
        
        addSubview(optionView1)
        NSLayoutConstraint.activate([
            optionView1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Theme.Padding.padding5),
            optionView1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.Padding.padding5),
            optionView1.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -Theme.Padding.padding5),
            optionView1.widthAnchor.constraint(equalToConstant: width)
        ])
        
        let isSelected2 = (selectedIndexOption == 1)
        let optionView2 = RadioButtonOptionView(selectionImage: selectionImage,
                                                deselectionImage: deselectionImage,
                                                option: option2,
                                                isSelected: isSelected2)
        optionView2.translatesAutoresizingMaskIntoConstraints = false
        optionView2.delegate = self
        
        addSubview(optionView2)
        NSLayoutConstraint.activate([
            optionView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Theme.Padding.padding5),
            optionView2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.Padding.padding5),
            optionView2.leadingAnchor.constraint(equalTo: optionView1.trailingAnchor, constant: Theme.Padding.padding5),
            optionView2.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -Theme.Padding.padding5),
            optionView1.widthAnchor.constraint(equalToConstant: width)
        ])
        
        optionViews = [optionView1, optionView2]
    }
    
    
    private func configureUIForVerticalLayout() {
        
    }
}

extension RadioButtonView: RadioButtonOptionViewDelegate {
    func didTapRadioButtonOption(_ view: RadioButtonOptionView,
                                 withOption option: RadioButtonOption) {
        /// deselect all the options
        optionViews.forEach({ $0.setSelected(false) })
        /// select the one which is selected
        view.setSelected(true)
        /// compute and update the index
        if let index = options.firstIndex(where: { $0 == option }) {
            selectedIndexOption = index
            delegate?.didFinishSelectingRadioOption(self,
                                                    option: option,
                                                    optionIndex: index)
        }
    }
}

