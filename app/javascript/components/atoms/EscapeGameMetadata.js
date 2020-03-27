import React, { Fragment } from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import startCase from "lodash/startCase";
import { UncontrolledTooltip } from "reactstrap";

const spiciness = difficultyLevel => {
  switch (difficultyLevel) {
    case "intermediate":
      return 2;
    case "enthusiast":
      return 3;
    default:
      return 1;
  }
};

const renderDifficulty = difficultyLevel => {
  var content = [];
  for (var i = 0; i < spiciness(difficultyLevel); i++) {
    content.push(<FontAwesomeIcon icon="burn" />);
  }
  return content;
};

const chooseGenreIcon = genre => {
  return {
    modern: "mobile",
    other: "question-circle",
    historical: "history",
    horror: "ghost",
    fantasy: "meteor",
    science: "atom",
    abstract: "dungeon",
    future: "user-astronaut",
    military: "fighter-jet",
    toy_room: "shapes",
    cartoon: "laugh-wink",
    steampunk: "cogs",
    seasonal: "calendar-day",
    default: "question-circle"
  }[genre];
};

const getGoogleMapsURLFor = ({ latitude, longitude, placeId }) => {
  return `https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}&query_place_id=${placeId}`;
};

const fuzzyTime = minutes => {
  const hours = Math.floor(minutes / 60);
  const mins = minutes - hours * 60;
  return `${hours > 0 ? `${hours}hr` : ""} ${mins > 0 ? `${mins}m` : ""}`;
};

export default ({ id, difficultyLevel, availableTime, genre, location }) => (
  <Fragment>
    {
      location && location.latitude && location.longitude && location.placeId ?
      <Fragment>
        <a
          href={getGoogleMapsURLFor(location)}
          rel="noopener"
          target="_blank"
          className="badge badge-primary mr-1"
          id={`location-${id}`}
        >
          <FontAwesomeIcon icon="map-marker" />
        </a>
        <UncontrolledTooltip target={`location-${id}`} placement="bottom">
          View on Google Maps
        </UncontrolledTooltip>
      </Fragment>
      : ''
    }
    <span className="badge badge-primary mr-1" id={`difficultyLevel-${id}`}>
      {renderDifficulty(difficultyLevel)}
    </span>
    <UncontrolledTooltip target={`difficultyLevel-${id}`} placement="bottom">
      {startCase(difficultyLevel)}
    </UncontrolledTooltip>
    <span className="badge badge-primary mr-1" id={`genre-${id}`}>
      <FontAwesomeIcon icon={chooseGenreIcon(genre)} />{" "}
    </span>
    <UncontrolledTooltip target={`genre-${id}`} placement="bottom">
      {startCase(genre)}
    </UncontrolledTooltip>
    <span className="badge badge-primary">
      <FontAwesomeIcon icon="hourglass-start" /> {fuzzyTime(availableTime)}
    </span>
  </Fragment>
);
