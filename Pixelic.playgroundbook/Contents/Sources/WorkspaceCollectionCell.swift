import UIKit

public class collectionViewCell : UICollectionViewCell {
    
    public var imageView: UIImageView
    public var textLabel : UILabel
    public var tapMeLabel : UILabel
    
    // init
    public override init(frame: CGRect) {
        
        //Origin point
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        textLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height, width: frame.size.width, height: frame.size.height/3))
        tapMeLabel = UILabel(frame : CGRect( x:0 , y : 0 , width : frame.size.width, height : frame.size.height))
        super.init(frame: frame)
        
        //Sizes
        textLabel.font = UIFont.systemFont(ofSize:16)
        tapMeLabel.font = UIFont.boldSystemFont(ofSize : 18)
        
        //Alignments
        textLabel.textAlignment = .center
        tapMeLabel.textAlignment = .center
        
        //imageView
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        contentView.addSubview(imageView)
        contentView.addSubview(tapMeLabel)
        contentView.addSubview(textLabel)
        
        textLabel.isHidden = true
        imageView.isHidden = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override var isSelected : Bool {
        didSet {
            if self.isSelected {
                self.imageView.isHidden = false
                self.textLabel.isHidden = false
                self.tapMeLabel.isHidden = true
            } else {
                self.imageView.isHidden = true
                self.textLabel.isHidden = true
                self.tapMeLabel.isHidden = false
                
            }
        }
    }
}

