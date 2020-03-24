import React, { useState, useEffect } from "react";
import SearchBar from "../atoms/SearchBar";
import ExploreList from "../atoms/ExploreList";

export default () => {
  const [escapeGames, setEscapeGames] = useState([]);
  const [inputValue, setInputValue] = useState('');

  const fetchEscapeGames = (search) => {
    fetch(`/explore${search ? `?q=${encodeURIComponent(search)}` : ''}`, {
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      }
    })
      .then(resp => resp.json()) // Transform the data into json
      .then(function(data) {
        setEscapeGames(data);
      });
  };

  useEffect(() => {
    fetchEscapeGames()
  }, []);

  return (
    <div>
      <SearchBar search={inputValue} onChange={(e) => {
        setInputValue(e.target.value)
        fetchEscapeGames(e.target.value)
        }} />
      <ExploreList escapeGames={escapeGames} />
    </div>
  );
};
