import React, { Fragment } from "react";

export default ({ avatar, height }) => (
  <Fragment>
    <img
      src={avatar ? avatar : 'https://eu.ui-avatars.com/api/?name=Blacklight'}
      className="user-avatar bg-primary"
      style={height ? {height: height} : {}}
      />
  </Fragment>
);