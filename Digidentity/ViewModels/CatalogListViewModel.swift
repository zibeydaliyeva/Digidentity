//
//  CatalogListViewModel.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 16.11.21.
//

import Foundation

class CatalogListViewModel {
    
    typealias Response = (ErrorService?) -> Void
    
    private var service: APIServiceProtocol!
    
    private var catalogList: [CatalogItem] = []
    
    private var isFetchingData = false
    
    private lazy var cacher: Cacher = {
        return Cacher(fileName: "cached_catalog")
    }()
    
    var catalogCount: Int {
        return catalogList.count
    }
    
    var newDataCount: Int = 0
    
    init(_ service: APIServiceProtocol = APIService()) {
        self.service = service
    }
    
    func initialLoad(completion: @escaping Response) {
        readFromCache()
        if catalogList.isEmpty {
            self.loadNewerCatalog(completion: completion)
        } else {
            completion(.none)
        }
    }
    
    func loadNewerCatalog(completion: @escaping Response) {
        let params = CatalogParams(sinceId: catalogList.first?.id)
        getCatalogs(params: params, completion: completion)
    }
    
    func loadOlderCatalog(completion: @escaping Response) {
        let params = CatalogParams(maxId: catalogList.last?.id)
        getCatalogs(params: params, completion: completion)
    }
    
    private func getCatalogs(params: CatalogParams, completion: @escaping Response) {
        guard !isFetchingData else { return }
        isFetchingData = true
        
        service.getCatalogs(params: params) { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.handleSuccess( data: data, params: params)
                completion(.none)
            case .failure(let error):
                completion(error)
            }
            self.isFetchingData = false
        }
    }
    
    private func handleSuccess(data: [CatalogItem]?, params: CatalogParams) {
        guard let data = data  else { return }
        self.newDataCount = data.count
        if params.maxId != nil {
            self.catalogList.append(contentsOf: data)
        } else {
            let orderedData = data.count < 10 ? data.reversed() :data
            self.catalogList.insert(contentsOf: orderedData, at: 0)
            self.saveInCache()
        }
    }
    
    func getCatalog(at index: Int) -> CatalogCellViewModel? {
        guard catalogCount > index else { return nil }
        let item = catalogList[index]
        return CatalogCellViewModel(catalog: item)
    }
    
    private func saveInCache() {
        let items = catalogList[0..<newDataCount]
        cacher.persist(items: Array(items))
    }
    
    private func readFromCache() {
        let items: [CatalogItem]? = cacher.load()
        guard let items = items else { return }
        self.catalogList = items
    }

}
