//
//  SeacrhPlaceHolder.swift
//  DCA Financial Stock App
//
//  Created by mac on 9/10/21.
//

import UIKit

class SearchPlaceHolder: UIView {
    
        private let imageView: UIImageView = {
        let image = UIImage(named: "imDca")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
   }()
    
    private let titleLabel: UILabel = {
    let label = UILabel()
        label.text = "Search for companies to calculate potential returns via dollar cost averaging."
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        
        let stackview = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackview.axis = .vertical
        stackview.spacing = 24
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() { // need to add the stackView as part of the subview
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 88)
            //this means that the stackview will be 80% of the parent SeacrhPlaceHolder view
        
        ]) // set auto layout
    }
    
    
    
}
