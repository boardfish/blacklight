import React, { useEffect, useState } from "react";
import { Table } from "reactstrap";

export default () => {
  const [escapeGames, setEscapeGames] = useState([]);
  useEffect(() => {
    fetch(`/explore`, {
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      }
    })
      .then(resp => resp.json()) // Transform the data into json
      .then(function(data) {
        setEscapeGames(data);
      });
  });
  return (
    <Table>
      <thead>
        <tr>
          <th>Name</th>
        </tr>
      </thead>
      <tbody>
        {(escapeGames || []).map(escapeGame => (
          <tr><td>{escapeGame.name}</td></tr>
        ))}
      </tbody>
    </Table>
  );
};
