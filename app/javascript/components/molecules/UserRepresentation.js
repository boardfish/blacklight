import React, { useState } from "react";
import Avatar from "../atoms/Avatar";
import moment from "moment";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

export default ({ user, avatar, expandedView }) => {
  return (
    <a
      href={`/users/${user.id}`}
      className="user-representation"
    >
      <Avatar avatar={avatar} />
      <div className="ml-2">
        <p className="h4">{user.nickname}</p>
        <p className="small text-muted">
          {user.maintainer ? (
            <FontAwesomeIcon icon="user-lock" />
          ) : (
            <FontAwesomeIcon icon="user" />
          )}{" "}
          Joined {moment(user.created_at).fromNow()}
          {expandedView && user.bio ? <span> | {user.bio}</span> : ""}
          {expandedView && user.website ? (
            <span>
              {" | "}
              <FontAwesomeIcon icon="globe" /> {user.website}
            </span>
          ) : (
            ""
          )}
        </p>
      </div>
    </a>
  );
};
