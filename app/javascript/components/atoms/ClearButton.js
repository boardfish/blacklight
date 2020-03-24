import React, { useEffect, useRef, useState } from 'react';
import { Button } from 'reactstrap';

export default ({ cleared, escapeGameId, authenticity_token }) => { 
  const [clearedState, setCleared] = useState(cleared)
  const firstUpdate = useRef(true);
  useEffect(() => {
    if (firstUpdate.current) {
      firstUpdate.current = false;
      return;
    }
    // send a PUT request to `/escape_game/n/cleared`
    fetch(`/escape_games/${escapeGameId}/cleared.json`, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    }).then((data) => data.json())
      .then((data) => setCleared(data.cleared))
  })
  const updateCleared = (state) => {
    fetch(`/escape_games/${escapeGameId}/cleared.json`, {
      method: 'PUT',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ cleared: state, authenticity_token })
    })
  }

  return (
    <Button
      color={'primary'}
      onClick={() => {
        const newState = !clearedState
        setCleared(newState)
        updateCleared(newState)
      }}
      >{clearedState ? 'Cleared!' : 'Still to do...'}</Button>
  )
 }