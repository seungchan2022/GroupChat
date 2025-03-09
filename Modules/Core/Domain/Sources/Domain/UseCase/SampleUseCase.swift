import Foundation

public protocol SampleUseCase {
  var fire: () async throws -> SampleEntity { get }
}
