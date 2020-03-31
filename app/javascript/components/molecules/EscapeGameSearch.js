import React, { useState, useEffect } from "react";
import ExploreList from "../atoms/ExploreList";
import debounce from "lodash-es/debounce";

export default ({ authenticity_token }) => {
  const [escapeGames, setEscapeGames] = useState([]);
  const [difficulty, setDifficulty] = useState("");
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);

  const buildParams = () => { 
    if (search === '' && difficulty === '') {
      return ''
    }
    let params = new URLSearchParams({ search, difficulty })
    params.forEach((value, key) => {
      if (!value) {
        params.delete(key)
      } else {
        params.set(key, encodeURIComponent(value))
      }
    })
    return `?${params.toString()}`
  }

  const startSearch = debounce((query) => {
    setLoading(true)
    setSearch(query)
  }, 700);

  useEffect(
    () => {
      fetch(
        `/explore${buildParams()}`,
        {
          headers: {
            Accept: "application/json",
            "Content-Type": "application/json"
          }
        }
      )
        .then(response => response.json())
        .then(data => {
          setEscapeGames(data); // new
          setLoading(false);
        });
      console.log('fresh state')
    },
    [search, difficulty]
  );

  return (
    <div>
      <div className="input-group">
        <div className="input-group-prepend">
          <button
            className="btn btn-outline-secondary dropdown-toggle"
            type="button"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
            Dropdown
          </button>
          <div className="dropdown-menu">
            <a
              className="dropdown-item"
              onClick={() => {
                setDifficulty(0);
                setLoading(true);
              }}
            >
              Beginner
            </a>
            <a
              className="dropdown-item"
              onClick={() => {
                setDifficulty(1);
                setLoading(true);
              }}
            >
              Intermediate
            </a>
            <a
              className="dropdown-item"
              onClick={() => {
                setDifficulty(2);
                setLoading(true);
              }}
            >
              Enthusiast
            </a>
            <div role="separator" className="dropdown-divider"></div>
            <a
              className="dropdown-item"
              onClick={() => {
                setDifficulty("");
                setLoading(true);
              }}
            >
              None
            </a>
          </div>
        </div>
        <input
          type="text"
          className="form-control"
          placeholder="Search for an escape room"
          onChange={e => {
            startSearch(e.target.value)
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
