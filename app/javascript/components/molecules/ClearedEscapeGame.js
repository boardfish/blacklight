import React from "react";
import { Card, CardBody, UncontrolledCollapse, Button } from "reactstrap";
import moment from "moment";
import EscapeGameMetadata from "../atoms/EscapeGameMetadata";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import ImageCarousel from "../atoms/ImageCarousel";

export default ({ escapeGame, clear, images }) => (
  <Card className="mb-2">
    <CardBody>
      <div className="d-flex align-items-center">
        <div style={{ flexGrow: 0.3 }}>
          <a
            className="escape-game-name h6 mb-0"
            href={`/escape_games/${escapeGame.id}`}
          >
            {escapeGame.name}
          </a>
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
        <Button
          color="primary"
          className="ml-2"
          id={`clear-${clear.id}-images`}
        >
          <FontAwesomeIcon icon={images.length > 0 ? "chevron-down" : "image"} />
        </Button>
      </div>
      {images.length > 0
      ?  <UncontrolledCollapse toggler={`#clear-${clear.id}-images`}>
        <ImageCarousel items={images || []} />
      </UncontrolledCollapse>
      : ''
      }
           {/* TODO: Clear date */}
    </CardBody>
  </Card>
);
