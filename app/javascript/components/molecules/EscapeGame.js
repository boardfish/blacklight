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

const chooseColor = (exploring, cleared) => {
  let colors = []
  switch(exploring) {
    case false:
      colors = ['success', 'secondary'];
      break;
    default:
      colors = ['secondary', 'primary'];
      break;
  }
  return (cleared ? colors[0] : colors[1])
}

const chooseGenreIcon = (genre) => {
  return{
    modern: 'mobile',
    other: 'question-circle',
    historical: 'history',
    horror: 'ghost',
    fantasy: 'meteor',
    science: 'atom',
    abstract: 'dungeon',
    future: 'user-astronaut',
    military: 'fighter-jet',
    toy_room: 'shapes',
    cartoon: 'laugh-wink',
    steampunk: 'cogs',
    seasonal: 'calendar-day',
    default: 'question-circle'
  }[genre]
}

export default ({ cleared, escapeGame, authenticity_token, exploring }) => (
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
            <FontAwesomeIcon icon={chooseGenreIcon(escapeGame.genre)} /> {startCase(escapeGame.genre)}
          </span>
        </div>
        <p>{escapeGame.description.split('\\n').map((item, i) => {
    return <p key={i}>{item}</p>;
})}</p>
      </CardBody>
      <CardFooter>
        <ClearButton cleared={cleared} color={chooseColor(exploring, cleared)} escapeGameId={escapeGame.id} authenticity_token={authenticity_token} />
      </CardFooter>
    </Card>
  </a>
)