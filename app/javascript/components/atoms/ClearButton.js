import React, { useState, useEffect } from "react";
import { Button } from "reactstrap";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

export default ({ cleared, escapeGameId, authenticity_token, stateColors, size, className, style }) => {
  const [clearedState, setCleared] = useState(cleared);
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
    <Button
      color={stateColors[clearedState ? 1 : 0]}
      onClick={() => {
        const newState = !clearedState;
        setCleared(newState);
        updateCleared(newState);
      }}
      size={size}
      className={className}
      style={style}
    >
      {clearedState ? <FontAwesomeIcon icon="lock-open" /> : <FontAwesomeIcon icon="lock" />}
    </Button>
  );
};
