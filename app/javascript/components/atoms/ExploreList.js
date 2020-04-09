import React from "react";
import EscapeGame from "../molecules/EscapeGame";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

export default ({
  escapeGames,
  authenticity_token,
  cardClass,
  containerClass,
}) => {
  if ((escapeGames || []).length > 0) {
    return (
      <div className={containerClass || "card-columns"}>
        {(escapeGames || []).map(
          ({ escape_game, cleared, image_path, user }, index) => (
            <EscapeGame
              escapeGame={escape_game}
              id={escape_game.id}
              authenticity_token={authenticity_token}
              cleared={cleared}
              imagePath={image_path}
              user={user}
              key={index}
              className={cardClass}
            />
          )
        )}
      </div>
    );
  } else {
    return (
      <div className="d-flex flex-column align-items-center justify-content-center text-muted flex-grow-1">
        <FontAwesomeIcon icon="fish" size="5x" color="#d70000" />
        <h2>No results</h2>
        <p>There weren't any escape rooms listed.</p>
      </div>
    );
  }
};
