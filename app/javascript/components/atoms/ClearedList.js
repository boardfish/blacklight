import React from "react";
import ClearedEscapeGame from "../molecules/ClearedEscapeGame";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

export default ({ escapeGames, form_authenticity_token }) => {
  if ((escapeGames || []).length === 0) {
    return (
      <div className="d-flex flex-column align-items-center justify-content-center text-muted flex-grow-1">
        <FontAwesomeIcon icon="fish" size="5x" color="#d70000" />
        <h2>You haven't cleared a game yet.</h2>
        <p>Click the lock icon next to any escape room listing to mark it as cleared.</p>
      </div>
    )
  } else {
    return (
      <div className="container">
        {(escapeGames || []).map(({ escape_game, clear, images }, index) => (
          <ClearedEscapeGame
            escapeGame={escape_game}
            id={escape_game.id}
            clear={clear}
            images={images}
            form_authenticity_token={form_authenticity_token}
            key={index}
          />
        ))}
      </div>
    );
  }
};
