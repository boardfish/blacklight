import React from "react";
import ClearedEscapeGame from "../molecules/ClearedEscapeGame";

export default ({ escapeGames, form_authenticity_token }) => {
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
};
