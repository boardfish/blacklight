import React from "react";
import EscapeGame from "../molecules/EscapeGame";

export default ({ escapeGames, authenticity_token, cardClass, containerClass }) => {
  return (
    <div className={containerClass || 'card-columns'}>
      {(escapeGames || []).map(({ escape_game, cleared, image_path, user }, index) => (
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
      ))}
    </div>
  );
};
