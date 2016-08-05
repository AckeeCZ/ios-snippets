// ----- <#name#> -----
let collectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
collectionView.delegate = self
collectionView.dataSource = self
<#superview#>.addSubview(collectionView)
collectionView.snp_makeConstraints { make in
    <#code#>
}
self.collectionView = collectionView