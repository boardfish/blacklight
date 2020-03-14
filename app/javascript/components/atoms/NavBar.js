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
  NavbarText,
  Button
} from 'reactstrap';

import NavbarData from '../../data/navbar.json'

export default ({ currentPage, loggedIn, loginButton }) => {
  const [isOpen, setIsOpen] = useState(false);

  const toggle = () => setIsOpen(!isOpen);

  return (
    <div>
      <Navbar color="light" light expand="md">
        <NavbarBrand href="/">Blacklight</NavbarBrand>
        <NavbarToggler onClick={toggle} />
        <Collapse isOpen={isOpen} navbar>
          <Nav className="mr-auto" navbar>
            {
              loggedIn
                ? NavbarData.enthusiastLoggedIn.map(({ href, name }) => (
                  <NavItem>
                    <NavLink href={href}>{name}</NavLink>
                  </NavItem>
                ))
                : ""
            }
            {NavbarData.alwaysVisible.map(({ href, name }) => (
              <NavItem>
                <NavLink href={href}>{name}</NavLink>
              </NavItem>
            ))}
            <UncontrolledDropdown nav inNavbar>
              <DropdownToggle nav caret>
                Options
              </DropdownToggle>
              <DropdownMenu right>
                <DropdownItem>
                  Option 1
                </DropdownItem>
                <DropdownItem>
                  Option 2
                </DropdownItem>
                <DropdownItem divider />
                <DropdownItem>
                  Reset
                </DropdownItem>
              </DropdownMenu>
            </UncontrolledDropdown>
          </Nav>
          {/* No worries here, since loginButton is SSR */}
          <div dangerouslySetInnerHTML={{ __html: loginButton }} />
        </Collapse>
      </Navbar>
    </div>
  );
}