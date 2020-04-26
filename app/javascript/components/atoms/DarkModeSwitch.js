// Dark mode switch
// Implementation heavily inspired by
// https://github.com/coliff/dark-mode-switch/blob/master/dark-mode-switch.js
import React, { Fragment, useEffect, useState } from "react";
import { CustomInput } from "reactstrap";
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

export default () => {
  const [enabled, enable] = useState(false);
  useEffect(() => {
    enable(localStorage.getItem("darkMode") === "true");
  }, []);
  useEffect(() => {
    localStorage.setItem("darkMode", enabled);
    enabled
      ? document.body.setAttribute("data-theme", "dark")
      : document.body.removeAttribute("data-theme");
  }, [enabled]);
  return (
    <CustomInput
      type="switch"
      id="darkModeSwitch"
      checked={enabled}
      onChange={(e) => {
        enable(e.target.checked);
        console.log(e.target.checked);
      }}
      label={
        <FontAwesomeIcon icon={enabled ? 'sun' : 'moon'} />
      }
      className='mr-1'
    />
  );
};
