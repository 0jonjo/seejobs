class Job

  attr_accessor :id, :title, :description, :skills, :salary, :company, :level, :place, :date, :code, :job_status
  
  def initialize(id: ,title: , description: , skills: , salary: , company: , level: , place: , date: , code: , job_status: )
    @id = id
    @title = title
    @description = description
    @skills = skills
    @salary = salary
    @company = company
    @level = level
    @place = place
    @date = date
    @code = code
    @job_status = job_status
  end

  def self.all
    jobs = []
    response = Faraday.get('http://localhost:4000/api/v1/jobs')
    if response.status == 200
      data = JSON.parse(response.body)
      data.each do |j|
        jobs << Job.new(id: j["id"], title: j["title"], description: j["description"], skills: j["skills"], salary: j["salary"], company: j["company"], level: j["level"], place: j["place"], date: j["date"], code: j["code"], job_status: j["job_status"])
      end
    end  
    jobs       
  end
end 