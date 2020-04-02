import React from "react";
import { Card, CardBody } from "reactstrap";
import moment from "moment";
import EscapeGameMetadata from "../atoms/EscapeGameMetadata";

export default ({ escapeGame, clear }) => (
  <Card className="mb-2">
    <CardBody className="d-flex align-items-center">
      <div style={{ flexGrow: 0.3 }}>
        <p className="escape-game-name h6 mb-0">{escapeGame.name}</p>
        <p className="escape-game-summary mb-0 pr-2">
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
        </p>
      </div>
      <p className="ml-auto mb-0">
        Cleared {moment(clear.created_at).fromNow()}
      </p>
      {/* TODO: Clear date */}
    </CardBody>
  </Card>
);
