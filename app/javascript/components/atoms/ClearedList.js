import React from "react";
import ClearedEscapeGame from "../molecules/ClearedEscapeGame";

export default ({ escapeGames }) => {
  return (
    <div className="container">
      {(escapeGames || []).map(({ escape_game, clear }, index) => (
        <ClearedEscapeGame
          escapeGame={escape_game}
          id={escape_game.id}
          clear={clear}
          key={index}
        />
      ))}
    </div>
  );
};
