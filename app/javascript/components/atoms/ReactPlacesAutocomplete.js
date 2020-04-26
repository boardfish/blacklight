import React, { useState, Fragment } from "react";
import PlacesAutocomplete, {
  geocodeByAddress,
  getLatLng,
} from "react-places-autocomplete";

export default ({ initialPlace }) => {
  const [address, setAddress] = useState("");
  const [selectedPlace, setSelectedPlace] = useState(initialPlace);

  const getGoogleMapsURLFor = ({ lat, lng, placeId }) => {
    return `https://www.google.com/maps/search/?api=1&query=${lat},${lng}&query_place_id=${placeId}`;
  };

  const handleSelect = (address, placeId) => {
    geocodeByAddress(address)
      .then((results) => getLatLng(results[0]))
      .then((latLng) => setSelectedPlace({ ...latLng, placeId }))
      .catch((error) => console.error("Error", error));
  };
  return (
    <Fragment>
      <input
        type="hidden"
        name="escape_game[latitude]"
        value={selectedPlace.lat}
        readOnly
      />
      <input
        type="hidden"
        name="escape_game[longitude]"
        value={selectedPlace.lng}
        readOnly
      />
      <input
        type="hidden"
        name="escape_game[place_id]"
        value={selectedPlace.placeId}
        readOnly
      />
      <div className="form-group row">
        <label className="col-form-label col-sm-2 text-right">
          Google Maps Place
        </label>
        <PlacesAutocomplete
          value={address}
          onChange={(newAddress) => setAddress(newAddress)}
          onSelect={handleSelect}
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
                <button
                  className={`btn btn-secondary ml-2 ${
                    selectedPlace.placeId ? "" : "d-none"
                  }`}
                  type="button"
                  onClick={() =>
                    setSelectedPlace({
                      lat: "",
                      lng: "",
                      placeId: "",
                    })
                  }
                >
                  ×
                </button>
              </div>
              {selectedPlace.placeId ? (
                <p>
                  <small className="text-muted">
                    Click{" "}
                    <a target="_blank" rel="noopener" href={getGoogleMapsURLFor(selectedPlace)}>this link</a>{" "}
                    to show the selected Google Maps Place. You can use this to verify that it's correct.
                  </small>
                </p>
              ) : (
                ""
              )}
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
    </Fragment>
  );
};
