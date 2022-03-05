//
//  headerTableView.swift
//  SpacePeople
//
//  Created by Yegor Geronin on 04.03.2022.
//

import UIKit

class headerTableView: UIView {
    
    weak var superViewController: mainViewController?
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds     = true
        imageView.backgroundColor   = .red
        imageView.contentMode       = .scaleAspectFill
        return imageView
    }()
    private let blurView: UIVisualEffectView = {
        let blurView                = UIVisualEffectView()
        blurView.effect             = UIBlurEffect(style: .systemMaterial)
        return blurView
    }()
    
    init(frame: CGRect, label: String, view: mainViewController) {
        super.init(frame: frame)
        self.superViewController = view
        
        labelView.text = label
        
        addSubview(imageView)
        addSubview(blurView)
        addSubview(labelView)
        
        setSubviews()
    }
    
    private func setSubviews() {
        imageView.frame = bounds
        blurView.frame  = CGRect(x: 0,
                                 y: height * 0.5,
                                 width: width,
                                 height: height * 0.5)
        labelView.frame = CGRect(x: width * 0.1,
                                 y: height * 0.5,
                                 width: width * 0.8,
                                 height: height * 0.5)
        
        superViewController?.presenter.loadImageURL(query: labelView.text ?? "Not Found",
                                                    completion: { [weak self] image in
            guard image != nil else {
                return
            }
            self?.imageView.image = image
        })
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
