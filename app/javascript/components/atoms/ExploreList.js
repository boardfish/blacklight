import React from "react";
import { Table } from "reactstrap";

export default ({ escapeGames }) => {
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
