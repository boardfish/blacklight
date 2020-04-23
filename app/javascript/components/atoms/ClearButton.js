import React, { useState, useEffect, Fragment } from "react";
import { Button, Tooltip } from "reactstrap";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

export default ({ cleared, escapeGameId, authenticity_token, stateColors, size, className, style }) => {
  const [clearedState, setCleared] = useState(cleared);
  const [isHovered, setHovered] = useState(false);
  useEffect(() => {
    setCleared(cleared);
  }, [cleared]);
  const updateCleared = state => {
    fetch(`/escape_games/${escapeGameId}/cleared.json`, {
      method: "PUT",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ cleared: state, authenticity_token })
    });
  };

  return (
    <Fragment>
      <Button
        color={stateColors[clearedState ? 1 : 0]}
        onClick={(e) => {
          e.preventDefault()
          const newState = !clearedState;
          setCleared(newState);
          updateCleared(newState);
        }}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
        size={size}
        className={className}
        style={style}
        id={`clearButtonFor${escapeGameId}`}
      >
        {clearedState ? <FontAwesomeIcon icon="lock-open" /> : <FontAwesomeIcon icon="lock" />}
      </Button>
      <Tooltip isOpen={isHovered} target={`clearButtonFor${escapeGameId}`}>
        {clearedState ? 'Y' : 'Click here if y'}ou've cleared this room!
      </Tooltip>
    </Fragment>
  );
};
