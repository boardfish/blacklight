import React from 'react';
import ClearButton from '../atoms/ClearButton';
import { Card, CardBody, CardHeader, CardFooter } from 'reactstrap';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import startCase from 'lodash/startCase'

const fuzzyTime = (minutes) => {
  const hours = Math.floor(minutes / 60)
  const mins = minutes - (hours * 60)
  return `${hours > 0 ? `${hours}hr` : ''} ${mins > 0 ? `${mins}m` : ''}`
}

const spiciness = (difficultyLevel) => {
  switch (difficultyLevel) {
    case 'intermediate':
      return 2;
    case 'enthusiast':
      return 3;
    default:
      return 1;
  }
}

const renderDifficulty = (difficultyLevel) => {
  var content = []
  for (var i = 0; i < spiciness(difficultyLevel); i++) {
    content.push(<FontAwesomeIcon icon="burn" />)
  }
  return content;
}

export default ({ cleared, escapeGame, authenticity_token }) => (
  <a href={escapeGame.website_link} className="text-body" target="_blank" rel="noopener">
    <Card>
      <CardHeader>
        <h4>{escapeGame.name}</h4>
        <p className="text-muted">{escapeGame.summary}</p>
      </CardHeader>
      <CardBody>
        <div>
          <span className="text-muted">
            {renderDifficulty(escapeGame.difficulty_level)} {startCase(escapeGame.difficulty_level)} |{' '}
            <FontAwesomeIcon icon="hourglass-start" /> {fuzzyTime(escapeGame.available_time)} |{' '}
            <FontAwesomeIcon icon="hourglass-start" /> {startCase(escapeGame.genre)}
            
          </span>
        </div>
        <p>{escapeGame.description}</p>
      </CardBody>
      <CardFooter>
        <ClearButton cleared={cleared} escapeGameId={escapeGame.id} authenticity_token={authenticity_token} />
      </CardFooter>
    </Card>
  </a>
)