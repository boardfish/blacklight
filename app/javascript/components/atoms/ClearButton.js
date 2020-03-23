import React, { useLayoutEffect, useRef, useState } from 'react';
import { Button } from 'reactstrap';

export default ({ cleared, escapeGameId, authenticity_token }) => { 
  const [clearedState, setCleared] = useState(cleared)
  const firstUpdate = useRef(true);
  useLayoutEffect(() => {
    if (firstUpdate.current) {
      firstUpdate.current = false;
      return;
    }
    // send a PUT request to `/escape_game/n/cleared`
    fetch(`/escape_games/${escapeGameId}/cleared.json`, {
      method: 'PUT',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ cleared: clearedState, authenticity_token })
    })
  })
  return (
    <Button
      color={'primary'}
      onClick={() => setCleared(!clearedState)}
      >{clearedState ? 'Cleared!' : 'Still to do...'}</Button>
  )
 }