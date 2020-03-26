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
  <a
    href={escapeGame.website_link}
    className="text-body"
    target="_blank"
    rel="noopener"
  >
    <Card>
      <CardHeader>
        <div className="d-flex flex-row">
        <h4 className="mr-auto">{escapeGame.name}</h4>
        <ClearButton
          cleared={cleared}
          size='sm'
          stateColors={chooseColor(exploring, cleared)}
          escapeGameId={escapeGame.id}
          authenticity_token={authenticity_token}
        />
        </div>
        <p className="text-muted">{escapeGame.summary}</p>
      </CardHeader>
      {imagePath ? <BlurHashTest
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
        <h5 className="ml-auto mt-auto mr-2" style={{zIndex: 1}}>
          <EscapeGameMetadata id={escapeGame.id} difficultyLevel={escapeGame.difficulty_level} availableTime={escapeGame.available_time} genre={escapeGame.genre} />
        </h5>
      </BlurHashTest> : ''
      }
      <CardBody>
        {escapeGame.description.split("\\n").map((item, i) => {
          return <p key={i}>{item}</p>;
        })}
      </CardBody>
      
    </Card>
  </a>
);
