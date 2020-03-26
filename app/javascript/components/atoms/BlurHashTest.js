import React, { useState } from "react";
import { Blurhash } from "react-blurhash";

// imageRatio = height / width
export default ({ blurhash, src, blurhashOpts, className, children }) => {
  const [loaded, setLoaded] = useState(false);
  return (
    <div
      src={src}
      className="d-flex"
      style={{
        background: `url(${src}) no-repeat center`,
        backgroundSize: 'cover',
        height: '200px', maxHeight:'200px'}}>
      <img
        src={src}
        className='d-none'
        onLoad={() => { setTimeout(() => { setLoaded(true) }, 100)}}
      />
      {
        blurhash && blurhash.length >= 6 ? (
      <Blurhash
        hash={blurhash}
        className={"position-absolute " + (loaded ? "blurdash-fadeout " : "") + className}
        {...blurhashOpts}
      />
        ) : ''
      }
      {children}
    </div>
  );
};
