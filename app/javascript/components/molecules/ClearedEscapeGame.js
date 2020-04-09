import React from "react";
import { Card, CardBody, UncontrolledCollapse, Button } from "reactstrap";
import moment from "moment";
import EscapeGameMetadata from "../atoms/EscapeGameMetadata";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import ImageCarousel from "../atoms/ImageCarousel";

export default ({ escapeGame, clear, images, form_authenticity_token }) => (
  <Card className="mb-2">
    <CardBody>
      <div className="d-flex align-items-center">
        <div style={{ flexGrow: 0.3 }}>
          <a
            className="escape-game-name h6 mb-0 d-block"
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
          <small className="d-block text-muted">
            Cleared {moment(clear.created_at).fromNow()}
          </small>
        </div>
        <p className="ml-auto mb-0 d-none d-md-block">
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
      <UncontrolledCollapse toggler={`#clear-${clear.id}-images`}>
      {images.length > 0
       ? <ImageCarousel items={images || []} />
       : ''
      }
      <form role="form" encType="multipart/form-data" action={`/clears/${clear.id}`} acceptCharset="UTF-8" method="post">
        <input type="hidden" name="_method" value="patch" />
        <input type="hidden" name="authenticity_token" value={form_authenticity_token} />
        <div className="custom-file">
          <input multiple="multiple" className="custom-file-input" type="file" name="clear[images][]" id="clear_images" />
          <label className="custom-file-label" htmlFor="clear_images">
            Choose file
          </label>
        </div>
        {images.map(image => (
          <input type="hidden" multiple="multiple" name="clear[images][]" value={image.signed_id} />
        ))}
        <button type="submit">Submit</button>
      </form>
      </UncontrolledCollapse>
           {/* TODO: Clear date */}
    </CardBody>
  </Card>
);
