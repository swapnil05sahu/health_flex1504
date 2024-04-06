import React, { useState, useEffect } from 'react';

const API_KEY = 'YOUR_API_KEY';
const API_URL = https://api.openweathermap.org/data/2.5;

const App = () => {
  const [currentWeather, setCurrentWeather] = useState(null);
  const [forecastWeather, setForecastWeather] = useState(null);

  useEffect(() => {
    // Fetch current weather
    fetch(${API_URL}/weather?q=London&appid=${API_KEY})
      .then(response => response.json())
      .then(data => setCurrentWeather(data));

    // Fetch forecasted weather
    fetch(${API_URL}/forecast?q=London&appid=${API_KEY})
      .then(response => response.json())
      .then(data => setForecastWeather(data));
  }, []);

  return (
    <div>
      <h1>Weather App</h1>
      {currentWeather && (
        <div>
          <h2>Current Weather</h2>
          <p>Temperature: {currentWeather.main.temp}°C</p>
          <p>Humidity: {currentWeather.main.humidity}%</p>
          <p>Weather: {currentWeather.weather[0].main}</p>
        </div>
      )}
      {forecastWeather && (
        <div>
          <h2>Forecast</h2>
          <ul>
            {forecastWeather.list.map((forecast, index) => (
              <li key={index}>
                {forecast.dt_txt}: {forecast.weather[0].main}, {forecast.main.temp}°C
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default App;