import debounce from "lodash-es/debounce";
import React, { useEffect, useState } from "react";
import ExploreList from "../atoms/ExploreList";
import PlacesAutocomplete, {
  geocodeByAddress,
  getLatLng,
} from "react-places-autocomplete";

export default ({ authenticity_token }) => {
  const [escapeGames, setEscapeGames] = useState([]);
  const [difficulty, setDifficulty] = useState("");
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);
  const [location, setLocation] = useState({ lat: null, lng: null });
  const [placesSearch, setPlacesSearch] = useState("");

  const buildParams = () => {
    if (search === "" && difficulty === "") {
      return "";
    }
    let params = new URLSearchParams({ search, difficulty });
    params.forEach((value, key) => {
      if (!value) {
        params.delete(key);
      } else {
        params.set(key, encodeURIComponent(value));
      }
    });
    return `?${params.toString()}`;
  };

  const startSearch = debounce((query) => {
    setLoading(true);
    setSearch(query);
  }, 700);

  const filterNearMe = (escapeGames) => {
    if (location.lat === null) {
      return 0;
    }
    const map = new google.maps.Map(document.getElementById("map-canvas"), {});
    const service = new google.maps.places.PlacesService(map);
    service.nearbySearch(
      {
        location,
        radius: 5000,
        keyword: "escape",
      },
      (results, status) => {
        const ids = results.map((place) => place.place_id);
        setEscapeGames(
          escapeGames.filter(({ escape_game }) => {
            return ids.includes(escape_game.place_id);
          })
        );
      }
    );
  };

  useEffect(() => {
    fetch(`/explore${buildParams()}`, {
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        setEscapeGames(data);
        filterNearMe(data);
        setLoading(false);
      });
  }, [search, difficulty, location]);

  return (
    <div>
      <div className="d-none" id="map-canvas"></div>
      <div className="input-group">
        <div className="input-group-prepend">
          <button
            className="btn btn-outline-secondary dropdown-toggle"
            type="button"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
            Filters
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
            <a
              className="dropdown-item"
              onClick={() => {
                window.navigator.geolocation.getCurrentPosition(
                  (position) =>
                    setLocation({
                      lat: position.coords.latitude,
                      lng: position.coords.longitude,
                    }),
                  () => setLocation({ lat: null, lng: null })
                );
                setLoading(true);
              }}
            >
              Near me (5km)
            </a>
            <div role="separator" className="dropdown-divider"></div>
            <a
              className="dropdown-item"
              onClick={() => {
                setDifficulty("");
                setLocation({ lat: null, lng: null });
                setLoading(true);
              }}
            >
              Clear filters
            </a>
          </div>
        </div>
        <input
          type="text"
          className="form-control"
          placeholder="Search for an escape room"
          onChange={(e) => {
            startSearch(e.target.value);
          }}
        />
      </div>
      <div className="form-group row mt-2">
        <label className="col-form-label col-sm-2 text-right">
          Near...
        </label>
        <PlacesAutocomplete
          value={placesSearch}
          onChange={(newPlacesSearch) => setPlacesSearch(newPlacesSearch)}
          onSelect={(address) => {
            geocodeByAddress(address)
              .then((results) => getLatLng(results[0]))
              .then((latLng) => setLocation({ ...latLng }))
              .catch((error) => console.error("Error", error));
          }}
        >
          {({
            getInputProps,
            suggestions,
            getSuggestionItemProps,
            loading,
          }) => (
            <div className="col-sm-10">
              <div className="d-flex">
                <input
                  {...getInputProps({
                    placeholder: "Search Google Maps...",
                    className: "form-control flex-grow-1",
                  })}
                />
              </div>
              <ul className="list-group">
                {loading && <li className="list-group-item">Loading...</li>}
                {suggestions.map((suggestion) => {
                  const className = suggestion.active
                    ? "list-group-item bg-primary text-light"
                    : "list-group-item";
                  const style = { cursor: "pointer" };
                  return (
                    <li
                      {...getSuggestionItemProps(suggestion, {
                        className,
                        style,
                      })}
                    >
                      <span>{suggestion.description}</span>
                    </li>
                  );
                })}
              </ul>
            </div>
          )}
        </PlacesAutocomplete>
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
