import React, { Fragment } from "react";
import EscapeGame from "../molecules/EscapeGame";

export default ({ escapeGames, authenticity_token, containerClass }) => {
  return (
    <Fragment>
      {(escapeGames || []).map(({ escape_game, user }, index) => (
        <EscapeGame
          escapeGame={escape_game}
          id={escape_game.id}
          authenticity_token={authenticity_token}
          user={user}
          key={index}
        />
      ))}
    </Fragment>
  );
};
