import React, { useState, useEffect } from "react";
import ExploreList from "../atoms/ExploreList";
import throttle from "lodash-es/throttle";

export default ({ authenticity_token }) => {
  const [escapeGames, setEscapeGames] = useState([]);
  const [loading, setLoading] = useState(true);

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
        setLoading(false);
      });
  }, 1000);
  useEffect(() => fetchEscapeGames(""), []);

  return (
    <div>
      <input
        type="text"
        className="form-control"
        placeholder="Search for an escape room"
        onChange={e => {
          setLoading(true);
          fetchEscapeGames(e.target.value);
        }}
      />
      {loading ? (
        <p>Loading...</p>
      ) : (
        <p>
          {escapeGames.length} result{escapeGames.length == 1 ? "" : "s"}
        </p>
      )}
      <ExploreList
        escapeGames={escapeGames}
        authenticity_token={authenticity_token}
      />
    </div>
  );
};
