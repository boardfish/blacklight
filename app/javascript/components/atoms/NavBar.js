import React, { useState } from "react"

import {
  Collapse,
  Navbar,
  NavbarToggler,
  NavbarBrand,
  Nav,
  NavItem,
  NavLink,
  UncontrolledDropdown,
  DropdownToggle,
  DropdownMenu,
  DropdownItem,
  Button,
} from 'reactstrap';

import NavbarData from '../../data/navbar.json'
import DarkModeSwitch from "./DarkModeSwitch";
import LoginButton from "./LoginButton";

export default ({ isEnthusiast, isMaintainer, authenticityToken, username, userId, logoPath }) => {
  const [isOpen, setIsOpen] = useState(false);

  const toggle = () => setIsOpen(!isOpen);

  return (
    <div>
      <Navbar expand="md" fixed="top">
        <NavbarBrand href="/" className="d-flex align-items-center">
          <img src={logoPath}  style={{maxHeight: '1em' }}/>
          <span className="ml-1">Blacklight</span>
        </NavbarBrand>
        <NavbarToggler onClick={toggle} />
        <Collapse isOpen={isOpen} navbar>
          <Nav className="mr-auto text-center" navbar>
            {
              isEnthusiast
                ? NavbarData.enthusiastLoggedIn.map(({ href, name }, index) => (
                  <NavItem key={index}>
                    <NavLink href={href}>{name}</NavLink>
                  </NavItem>
                ))
                : ""
            }
            {
              isMaintainer
                ? NavbarData.maintainerLoggedIn.map(({ href, name }, index) => (
                  <NavItem key={index}>
                    <NavLink href={href}>{name}</NavLink>
                  </NavItem>
                ))
                : ""
            }
            {NavbarData.alwaysVisible.map(({ href, name }, index) => (
              <NavItem key={index}>
                <NavLink href={href}></NavLink>
              </NavItem>
            ))}
          </Nav>
          {/* No worries here, since loginButton is SSR */}
          <Nav className="d-flex justify-content-center align-items-center">
            <DarkModeSwitch />
            {username ? <UncontrolledDropdown nav inNavbar>
                <DropdownToggle nav caret>
                  {username}
                </DropdownToggle>
                <DropdownMenu right>
                  <DropdownItem href={`/users/${userId}/edit`}>
                    Account
                  </DropdownItem>
                  <DropdownItem divider />
                  <DropdownItem>
                    <Button href='/sign_out' color='primary'>Log Out</Button>
                  </DropdownItem>
                </DropdownMenu>
              </UncontrolledDropdown>
              : <LoginButton authenticityToken={authenticityToken} />
            }
          </Nav>
        </Collapse>
      </Navbar>
    </div>
  );
}