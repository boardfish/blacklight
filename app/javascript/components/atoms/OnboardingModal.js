import React, { useState, useEffect, Fragment } from "react";
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from "reactstrap";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";

const ModalExample = ({
  className,
  signedIn,
  onboarded,
  authenticityToken,
}) => {
  const [modal, setModal] = useState(false);
  const [nestedModal, setNestedModal] = useState("maintainer");
  const [nestedModalOpen, setNestedModalOpen] = useState(false);
  const [closeAll, setCloseAll] = useState(false);
  const roles = [
    {
      role: "maintainer",
      icon: "lock",
      prefix: "a ",
      description: (
        <Fragment>
          <p>
            Maintainers list the escape rooms that fill the site. If you're
            running an escape room, you'll want this role! If you choose this
            role, you'll be able to list your escape games on the site for
            enthusiasts to find.
          </p>
        </Fragment>
      ),
    },
    {
      role: "enthusiast",
      icon: "lock-open",
      prefix: "an ",
      description: (
        <Fragment>
          <p>
            Enthusiasts use Blacklight to track down their next big adventure!
            As an enthusiast, you can search for escape rooms to tackle, and
            mark them as cleared by clicking the <FontAwesomeIcon icon="lock" />{" "}
            button anywhere you see it. You'll also be able to check out the
            full list of rooms you've cleared, and attach photos to each of your
            experiences to keep those memories under lock and key.
          </p>
        </Fragment>
      ),
    },
    {
      role: "both",
      icon: "unlock",
      prefix: "",
      description: (
        <Fragment>
          <p>
            As a jack of both trades, you'll get to experience the best
            Blacklight has to offer - list escape games that you run, search for
            more to take on, and show both of those records on your public
            profile!
          </p>
        </Fragment>
      ),
    },
  ];

  const toggle = () => setModal(!modal);
  const toggleNested = () => {
    setNestedModalOpen(!nestedModalOpen);
    setCloseAll(false);
  };
  const toggleAll = () => {
    setNestedModalOpen(!nestedModalOpen);
    setCloseAll(true);
  };
  useEffect(() => {
    if (!signedIn || (signedIn && !onboarded)) {
      toggle();
    }
  }, []);

  return (
    <Modal
      isOpen={modal}
      toggle={toggle}
      backdrop={signedIn ? "static" : false}
      className={className}
    >
      <ModalHeader toggle={toggle}>Ready to join us?</ModalHeader>
      <ModalBody>
        {signedIn ? (
          ""
        ) : (
          <Fragment>
            <p>
              To make the best of Blacklight and reveal new escape rooms, it's a
              great idea to make an account! Click the Login button to get
              started.
            </p>
            <p>
              Blacklight members can share their escape room talents with the
              world and explore new escape rooms to take on. And if you own
              escape rooms, you can list them on Blacklight too! It's no mystery
              that joining Blacklight will help you get the best of escape
              rooms.
            </p>
          </Fragment>
        )}
        {signedIn && !onboarded ? (
          <Fragment>
            <p>
              Thanks for signing up to the site! Now, it's time to pick out your
              role. You can change this at any time in your profile.
            </p>
            <ul className="list-unstyled">
              <li>
                <FontAwesomeIcon icon="lock" fixedWidth />
                <b>Maintainers</b> own escape rooms, and list them on the site.
              </li>
              <li>
                <FontAwesomeIcon icon="lock-open" fixedWidth />
                <b>Enthusiasts</b> like to challenge escape rooms, and keep
                track of ones they've cleared.
              </li>
            </ul>
            <div className="btn-group">
              {roles.map(({ role, description, prefix }) => (
                <Fragment>
                  <Button
                    color="success"
                    onClick={() => {
                      setNestedModal(role);
                      toggleNested();
                    }}
                  >
                    Tell me about being {prefix}{role}?
                  </Button>
                  <Modal
                    isOpen={nestedModalOpen && nestedModal === role}
                    toggle={toggleNested}
                    onClosed={closeAll ? toggle : undefined}
                  >
                    <ModalHeader>{role}</ModalHeader>
                    <ModalBody>{description}</ModalBody>
                    <ModalFooter>
                      <Button color="secondary" onClick={toggleNested}>
                        OK cool
                      </Button>{" "}
                      <form class="button_to" method="post" action={`/${role}`}>
                        <input
                          class="btn btn-primary"
                          type="submit"
                          value={`I'm ${prefix}${role}!`}
                        />
                        <input
                          type="hidden"
                          name="authenticity_token"
                          value="KNO6K5kBi6qD+ulQ1HR/9GpGrukxf0mn4PqPBOj1vkO7tvdqErjpyAz+kDzTdlBUAru8fitVl1WAF/A8u7knxg=="
                        />
                      </form>
                    </ModalFooter>
                  </Modal>
                </Fragment>
              ))}
            </div>
          </Fragment>
        ) : (
          ""
        )}
      </ModalBody>
      {!signedIn ? (
        <ModalFooter>
          <Button color="secondary" onClick={toggle}>
            Just browsing, thanks!
          </Button>
          <Button color="primary" onClick={toggle}>
            Sign Up/Log In
          </Button>{" "}
        </ModalFooter>
      ) : (
        ""
      )}
    </Modal>
  );
};

export default ModalExample;
