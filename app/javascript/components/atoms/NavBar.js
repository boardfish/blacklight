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

export default ({ currentPage, isEnthusiast, isMaintainer, loginButton, username, userId }) => {
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
              isEnthusiast
                ? NavbarData.enthusiastLoggedIn.map(({ href, name }) => (
                  <NavItem>
                    <NavLink href={href}>{name}</NavLink>
                  </NavItem>
                ))
                : ""
            }
            {
              isMaintainer
                ? NavbarData.maintainerLoggedIn.map(({ href, name }) => (
                  <NavItem>
                    <NavLink href={href}>{name}</NavLink>
                  </NavItem>
                ))
                : ""
            }
            {NavbarData.alwaysVisible.map(({ href, name }) => (
              <NavItem>
                <NavLink href={href}></NavLink>
              </NavItem>
            ))}
          </Nav>
          {/* No worries here, since loginButton is SSR */}
          <Nav>
            {username ? <UncontrolledDropdown nav inNavbar>
                <DropdownToggle nav caret>
                  {username}
                </DropdownToggle>
                <DropdownMenu right>
                  <DropdownItem href={`/users/${userId}/edit`}>
                    Account
                  </DropdownItem>
                  <DropdownItem divider />
                  <DropdownItem dangerouslySetInnerHTML={{ __html: loginButton }} >
                  </DropdownItem>
                </DropdownMenu>
              </UncontrolledDropdown>
              : <div dangerouslySetInnerHTML={{ __html: loginButton }} />
            }
          </Nav>
        </Collapse>
      </Navbar>
    </div>
  );
}