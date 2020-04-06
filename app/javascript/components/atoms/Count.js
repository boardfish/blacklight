import React, { Fragment } from 'react'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

export default ({ iconName, count }) => (
  <span className="d-flex align-items-center">
    <FontAwesomeIcon icon={iconName} fixedWidth />
    <FontAwesomeIcon icon='times' fixedWidth />
    <b style={{fontSize: '1.3em'}}>{count}</b>
  </span>
)