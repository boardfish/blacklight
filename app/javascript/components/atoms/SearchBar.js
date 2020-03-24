import React from 'react';

export default ({ search, onChange }) => { 
  return (
  <input
    type="text"
    className="form-control"
    value={search}
    onChange={onChange} />
  )
 }