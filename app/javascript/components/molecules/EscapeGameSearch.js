import React, { useState, useEffect } from "react";
import ExploreList from "../atoms/ExploreList";
import debounce from "lodash-es/debounce";

export default ({ authenticity_token }) => {
  const [escapeGames, setEscapeGames] = useState([]);
  const [difficulty, setDifficulty] = useState('');
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(true);

  const fetchEscapeGames = debounce(function() {
    setLoading(true);
    fetch(`/explore${search ? `?q=${encodeURIComponent(search)}&difficulty=${difficulty}` : ""}`, {
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      }
    })
      .then(resp => resp.json()) // Transform the data into json
      .then(function(data) {
        setEscapeGames(data);
        setLoading(false)
      });
  }, 2000);

  useEffect(fetchEscapeGames, [search, difficulty]);

  return (
    <div>
      <div className="input-group">
        <div className="input-group-prepend">
          <button className="btn btn-outline-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Dropdown</button>
          <div className="dropdown-menu">
            <a className="dropdown-item" onClick={() => setDifficulty('beginner')}>Beginner</a>
            <a className="dropdown-item" onClick={() => setDifficulty('intermediate')}>Intermediate</a>
            <a className="dropdown-item" onClick={() => setDifficulty('enthusiast')}>Enthusiast</a>
            <div role="separator" className="dropdown-divider"></div>
            <a className="dropdown-item" onClick={() => setDifficulty(null)}>None</a>
          </div>
        </div>
        <input
          type="text"
          className="form-control"
          placeholder="Search for an escape room"
          onChange={e => {
            setSearch(e.target.value)
          }}
        />
      </div>
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
