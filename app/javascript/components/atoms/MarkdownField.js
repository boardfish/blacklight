import React, { useState } from "react";
import { FormGroup, Input, Label, Col } from "reactstrap";
import ReactMarkdown from "react-markdown";

export default ({ initialContent }) => {
  const [previewSource, setPreviewSource] = useState(initialContent || "");
  return (
    <FormGroup row>
      <Label
        className="col-form-label col-sm-2 text-right"
        for="escape_game[description"
      >
        Description<br/>
        <small className="text-muted">You can use <a href="https://commonmark.org/help/" rel="noopener" target="_blank">Markdown!</a> Use no more than 1000 characters.</small>
      </Label>
      <Col sm="10" className="d-flex">
        <Input
          type="textarea"
          rows={14}
          name="escape_game[description]"
          className="flex-grow-1"
          style={{ flexBasis: "50%" }}
          onChange={(e) => setPreviewSource(e.target.value)}
          value={previewSource}
        ></Input>
        <ReactMarkdown
          source={previewSource}
          skipHtml
          className="flex-grow-1 ml-1 p-1 markdown-preview"
        />
      </Col>
    </FormGroup>
  );
};
