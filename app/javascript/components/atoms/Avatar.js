import React, { Fragment } from "react";

export default ({ avatar, height, className, onClick }) => (
  <Fragment>
    <img
      src={avatar ? avatar : 'https://eu.ui-avatars.com/api/?name=Blacklight'}
      className={`user-avatar bg-primary ${className}`}
      style={height ? {height: height} : {}}
      onClick={onClick}
      />
  </Fragment>
);