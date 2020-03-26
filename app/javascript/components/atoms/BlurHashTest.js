import React, { useState } from "react";
import { Blurhash } from "react-blurhash";

// imageRatio = height / width
export default ({ blurhash, src, blurhashOpts, className }) => {
  const [loaded, setLoaded] = useState(false);
  return (
    <div
      src={src}
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
        className={(loaded ? "blurdash-fadeout " : "") + className}
        {...blurhashOpts}
      />
        ) : ''
      }
    </div>
  );
};
