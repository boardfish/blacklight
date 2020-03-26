import React, { useState, useEffect } from "react";
import SearchBar from "../atoms/SearchBar";
import ExploreList from "../atoms/ExploreList";
import throttle from "lodash-es/throttle";

export default ({ authenticity_token }) => {
  const [escapeGames, setEscapeGames] = useState([]);

  const fetchEscapeGames = throttle(function(search) {
    fetch(`/explore${search ? `?q=${encodeURIComponent(search)}` : ""}`, {
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      }
    })
      .then(resp => resp.json()) // Transform the data into json
      .then(function(data) {
        setEscapeGames(data);
      });
  }, 1000);

  return (
    <div>
      <input
        type="text"
        className="form-control"
        onChange={e => {
          fetchEscapeGames(e.target.value);
        }}
      />
      <p>
        {escapeGames.length} result{escapeGames.length == 1 ? "" : "s"}
      </p>
      <ExploreList
        escapeGames={escapeGames}
        authenticity_token={authenticity_token}
      />
    </div>
  );
};
