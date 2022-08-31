class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end   
  
  def show
    id = params[:id]
    response = Faraday.get("http://localhost:4000/api/v1/jobs/#{id}")
    if response.status == 200
     @job = JSON.parse(response.body)
    else
      redirect_to root_path, notice: "No Job Opening found."
    end   
  end
end
