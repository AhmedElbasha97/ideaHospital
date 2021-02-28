
import SDWebImage

protocol SearchResultCellViewModelProtocol {
    func downloadImage(with item: Item, completion: @escaping (UIImage?) -> Void)
}

class SearchResultCellViewModel {
    
}

//MARK:- MyFavoriteCell viewModel Protocol
extension SearchResultCellViewModel: SearchResultCellViewModelProtocol {
    func downloadImage(with item: Item, completion: @escaping (UIImage?) -> Void) {
        SDWebImageManager.shared.loadImage(with: URL(string: item.image), options: .highPriority, progress: nil) { (image, _, error, _, _, _) in
            if let error = error {
                print(error.localizedDescription)
            } else if let image = image {
                completion(image)
            }
        }
    }
}
