import Foundation
import SwiftUI
import Observation

struct Result: Decodable {
    let results: [Person]
}

struct Person: Identifiable, Decodable {
    let name: String
    let uid: String
    var id: String { uid }
}

@Observable
class StarWarsNameClass {
    var people: [Person] = []
    var searchText: String = ""
    var tabName: [String] = []
    var imageURL: URL? = nil
    var errorMessage: String? = nil
    var isLoading: Bool = false
    var isSearching: Bool = true
    private let apiURL = URL(string: "https://swapi.tech/api/people?page=1&limit=100")!

    var filteredPeople: [Person] {
        guard !searchText.isEmpty else {
            return []
        }
        return people.filter { person in
            person.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    @MainActor
    func fetchName() {
        isLoading = true
        errorMessage = nil

        guard !apiURL.absoluteString.isEmpty else {
            errorMessage = "URL invalide (définie dans la classe)"
            isLoading = false
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: apiURL)
                let decodedResult = try JSONDecoder().decode(Result.self, from: data)
                self.people = decodedResult.results
                self.tabName = decodedResult.results.map { $0.name }
            }
            catch {
                self.errorMessage = "Erreur de chargement ou de décodage: \(error.localizedDescription)"
            }
            
            self.isLoading = false
        }
    }
}
