import React from "react";
import ClearButton from "../atoms/ClearButton";
import { Card, CardBody, CardHeader, CardFooter, CardImg } from "reactstrap";
import BlurHashTest from "../atoms/BlurHashTest";
import EscapeGameMetadata from "../atoms/EscapeGameMetadata";

const chooseColor = exploring => {
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
  exploring
}) => (
  <Card>
    <CardHeader>
      <div className="d-flex flex-row">
        <h4 className="escape-game-name">{escapeGame.name}</h4>
      </div>
      <p className="escape-game-summary">{escapeGame.summary}</p>
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
          punch: 1
        }}
      >
        <ClearButton
          cleared={cleared}
          size="sm"
          stateColors={chooseColor(exploring, cleared)}
          escapeGameId={escapeGame.id}
          authenticity_token={authenticity_token}
          style={{ zIndex: 1 }}
        />
        <h5 className="ml-auto mt-auto mr-2" style={{ zIndex: 1 }}>
          <EscapeGameMetadata
            id={escapeGame.id}
            difficultyLevel={escapeGame.difficulty_level}
            availableTime={escapeGame.available_time}
            genre={escapeGame.genre}
            location={{
              latitude: escapeGame.latitude,
              longitude: escapeGame.longitude,
              placeId: escapeGame.place_id
            }}
          />
        </h5>
      </BlurHashTest>
    ) : (
      ""
    )}
    <CardBody>
      {!imagePath ? (
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
              placeId: escapeGame.place_id
            }}
          />
        </h5>
      ) : (
        ""
      )}
      {escapeGame.description.split("\\n").map((item, i) => {
        return <p key={i}>{item}</p>;
      })}
    </CardBody>
  </Card>
);
