import Entities
import RepositoryProtocol
import NetworkService
import Foundation
import Combine

public final class SongsAudioRepository: SongsAudioRepositoryProtocol {

    let songsAudioFileManager = SongsAudioFileManager()
    var networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    public func download(song: Song, progress subject: CurrentValueSubject<Float, Never>) async throws -> DownloadedSongAudio {
        let destinationURL = songsAudioFileManager.songsAudioURL(songId: song.id)
        let request = DownloadSongRequest(destinationFileURL: destinationURL, url: song.audioURL)
        let _ = try await networkService.loadFile(request: request) { progress in
            subject.value = progress
        }
        
        return DownloadedSongAudio(id: song.id, fileURL: destinationURL)
    }

    public func downloadedSongAudio(songId: Song.Identity) -> DownloadedSongAudio? {
        guard let url = songsAudioFileManager.existingAudioFile(for: songId) else {
            return nil
        }
        return DownloadedSongAudio(id: songId, fileURL: url)
    }
    
}

struct DownloadSongRequest: DownloadDataRequest {
    var destinationFileURL: URL
    var url: URL

    func makeURL(for configuration: NetworkConfiguration) throws -> URL {
        url
    }
}

struct FileManagerError: Swift.Error, LocalizedError {
    
    var errorMessage: String
    init(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    var errorDescription: String? {
        errorMessage
    }

    var failureReason: String? {
        nil
    }

    var recoverySuggestion: String? {
        nil
    }
}

struct SongsAudioFileManager {
    let songsAudioFolderURL: URL
    let folderName = "SongsAudio"
    let fileManager = FileManager.default
    
    init() {
        
        let documentsDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let folderURL = documentsDirectory.appendingPathComponent(folderName)

        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create folder in documents directory")
            }
        }
        self.songsAudioFolderURL = folderURL
    }

    func songsAudioURL(songId: Song.Identity) -> URL {
        return songsAudioFolderURL.appendingPathComponent("\(songId).mp3")
    }
    
    func save(downloadedFileURL: URL, with songId: Song.Identity) throws -> URL {
        do {
            let url = songsAudioURL(songId: songId)
            try fileManager.copyItem(at: downloadedFileURL, to: url)
            return url
        } catch let error {
            throw FileManagerError("Failed to move downloaded file to user documents \(error.localizedDescription)")
        }
    }
    
    func existingAudioFile(for songId: Song.Identity) -> URL? {
        let url = songsAudioURL(songId: songId)
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        return url
    }
}
