# SEEJOBS

This is side repository to test API of the [Alljobs](https://github.com/0jonjo/alljobs/), a TDD study project to a job opening website using Ruby on Rails.

[Project Board (To do, In Progress, Done)](https://github.com/0jonjo/alljobs/projects/1)

Ruby: 3.0.0
Rails: 6.1.4.1 
Gems:
- Faraday (2.5.2)
- Rspec-rails (5.0.2)
- Capybara (3.37.1)

## Install

### Clone the repository

```shell
git clone git@github.com:0jonjo/seejobs.git
cd alljobs
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle install
```

## Create and migrate database

```shell
rails db:create 
rails db:migrate
```

## Serve

```shell
rails s
```