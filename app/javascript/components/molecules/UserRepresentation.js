import React, { useState } from "react";
import Avatar from "../atoms/Avatar";
import moment from "moment";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

export default ({ user, avatar }) => {
  const [showMore, setShowMore] = useState(false);
  return (
    <a
      href={`/users/${user.id}`}
      className={`user-representation${showMore ? " bg-light" : ""}`}
      onMouseOver={() => setShowMore(true)}
      onMouseOut={() => setShowMore(false)}
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
          {user.bio ? <span className={`${showMore ? "" : "d-none"}`}> | {user.bio}</span> : ""}
          {user.website ? <span className={`${showMore ? "" : "d-none"}`}>
            {" | "}<FontAwesomeIcon icon='globe' />{" "}
            {user.website}
            </span> : ''}
        </p>
      </div>
    </a>
  );
};
