import UIKit

struct IntroExperienceModel: Codable {
    var imageTitle: String
    var title: String
    var description: String
}

class IntroExperienceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    func configure(with model: IntroExperienceModel) {
        imageView.image = UIImage(named: model.imageTitle)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
