import React from "react";
import { Table } from "reactstrap";
import EscapeGame from "../molecules/EscapeGame";

export default ({ escapeGames, authenticity_token }) => {
  return (
    <div className="card-columns">
      {(escapeGames || []).map(escapeGame => (
        <EscapeGame escapeGame={escapeGame} authenticity_token={authenticity_token} cleared={false} />
      ))}
    </div>
  );
};
