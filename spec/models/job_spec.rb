require 'rails_helper'

describe Job do
  context ".all" do
    it "return all with sucess" do
      json_data = File.read(Rails.root.join('spec/support/json/jobs.json'))
      fake_response = double("faraday_response", status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/jobs').and_return(fake_response)
      result = Job.all
      expect(result.length).to eq 2
      expect(result[0].id).to eq 1
      expect(result[0].title).to eq  "Job Opening Test 123"
      expect(result[0].description).to eq "Lorem ipsum"
      expect(result[0].skills).to eq "Nam mattis"
      expect(result[0].salary).to eq "99.0"
      expect(result[0].company).to eq "Acme"
      expect(result[0].level).to eq "Junior"
      expect(result[0].place).to eq "Remote"
      expect(result[0].date).to eq "2022-08-31"
      expect(result[0].code).to eq "Ykeabwhq"
      expect(result[0].job_status).to eq "draft"
      expect(result[1].id).to eq 2
      expect(result[1].title).to eq  "Job Opening Test 456"
      expect(result[1].code).to eq "Kl92zlzt"
    end

    it "return nothing if API unavailable" do
      fake_response = double("faraday_resp", status: 500, body: "{'error': 'test error'}")
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/jobs').and_return(fake_response) 
      result = Job.all
      expect(result).to eq []
    end
  end 
end