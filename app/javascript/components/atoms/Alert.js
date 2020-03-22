import React from 'react';
import { UncontrolledAlert } from 'reactstrap';

export default ({ type, alert }) => ( 
  <UncontrolledAlert color={type}>
    <h4 className="alert-heading">{alert.title}</h4>
    <p class="mb-0">{alert.content}</p>
  </UncontrolledAlert>
 )