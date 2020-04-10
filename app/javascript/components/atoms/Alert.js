import React from 'react';
import { UncontrolledAlert } from 'reactstrap';

export default ({ type, alert }) => ( 
  <UncontrolledAlert color={type} className="m-3">
    <h4 className="alert-heading">{alert.title}</h4>
    <p className="mb-0">{alert.content}</p>
  </UncontrolledAlert>
 )