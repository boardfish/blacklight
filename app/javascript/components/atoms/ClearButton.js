import React, { useLayoutEffect, useRef, useState } from 'react';
import { Button } from 'reactstrap';

export default ({ cleared, escapeGameId, authenticity_token }) => { 
  const [clearedState, setCleared] = useState(cleared)
  const firstUpdate = useRef(true);
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