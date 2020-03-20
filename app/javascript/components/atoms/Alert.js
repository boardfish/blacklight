import React from 'react';
import { UncontrolledAlert } from 'reactstrap';

export default ({ type, content }) => ( 
  <UncontrolledAlert color={type}>
    {content}
  </UncontrolledAlert>
 )