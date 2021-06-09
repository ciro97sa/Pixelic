import UIKit

extension Workspace : UICollectionViewDataSource {
    public func collectionView(_ collectionView : UICollectionView , cellForItemAt indexPath : IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier : "cell", for : indexPath) as! collectionViewCell
        //Background
        cell.backgroundColor = theme.mainColor
        //tapMe Label
        cell.tapMeLabel.textColor = theme.accentColor
        cell.tapMeLabel.text = "Tap me!"
        //text Label
        cell.textLabel.textColor = theme.accentColor
        cell.textLabel.text = arrayOfIcons[indexPath.row]
        //ImageView
        cell.imageView.image = UIImage(named : arrayOfIcons[indexPath.row])
        
        return cell
    }
    
    public func collectionView(_ collectionView : UICollectionView , numberOfItemsInSection section : Int) -> Int{
        return arrayOfIcons.count
    }
}

extension Workspace : UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView : UICollectionView , layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath : IndexPath) -> CGSize {
        //collection size
        return CGSize(width: 110, height : 110)
    }

}


