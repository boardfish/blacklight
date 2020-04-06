import React, { useState } from "react";
import ClearButton from "../atoms/ClearButton";
import { Card, CardBody, CardHeader, CardFooter, CardImg } from "reactstrap";
import BlurHashTest from "../atoms/BlurHashTest";
import EscapeGameMetadata from "../atoms/EscapeGameMetadata";
import Avatar from "../atoms/Avatar";
import UserRepresentation from "./UserRepresentation";

const chooseColor = (exploring) => {
  switch (exploring) {
    case false:
      return ["secondary", "success"];
      break;
    default:
      return ["primary", "secondary"];
      break;
  }
};

export default ({
  cleared,
  escapeGame,
  imagePath,
  authenticity_token,
  exploring,
  user,
}) => {
  const [hovered, setHovered] = useState("");
  return (
    <a
      onMouseOver={() => setHovered("focused")}
      onMouseOut={() => setHovered("unfocused")}
      onFocus={() => setHovered("focused")}
      onBlur={() => setHovered("unfocused")}
      href={`/escape_games/${escapeGame.id}`}
      className={`card ${hovered}`}
      tabIndex={1}
    >
      <CardHeader>
        <div className="d-flex flex-row">
          <h4 className="escape-game-name">{escapeGame.name}</h4>
        </div>
        <p className="escape-game-summary">{escapeGame.summary}</p>
        <h5 className="d-flex justify-content-end align-items-center">
          <ClearButton
            cleared={cleared}
            size="sm"
            stateColors={chooseColor(exploring, cleared)}
            escapeGameId={escapeGame.id}
            authenticity_token={authenticity_token}
            className="mr-auto"
          />
          <EscapeGameMetadata
            id={escapeGame.id}
            difficultyLevel={escapeGame.difficulty_level}
            availableTime={escapeGame.available_time}
            genre={escapeGame.genre}
            location={{
              latitude: escapeGame.latitude,
              longitude: escapeGame.longitude,
              placeId: escapeGame.place_id,
            }}
          />
          <Avatar
            className="ml-2"
            onClick={() => {
              window.location = `/users/${user.id}`;
            }}
            avatar={user.avatar}
            height={"2em"}
          />
        </h5>
      </CardHeader>
      {imagePath ? (
        <BlurHashTest
          blurhash={escapeGame.blurhash}
          src={imagePath}
          className="card-img"
          blurhashOpts={{
            width: "100%",
            height: "200px",
            resolutionX: 350,
            punch: 1,
          }}
        />
      ) : (
        ""
      )}
    </a>
  );
};
