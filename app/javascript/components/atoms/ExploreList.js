import React from "react";
import EscapeGame from "../molecules/EscapeGame";

export default ({ escapeGames, authenticity_token }) => {
  return (
    // <p>{JSON.stringify(escapeGames)}</p>
    <div className="card-columns">
      {(escapeGames || []).map(({ escape_game, cleared, image_path }) => (
        <div>
          <EscapeGame
            escapeGame={escape_game}
            id={escape_game.id}
            authenticity_token={authenticity_token}
            cleared={cleared}
            imagePath={image_path}
          />
        </div>
      ))}
    </div>
  );
};
