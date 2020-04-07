import React, { useState, Fragment } from "react";
import PlacesAutocomplete, {
  geocodeByAddress,
  getLatLng,
} from "react-places-autocomplete";

export default () => {
  const [address, setAddress] = useState("");
  const [selectedPlace, setSelectedPlace] = useState({
    lat: "",
    lng: "",
    placeId: "",
  });

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
      <PlacesAutocomplete
        value={address}
        onChange={(newAddress) => setAddress(newAddress)}
        onSelect={handleSelect}
      >
        {({ getInputProps, suggestions, getSuggestionItemProps, loading }) => (
          <div>
            <input
              {...getInputProps({
                placeholder: "Search Places ...",
                className: "location-search-input",
              })}
            />
            <div className="autocomplete-dropdown-container">
              {loading && <div>Loading...</div>}
              {suggestions.map((suggestion) => {
                const className = suggestion.active
                  ? "suggestion-item--active"
                  : "suggestion-item";
                // inline style for demonstration purpose
                const style = suggestion.active
                  ? { backgroundColor: "#fafafa", cursor: "pointer" }
                  : { backgroundColor: "#ffffff", cursor: "pointer" };
                return (
                  <div
                    {...getSuggestionItemProps(suggestion, {
                      className,
                      style,
                    })}
                  >
                    <span>{suggestion.description}</span>
                  </div>
                );
              })}
            </div>
          </div>
        )}
      </PlacesAutocomplete>
    </Fragment>
  );
};
