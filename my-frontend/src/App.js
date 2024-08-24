import React, { useState, useEffect } from 'react';
import { useTable } from 'react-table';

function WeatherForecastTable({ weatherData }) {
  const columns = [
    {
      Header: 'Date',
      accessor: (row) => row.date,
      Cell: ({ value }) => new Date(value).toLocaleDateString(),
    },
    {
      Header: 'Temperature (C)',
      accessor: (row) => row.temperatureC,
    },
    {
      Header: 'Temperature (F)',
      accessor: (row) => row.temperatureF,
    },
    {
      Header: 'Summary',
      accessor: (row) => row.summary,
    },
  ];

  const data = weatherData;

  const { getTableProps, getTableBodyProps, headerGroups, rows, prepareRow } = useTable({
    columns,
    data,
  });

  return (
    <table {...getTableProps()} className="weather-forecast-table">
      <thead>
        {headerGroups.map((headerGroup) => (
          <tr {...headerGroup.getHeaderGroupProps()} key={headerGroup.id}>
            {headerGroup.headers.map((column) => (
              <th {...column.getHeaderProps()} key={column.id}>
                {column.render('Header')}
              </th>
            ))}
          </tr>
        ))}
      </thead>
      <tbody {...getTableBodyProps()}>
        {rows.map((row) => {
          prepareRow(row);
          return (
            <tr {...row.getRowProps()} key={row.id}>
              {row.cells.map((cell) => (
                <td {...cell.getCellProps()} key={cell.column.id}>
                  {cell.render('Cell')}
                </td>
              ))}
            </tr>
          );
        })}
      </tbody>
    </table>
  );
}

function App() {
  const [weatherData, setWeatherData] = useState([]);

  useEffect(() => {
    const apiHost = window.location.hostname; // Usar el hostname actual
    const apiUrl = `http://${apiHost}:8080/weatherforecast`;

    fetch(apiUrl)
      .then((response) => response.json())
      .then((data) => setWeatherData(data))
      .catch((error) => console.error('Error fetching data:', error));
  }, []);

  return (
    <div>
      <h1>Weather Forecast</h1>
      {weatherData.length > 0 && <WeatherForecastTable weatherData={weatherData} />}
    </div>
  );
}

export default App;
