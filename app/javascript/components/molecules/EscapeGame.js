import React from 'react';
import ClearButton from '../atoms/ClearButton';
import { Card, CardBody, CardHeader } from 'reactstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import startCase from 'lodash/startCase'

const fuzzyTime = (minutes) => {
  const hours = Math.floor(minutes / 60)
  const mins = minutes - (hours * 60)
  return `${hours > 0 ? `${hours}hr` : ''} ${mins > 0 ? `${mins}m` : ''}`
}

export default ({ cleared, escapeGame, authenticity_token }) => (
  <a href={escapeGame.website_link} className="text-body" target="_blank" rel="noopener">
    <Card>
      <CardHeader className="d-flex align-items-center">
        <div className="mr-auto">
          <h4>{escapeGame.name}</h4>
          <p className="text-muted">{escapeGame.summary}</p>
          <div>
            <span class="badge badge-primary">
              <FontAwesomeIcon icon="burn" /> {escapeGame.difficulty_level}
            </span>
          </div>
        </div>
        <ClearButton cleared={cleared} escapeGameId={escapeGame.id} authenticity_token={authenticity_token} />
      </CardHeader>
      <CardBody>
        <FontAwesomeIcon icon="hourglass-start" /> {fuzzyTime(escapeGame.available_time)}
        <FontAwesomeIcon icon="hourglass-start" /> {startCase(escapeGame.genre)}
        <p>{escapeGame.description}</p>
      </CardBody>
    </Card>
  </a>
)