import Foundation
import HTTPTypes
import OpenAPIRuntime

/// Function that can execute a `URLRequest`.
///
/// This is used to abstract the actual networking system from the underlying authentication
/// mechanism.
public typealias URLResponseProvider = @Sendable (URLRequest) async throws -> (Data, URLResponse)

public struct FoundationClientTransport: ClientTransport {
    public init(responseProvider: @escaping URLResponseProvider) {
        self.responseProvider = responseProvider
    }

    public func send(_ request: HTTPTypes.HTTPRequest, body: OpenAPIRuntime.HTTPBody?, baseURL: URL, operationID: String) async throws -> (HTTPTypes.HTTPResponse, OpenAPIRuntime.HTTPBody?) {
        let urlRequest = try URLRequest(request, baseURL: baseURL)
        let (data, response) = try await responseProvider(urlRequest)

        return try (
            HTTPTypes.HTTPResponse(response),
            OpenAPIRuntime.HTTPBody(data, length: .known(Int64(data.count)), iterationBehavior: .single)
        )
    }

    let responseProvider: URLResponseProvider
}
