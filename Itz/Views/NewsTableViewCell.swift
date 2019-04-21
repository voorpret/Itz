
import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    var representedId: UUID?
    
    private let thumbnail = UIImageView()
    private let titleLabel = UILabel(style: .headline)
    private let descriptionLabel = UILabel(style: .body)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        thumbnail.contentMode = .scaleAspectFit
        
        titleLabel.numberOfLines = 0
        
        descriptionLabel.adjustsFontSizeToFitWidth = false
        descriptionLabel.numberOfLines = 2
        
        contentView.addSubview(thumbnail, constraints: [
            equal(\.topAnchor, constant: 8),
            equal(\.leftAnchor, constant: 16),
        ])
        (thumbnail.widthAnchor.constraint(equalToConstant: 104)).isActive = true
        (thumbnail.heightAnchor.constraint(equalToConstant: 80)).isActive = true
        
        contentView.addSubview(titleLabel, constraints: [
            equal(\.topAnchor, constant: 8),
            equal(\.rightAnchor, constant: -16),
        ])
        (titleLabel.leftAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 16)).isActive = true
        (titleLabel.heightAnchor.constraint(equalTo: thumbnail.heightAnchor)).isActive = true
        
        contentView.addSubview(descriptionLabel, constraints: [
            equal(\.leftAnchor, constant: 16),
            equal(\.rightAnchor, constant: -16),
            equal(\.bottomAnchor, constant: -8)
        ])
        (descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)).isActive = true
        (descriptionLabel.heightAnchor.constraint(equalToConstant: 72)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        representedId = nil
        
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    func bind(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    func bind(image: UIImage) {
        thumbnail.image = image
    }
    
    
}

