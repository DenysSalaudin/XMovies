//
//  ViewModel.swift
//  XMoviesProject
//
//  Created by Denis on 4/3/23.
//

import SwiftUI
import CoreData
@MainActor
class ViewModel: ObservableObject {
    
    let urlCache = URLCache.shared
    
    let container: NSPersistentContainer
    @Published var isSavedColor: Bool = false
    @Published var savedEntity: [MovieEntity] = []
    @Published var detailEntity: MovieEntity?
    
    init() {
        let memoryCapacity = 4 * 1024 * 1024 // 4MB
        let diskCapacity = 20 * 1024 * 1024 // 20MB
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: nil)
        URLCache.shared = urlCache
        container = NSPersistentContainer(name: "MovieContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfuly loaded coreData")
            }
        }
        fetchMovies()
    }
    
    func fetchMovies() {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        do {
            savedEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetching. \(error)")
        }
    }
 
        func deleteAll() {
              let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = MovieEntity.fetchRequest()
              let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
              _ = try? container.viewContext.execute(batchDeleteRequest1)
        }
    
    func addMovie(title:String?,id:UUID,voteAverage:Double?,name:String?,originalLanguage:String?,backdropPath:String?,posterPath:String?,overview:String?,releaseDate:String?,isSavedColor:Bool,genresIDS:Int) {
        let newMovie = MovieEntity(context: container.viewContext)
        newMovie.isSavedColor = isSavedColor
        newMovie.title = title
        newMovie.id = id
        newMovie.voteAverage = voteAverage ?? 0.0
        newMovie.name = name
        newMovie.originalLanguage = originalLanguage
        newMovie.backdropPath = backdropPath
        newMovie.posterPath = posterPath
        newMovie.overview = overview
        newMovie.releaseDate = releaseDate
        newMovie.genresIDS = Int64(genresIDS)
        saveData()
    }
    
    func deleteMovie(_ movie: MovieEntity) {
        print("StartDeleting")
        container.viewContext.delete(movie)
        saveData()
        print("FinishDeleting")
    }
    
    func saveData() {
        do {
           try container.viewContext.save()
            fetchMovies()
        } catch let error {
            print("ERROR saving. \(error)")
        }
    }
    
    @Published var tranding: [ResultTranding] = []
    @Published var detailTrangding: ResultTranding?
    
    @Published var upComing: [ResultUpComing] = []
    @Published var detailUpComing: ResultUpComing?
    
    @Published var popular: [ResultPopular] = []
    @Published var detailPopular: ResultPopular?
    
    @Published var nowPlaying: [ResultNowPlaying] = []
    @Published var detailNowPlaing: ResultNowPlaying?
    
    @Published var discover: [ResultDiscover] = []
    @Published var detailDiscover: ResultDiscover?
    
    @Published var searchMovies: [ResultSearch] = []
    @Published var detailSearch: ResultSearch?
    
    @Published var urlString: UIImage?
    @Published var movieName: String = ""
    
    @Published var isDismiss: Bool = false
    
    let apiKey = "API_Key"
    
    var currentPage : Int = 1
    
    func fetchTranding() async throws {
        let feedUrl = URL(string: "https://api.themoviedb.org/3/trending/all/week?api_key=\(apiKey)")!
        // Check cache
        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: feedUrl)) {
            let allData = try JSONDecoder().decode(Trending.self, from: cachedResponse.data)
            self.tranding = allData.results ?? []
            return
        }
        // Make network request
        let (data,response) = try await URLSession.shared.data(from: feedUrl)
        // Cache response
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: feedUrl))
        let allData = try JSONDecoder().decode(Trending.self, from: data)
        self.tranding = allData.results ?? []
        
    }
    
    func fetchUpComing() async throws {
        let feedUrl = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
        // Check cache
        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: feedUrl)) {
            let allData = try JSONDecoder().decode(UpComing.self, from: cachedResponse.data)
            self.upComing = allData.results ?? []
            return
        }
        // Make network request
        let (data,response) = try await URLSession.shared.data(from: feedUrl)
        // Cache response
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: feedUrl))
        let allData = try JSONDecoder().decode(UpComing.self, from: data)
        self.upComing = allData.results ?? []
    }
    
    func fetchPopular() async throws {
        let feedUrl = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)")!
        // Check cache
        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: feedUrl)) {
            let allData = try JSONDecoder().decode(Popular.self, from: cachedResponse.data)
            self.popular = allData.results ?? []
            return
        }
        // Make network request
        let (data,response) = try await URLSession.shared.data(from: feedUrl)
        // Cache response
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: feedUrl))
        let allData = try JSONDecoder().decode(Popular.self, from: data)
        self.popular = allData.results ?? []
    }
    
    func fetchNowPlaying() async throws {
        let feedUrl = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        // Check cache
        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: feedUrl)) {
            let allData = try JSONDecoder().decode(NowPlaying.self, from: cachedResponse.data)
            self.nowPlaying = allData.results ?? []
            return
        }
        // Make network request
        let (data,response) = try await URLSession.shared.data(from: feedUrl)
        // Cache response
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: feedUrl))
        let allData = try JSONDecoder().decode(NowPlaying.self, from: data)
        self.nowPlaying = allData.results ?? []
    }
    
    func fetchDiscover() async throws {
         let feedUrl = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&page=\(currentPage)")!
        // Check cache
        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: feedUrl)) {
            let allData = try JSONDecoder().decode(Discover.self, from: cachedResponse.data)
            self.discover = allData.results ?? []
            return
        }
        // Make network request
        let (data,response) = try await URLSession.shared.data(from: feedUrl)
        // Cache response
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: feedUrl))
        let allData = try JSONDecoder().decode(Discover.self, from: data)
        self.discover = allData.results ?? []
     }

    func fetchSearch() async throws {
       guard let feedUrl = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&page=1&include_adult=false&query=\(movieName)") else { return }
        let (data,_) = try await URLSession.shared.data(from: feedUrl)
        let allData = try JSONDecoder().decode(SearchMovie.self, from: data)
        self.searchMovies = allData.results ?? []
    }
    
    
    
}

