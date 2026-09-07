import React, { useState } from 'react';
import fs from 'fs';
import path from 'path';
import {
  render,
  fireEvent,
  screen,
  waitFor,
  cleanup,
} from '@testing-library/react';
import '@testing-library/jest-dom';
import {
  Dropdown,
  DropdownItem,
  DropdownToggle,
  DropdownGroup,
} from '@patternfly/react-core/deprecated';
import { ActionButtons } from 'foremanReact/components/PF4/TableIndexPage/ActionButtons';
import DocumentationLink from 'foremanReact/components/PF4/DocumentationLink';
import { installDocumentationHiding } from './hideDocumentation';

const styles = fs
  .readFileSync(
    path.join(
      __dirname,
      '../../app/assets/stylesheets/foreman_theme_satellite/documentation.scss'
    ),
    'utf8'
  )
  .replace(/^\/\/.*$/gm, '');
let installation;

beforeEach(() => {
  const style = document.createElement('style');
  style.textContent = styles;
  style.id = 'documentation-test-style';
  document.head.appendChild(style);
  installation = installDocumentationHiding(document);
});
afterEach(() => {
  installation.disconnect();
  cleanup();
  document.getElementById('documentation-test-style').remove();
});

// Use the same grouped PatternFly menu and documentation component as bookmarks.
const BookmarksMenu = () => {
  const [isOpen, setOpen] = useState(false);
  return (
    <Dropdown
      ouiaId="test-bookmarks"
      isOpen={isOpen}
      isGrouped
      toggle={
        <DropdownToggle onToggle={(_event, open) => setOpen(open)}>
          Bookmarks
        </DropdownToggle>
      }
    >
      <DropdownGroup>
        <DocumentationLink href="/links/manual" />
        <DropdownItem ouiaId="saved-bookmark" href="/hosts?search=saved">
          Saved bookmark
        </DropdownItem>
        <DropdownItem ouiaId="disabled-bookmark" isDisabled>
          Unavailable bookmark
        </DropdownItem>
        <DropdownItem ouiaId="manage-bookmarks">Manage bookmarks</DropdownItem>
      </DropdownGroup>
    </Dropdown>
  );
};

const press = (element, key) =>
  fireEvent.keyDown(element, {
    key,
    keyCode: {
      ArrowDown: 40,
      ArrowUp: 38,
      Home: 36,
      End: 35,
      Enter: 13,
      Escape: 27,
    }[key],
  });

test('table dropdown skips documentation and wraps between functional actions', async () => {
  const refresh = jest.fn();
  render(
    <ActionButtons
      buttons={[
        { title: 'Create', action: { href: '/hosts/new' } },
        { title: 'Export', action: { href: '/hosts.csv' } },
        { title: 'Documentation', action: { href: '/hosts/help' } },
        { title: 'Refresh', action: { onClick: refresh } },
      ]}
    />
  );
  const toggle = screen.getByRole('button', { name: 'toggle action dropdown' });
  toggle.focus();
  press(toggle, 'Enter');
  const first = await screen.findByRole('menuitem', { name: 'Export' });
  const last = screen.getByRole('menuitem', { name: 'Refresh' });
  await waitFor(() => expect(first).toHaveFocus());
  await waitFor(() =>
    expect(
      screen.queryByRole('menuitem', { name: 'Documentation' })
    ).not.toBeInTheDocument()
  );
  press(first, 'ArrowDown');
  expect(last).toHaveFocus();
  press(last, 'ArrowDown');
  expect(first).toHaveFocus();
  press(first, 'ArrowUp');
  expect(last).toHaveFocus();
  press(last, 'Home');
  expect(first).toHaveFocus();
  press(first, 'End');
  expect(last).toHaveFocus();
  press(last, 'Enter');
  expect(refresh).toHaveBeenCalledTimes(1);
  press(last, 'Escape');
  await waitFor(() => expect(toggle).toHaveFocus());
  expect(toggle).toHaveAttribute('aria-expanded', 'false');
});

test.each(['Enter', ' '])(
  'opening with %s skips a hidden first item',
  async (key) => {
    render(<BookmarksMenu />);
    const toggle = screen.getByRole('button', { name: 'Bookmarks' });
    toggle.focus();
    press(toggle, key);
    const first = await screen.findByRole('menuitem', {
      name: 'Saved bookmark',
    });
    await waitFor(() => expect(first).toHaveFocus());
    expect(
      screen.queryByRole('menuitem', { name: 'Documentation' })
    ).not.toBeInTheDocument();
    press(first, 'ArrowDown');
    expect(
      screen.getByRole('menuitem', { name: 'Manage bookmarks' })
    ).toHaveFocus();
    press(document.activeElement, 'ArrowDown');
    expect(first).toHaveFocus();
  }
);

test('ArrowUp from the open toggle focuses the last available action', async () => {
  render(<BookmarksMenu />);
  const toggle = screen.getByRole('button', { name: 'Bookmarks' });
  toggle.focus();
  fireEvent.click(toggle);
  await waitFor(() =>
    expect(
      screen.getByRole('menuitem', { name: 'Saved bookmark' })
    ).toHaveFocus()
  );
  toggle.focus();
  press(toggle, 'ArrowUp');
  const last = await screen.findByRole('menuitem', {
    name: 'Manage bookmarks',
  });
  await waitFor(() => expect(last).toHaveFocus());
});

test('mouse opening also avoids a hidden initial focus target', async () => {
  render(<BookmarksMenu />);
  fireEvent.click(screen.getByRole('button', { name: 'Bookmarks' }));
  await waitFor(() =>
    expect(
      screen.getByRole('menuitem', { name: 'Saved bookmark' })
    ).toHaveFocus()
  );
});

test('menus without documentation retain native keyboard handling', async () => {
  render(
    <ActionButtons
      buttons={[
        { title: 'Create', action: {} },
        { title: 'Export', action: { href: '/hosts.csv' } },
        { title: 'Refresh', action: {} },
      ]}
    />
  );
  const toggle = screen.getByRole('button', { name: 'toggle action dropdown' });
  fireEvent.click(toggle);
  const first = await screen.findByRole('menuitem', { name: 'Export' });
  first.focus();
  press(first, 'ArrowDown');
  expect(screen.getByRole('menuitem', { name: 'Refresh' })).toHaveFocus();
});

test('disconnect removes the theme keyboard listener', async () => {
  render(<BookmarksMenu />);
  fireEvent.click(screen.getByRole('button', { name: 'Bookmarks' }));
  const first = await screen.findByRole('menuitem', { name: 'Saved bookmark' });
  await waitFor(() => expect(first).toHaveFocus());
  installation.disconnect();
  const bubble = jest.fn();
  document.addEventListener('keydown', bubble);
  press(first, 'Home');
  expect(bubble).toHaveBeenCalled();
  document.removeEventListener('keydown', bubble);
});

test('a documentation-only menu keeps focus on its toggle and can close', async () => {
  render(
    <ActionButtons
      buttons={[
        { title: 'Create', action: {} },
        { title: 'Documentation', action: { href: '/hosts/help' } },
      ]}
    />
  );
  const toggle = screen.getByRole('button', { name: 'toggle action dropdown' });
  toggle.focus();
  press(toggle, 'Enter');
  await waitFor(() => expect(toggle).toHaveAttribute('aria-expanded', 'true'));
  await waitFor(() =>
    expect(screen.queryByRole('menuitem')).not.toBeInTheDocument()
  );
  press(toggle, 'ArrowDown');
  expect(toggle).toHaveFocus();
  press(toggle, 'Escape');
  expect(toggle).toHaveAttribute('aria-expanded', 'false');
});
