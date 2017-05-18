class Mountebank::Stub::HttpResponse < Mountebank::Stub::Response
  def self.create(statusCode=200, headers={}, body='', behaviors: {}, mode: '')
    payload = {}
    payload[:statusCode] = statusCode
    payload[:headers] = headers unless headers.empty?
    payload[:body] = body unless body.empty?
    payload[:_mode] = mode unless mode.empty?

    data = {is: payload}
    data.merge!(_behaviors: behaviors) unless behaviors.empty?
    new(data)
  end
end
