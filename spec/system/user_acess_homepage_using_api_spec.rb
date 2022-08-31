require 'rails_helper'

describe "User acess homepage that uses API" do
  it "and see jobs index with sucess" do
    jobs = []
    jobs << Job.new(id: 1, title: "Job Opening Test 123", description: "description", 
                      skills: "skills", salary: "99.0", company: "Acme", 
                      level: "Junior", place: "Remote", date: "2099-08-01", 
                      code: "Ykeabwhq", job_status: "draft")
    jobs << Job.new(id: 2, title: "Job Opening Test 456", description: "description", 
                      skills: "skills", salary: "99.0", company: "Acme", 
                      level: "Junior", place: "Remote", date: "2099-08-01", 
                      code: "Kl92zlzt", job_status: "draft")
    allow(Job).to receive(:all).and_return(jobs)

    visit root_path
    expect(page).to have_content "SEEJOBS"
    expect(page).to have_content "Job Opening Test 123"
    expect(page).to have_content "1"
    expect(page).to have_content "Ykeabwhq"
    expect(page).to have_content "Job Opening Test 456"
    expect(page).to have_content "2"
    expect(page).to have_content "Kl92zlzt"
  end

  it "and do not see any jobs on index" do
    fake_response = double("faraday_response", status: 200, body: "[]")
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/jobs').and_return(fake_response)
    
    visit root_path
    expect(page).to have_content "SEEJOBS"
    expect(page).to have_content "No Job Openings found."
  end  

  it "and see job view with sucess" do
    json_data = File.read(Rails.root.join('spec/support/json/jobs.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/jobs').and_return(fake_response)

    json_data = File.read(Rails.root.join('spec/support/json/job.json'))
    fake_job = double("faraday_response_job", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/jobs/1').and_return(fake_job)
    
    visit root_path
    click_on "Job Opening Test 123"

    expect(page).to have_content "Job Ykeabwhq"
    expect(page).to have_content "Title: Job Opening Test 123"
    expect(page).to have_content "ID: 1"
    expect(page).to have_content "Skills: Nam mattis"
    expect(page).to have_content "Salary: 99.0"
    expect(page).to have_content "Company: Acme"
    expect(page).to have_content "Level: Junior"
    expect(page).to have_content "Place: Remote"
    expect(page).to have_content "Date: 2022-08-31"
    expect(page).to have_content "Job Status: draft"
    expect(page).to_not have_content "Job Opening Test 456"
    expect(page).to_not have_content "ID: 2"
    expect(page).to_not have_content "Kl92zlzt"
  end

  it "and do not see job view " do
    json_data = File.read(Rails.root.join('spec/support/json/jobs.json'))
    fake_response = double("faraday_response", status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/jobs').and_return(fake_response)

    fake_job = double("faraday_response_job", status: 500, body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/jobs/1').and_return(fake_job)
    
    visit root_path
    click_on "Job Opening Test 123"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "No Job Opening found."
  end
end    

