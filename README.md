# README

This sample application is built to accept an address as input, and then provides the current weather for that location. This is accomplished leveraging the `geocoder` gem to geocode the address to determine it's postal code, and latitude/longitude. Once that information is retrieved, it then calls the OpenWeather API via the `open-weather-ruby-client` gem. 

## Geocoder configuration

In order to use the `geocoder` gem, an API key must be created and retrieved from any one of many geocoding services available. For this project I chose [Geoapify](https://www.geoapify.com/geocoding-api/) as it was free to use. The configuration for this gem can be found in the `config/initializers/geocoder.rb` file.

## OpenWeather configuration

To leverage the OpenWeatherAPI client an API key must be created at [OpenWeatherAPI](https://openweathermap.org/api). The configuration for this client can be found in the `config/initializers/open_weather.rb` file. 

## ENV vars

In order to not store sensitive secrets in the application, all API keys and sensitive information is stored in a `.env` file, and in a `.env.test` for running the tests. A `.env.example` file has been provided as a starting point, and can be copied and used for the `.env` and `.env.test` files respectively. Just fill in the API keys that you've registered for Geoapify and OpenWeatherAPI.

## External services

Docker is leveraged to run both the PostgreSQL database and Memcached so that installing either of these locally is not necessary. You can simply start these services using `docker compose up` in a terminal, or `docker compose up -d` to have them run as detached services.

## Running the application

In order to run the application make sure you've specified the API keys in the `.env` file appropriately, then also make sure the database and cache servers are running via the provided `docker-compose.yml` file. Once these are ready, launch the application by typing `bin/dev` in your terminal. There is a minimal UI provided to test the application in the browser, or you may call the REST API using a tool such as Postman by sending a GET request to `http://localhost:3000/search?q=YOUR_ADDRESS` and setting the `Content-Type: application/json` header on your request.

## Running the tests

Tests for the application have been written using RSpec and can be run with the command `bundle exec rspec`.
