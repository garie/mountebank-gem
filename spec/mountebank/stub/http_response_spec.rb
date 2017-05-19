require 'spec_helper'

RSpec.describe Mountebank::Stub::HttpResponse do
  let(:statusCode) { 200 }
  let(:headers) { {"Content-Type" => "application/json"} }
  let(:body) { {foo:"bar"}.to_json }
  let(:behaviors) { {} }
  let(:mode) { '' }
  let!(:response) { Mountebank::Stub::HttpResponse.create(statusCode, headers, body, behaviors, mode) }

  describe '.create' do
    it 'returns response object' do
      expect(response).to be_a Mountebank::Stub::HttpResponse
      expect(response.to_json).to eq '{"is":{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"foo\":\"bar\"}"}}'
    end

    context 'binary mode' do
      let(:mode) { 'binary' }
      it 'returns response object with binary mode' do
        expect(response).to be_a Mountebank::Stub::HttpResponse
        expect(response.to_json).to eq '{"is":{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"foo\":\"bar\"}","_mode":"binary"}}'
      end
    end

    context 'invalid binary mode' do
        let(:mode) { 'random' }
        it 'returns response object without binary mode' do
          expect(response).to be_a Mountebank::Stub::HttpResponse
          expect(response.to_json).to eq '{"is":{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"foo\":\"bar\"}"}}'
        end
    end

    context 'with behaviors' do
        let(:behaviors) { { wait: 10000 } }
      it 'returns a response object' do
        expect(response).to be_a Mountebank::Stub::HttpResponse
        expect(response.to_json).to eq '{"is":{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"foo\":\"bar\"}"},"_behaviors":{"wait":10000}}'
      end
    end
  end
end
