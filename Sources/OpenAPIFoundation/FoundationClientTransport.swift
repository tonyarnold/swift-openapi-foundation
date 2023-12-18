import HTTPTypes
import OpenAPIRuntime

#if canImport(Foundation)
import Foundation

struct FoundationClientTransport: ClientTransport {
    let responseProvider: @Sendable (URLRequest) async throws -> (Data, URLResponse)

    public func send(_ request: HTTPTypes.HTTPRequest, body: OpenAPIRuntime.HTTPBody?, baseURL: URL, operationID: String) async throws -> (HTTPTypes.HTTPResponse, OpenAPIRuntime.HTTPBody?) {
        let urlRequest = try URLRequest(request, baseURL: baseURL)
        let (data, response) = try await responseProvider(urlRequest)

        return try (
            HTTPTypes.HTTPResponse(response),
            OpenAPIRuntime.HTTPBody(data, length: .known(Int64(data.count)), iterationBehavior: .single)
        )
    }
}
#endif
