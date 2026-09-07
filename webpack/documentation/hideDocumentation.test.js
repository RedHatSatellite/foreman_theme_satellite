import assert from 'assert';
import fs from 'fs';
import path from 'path';
import {
  hideDocumentation,
  hiddenClass,
  normalizeSatelliteDocumentation,
  installDocumentationHiding,
} from './hideDocumentation';

const styles = fs
  .readFileSync(
    path.join(
      __dirname,
      '../../app/assets/stylesheets/foreman_theme_satellite/documentation.scss'
    ),
    'utf8'
  )
  .replace(/^\/\/.*$/gm, '');
const createDOM = (html) => {
  document.head.innerHTML = `<style>${styles}</style>`;
  document.body.innerHTML = html;
};
afterEach(() => {
  document.head.innerHTML = '';
  document.body.innerHTML = '';
  jest.restoreAllMocks();
});

test('hides documentation controls but preserves inline links, sentences and actions', async () => {
  createDOM(
    `<div class="foreman-empty-state"><div><div class="empty-state-description">Description</div><span id="sentence">See <a href="/links/manual">documentation</a></span></div><ul id="permissions"><li>view_hosts</li></ul><a id="create" href="/hosts/new">Create</a></div><ul><li id="docs"><button data-ouia-component-id="doc-url-dropdown">Docs</button></li><li id="support"><a href="/links/support">Support</a></li></ul>`
  );
  const doc = document;
  hideDocumentation(doc);
  assert(doc.querySelector('#docs button').classList.contains(hiddenClass));
  assert(!doc.getElementById('docs').classList.contains(hiddenClass));
  ['sentence', 'permissions', 'create', 'support'].forEach((id) => {
    assert(!doc.getElementById(id).classList.contains(hiddenClass));
  });
  assert.equal(
    doc.querySelector('#sentence a').getAttribute('href'),
    '/links/manual'
  );
});

test('handles React node reuse without leaving functional links hidden', async () => {
  createDOM(
    '<a data-ouia-component-id="audits-documentation-button" href="/links/manual">Documentation</a>'
  );
  const doc = document;
  hideDocumentation(doc);
  const link = doc.querySelector('a');
  assert(link.classList.contains(hiddenClass));
  link.setAttribute('data-ouia-component-id', 'create-host');
  link.href = '/hosts/new';
  hideDocumentation(doc);
  assert(!link.classList.contains(hiddenClass));
});

test('observes late documentation buttons and reused control identifiers', async () => {
  createDOM('<main></main>');
  const doc = document;
  const observer = installDocumentationHiding(doc);
  const link = doc.createElement('a');
  link.href = '/links/docs/Managing_Hosts';
  link.setAttribute(
    'data-ouia-component-id',
    'register-host-documentation-button'
  );
  doc.body.appendChild(link);
  await new Promise((resolve) => setTimeout(resolve, 60));
  assert(link.classList.contains(hiddenClass));
  link.setAttribute('data-ouia-component-id', 'create-host');
  link.href = '/hosts/new';
  await new Promise((resolve) => setTimeout(resolve, 60));
  assert(!link.classList.contains(hiddenClass));
  observer.disconnect();
});

test('hides localized table documentation without hiding other dropdown actions', async () => {
  createDOM(
    '<div data-ouia-component-id="action-buttons-dropdown"><ul><li id="docs"><a data-ouia-component-id="Dokumentace-dropdown-item" href="/hosts/help">Dokumentace</a></li><li id="export"><a data-ouia-component-id="Export-dropdown-item" href="/hosts.csv">Export</a></li></ul></div>'
  );
  hideDocumentation(document, 'Dokumentace');
  assert(document.querySelector('#docs a').classList.contains(hiddenClass));
  assert(!document.getElementById('export').classList.contains(hiddenClass));
});

test('welcome sentences keep their documentation links', async () => {
  assert.doesNotMatch(styles, /a\[href/);
  createDOM(`
    <div class="pf-v5-c-empty-state__body">
      <div class="empty-state-description">No discovered hosts found in this context.</div>
      <span id="discovered">For more information please see <a href="/links/plugin_manual?name=foreman_discovery">documentation</a></span>
    </div>
    <div class="empty-state-description" id="reports">If you wish to configure Puppet to forward its reports to Foreman, please follow <a href="/links/manual/3.5.4PuppetReports">setting up reporting</a> and <a href="/links/wiki/Mail_Notifications">e-mail reporting</a></div>
  `);
  const doc = document;
  hideDocumentation(doc, 'Documentation');
  normalizeSatelliteDocumentation(doc, '/links/manual');
  assert.equal(
    doc.querySelector('#discovered').textContent,
    'For more information please see documentation'
  );
  assert.equal(
    doc.querySelector('#reports').textContent,
    'If you wish to configure Puppet to forward its reports to Foreman, please follow setting up reporting and e-mail reporting'
  );
  doc.querySelectorAll('#discovered a, #reports a').forEach((link) => {
    assert.notEqual(window.getComputedStyle(link).display, 'none');
  });
});

test('CSS and JavaScript leave inline documentation links visible', async () => {
  const urls = [
    '/links/manual',
    '/links/docs/Managing_Hosts',
    '/links/plugin_manual',
    '/links/wiki',
    'https://docs.redhat.com/en/documentation',
    'https://docs.theforeman.org/',
  ];
  createDOM(
    urls.map((url) => `<p>See <a href="${url}">documentation</a>.</p>`).join('')
  );
  hideDocumentation(document);
  document.querySelectorAll('a').forEach((link) => {
    assert.notEqual(window.getComputedStyle(link).display, 'none');
    assert.notEqual(
      window.getComputedStyle(link.parentElement).display,
      'none'
    );
  });
});

test('hides only the upgrade documentation button and preserves card content and helper', async () => {
  createDOM(
    '<section id="card"><p id="description">Upgrade instructions</p><a data-ouia-component-id="upgrade-docs-button" href="/links/upgrade?section=documentation">Documentation</a><a id="helper" data-ouia-component-id="upgrade-helper-button" href="/links/upgrade?section=helper">Upgrade helper</a></section>'
  );
  hideDocumentation(document);
  const style = (selector) =>
    window.getComputedStyle(document.querySelector(selector)).display;
  assert.equal(style('[data-ouia-component-id="upgrade-docs-button"]'), 'none');
  ['#card', '#description', '#helper'].forEach((selector) => {
    assert.notEqual(style(selector), 'none');
  });
});

test('direct Satellite links use the landing redirect while other products and support remain unchanged', async () => {
  const satelliteUrls = [
    'https://docs.redhat.com/en/documentation/red_hat_satellite/6.19/managing_hosts/index#chapter',
    'https://access.redhat.com/documentation/en-us/red_hat_satellite/6.10/html/guide/chapter',
    'https://offline.example/docs/en/documentation/red_hat_satellite/6.19/guide',
    'https://access.redhat.com/solutions/satellite6-tasks#task',
    'https://access.redhat.com/articles/1586183',
  ];
  const preserved = [
    'https://docs.redhat.com/en/documentation/subscription_central/1/guide',
    'https://docs.ansible.com/ansible/latest/guide',
    'https://access.redhat.com/products/red-hat-satellite#get-support',
    'https://access.redhat.com/labs/satelliteupgradehelper',
  ];
  createDOM(
    [...satelliteUrls, ...preserved]
      .map((url) => `<a href="${url}">Documentation</a>`)
      .join('')
  );
  normalizeSatelliteDocumentation(document, '/prefix/links/manual');
  const links = [...document.querySelectorAll('a')];
  links.slice(0, satelliteUrls.length).forEach((link) => {
    assert.equal(link.getAttribute('href'), '/prefix/links/manual');
    assert.notEqual(window.getComputedStyle(link).display, 'none');
  });
  links
    .slice(satelliteUrls.length)
    .forEach((link, i) => assert.equal(link.href, preserved[i]));
});

test('normalizes late Satellite links and React href updates', async () => {
  createDOM('<main></main>');
  const observer = installDocumentationHiding(
    document,
    'Documentation',
    '/prefix/links/manual'
  );
  const link = document.createElement('a');
  link.href =
    'https://docs.redhat.com/en/documentation/red_hat_satellite/6.19/guide';
  document.body.appendChild(link);
  await new Promise((resolve) => setTimeout(resolve, 60));
  assert.equal(link.getAttribute('href'), '/prefix/links/manual');
  link.href =
    'https://docs.redhat.com/en/documentation/red_hat_satellite/6.19/another-guide';
  await new Promise((resolve) => setTimeout(resolve, 60));
  assert.equal(link.getAttribute('href'), '/prefix/links/manual');
  observer.disconnect();
});

test('observer passes visit added subtrees and changed attributes only', async () => {
  createDOM(
    '<a id="outside" href="https://docs.ansible.com/ansible/latest/guide">Ansible</a><button id="kept" data-ouia-component-id="doc-url-dropdown">Docs</button><main></main>'
  );
  const doc = document;
  const observer = installDocumentationHiding(
    doc,
    'Dokumentace',
    '/prefix/links/manual'
  );
  const documentQueries = [];
  const querySelectorAll = doc.querySelectorAll.bind(doc);
  jest.spyOn(doc, 'querySelectorAll').mockImplementation((selector) => {
    documentQueries.push(selector);
    return querySelectorAll(selector);
  });
  const wrapper = doc.createElement('div');
  wrapper.innerHTML =
    '<div data-ouia-component-id="action-buttons-dropdown"><a id="localized" data-ouia-component-id="Dokumentace-dropdown-item" href="/hosts/help">Dokumentace</a></div><a id="inside" href="https://docs.redhat.com/en/documentation/red_hat_satellite/6.19/guide">Docs</a><button id="audits" data-ouia-component-id="audits-documentation-button">Documentation</button>';
  doc.querySelector('main').appendChild(wrapper);
  await new Promise((resolve) => setTimeout(resolve, 60));
  assert.equal(documentQueries.length, 0);
  assert.equal(
    doc.getElementById('inside').getAttribute('href'),
    '/prefix/links/manual'
  );
  assert.equal(
    doc.getElementById('outside').getAttribute('href'),
    'https://docs.ansible.com/ansible/latest/guide'
  );
  assert(doc.getElementById('localized').classList.contains(hiddenClass));
  assert(doc.getElementById('audits').classList.contains(hiddenClass));
  assert(doc.getElementById('kept').classList.contains(hiddenClass));
  doc
    .getElementById('localized')
    .setAttribute('data-ouia-component-id', 'Export-dropdown-item');
  await new Promise((resolve) => setTimeout(resolve, 60));
  assert.equal(documentQueries.length, 0);
  assert(!doc.getElementById('localized').classList.contains(hiddenClass));
  assert(doc.getElementById('kept').classList.contains(hiddenClass));
  assert(doc.getElementById('audits').classList.contains(hiddenClass));
  observer.disconnect();
});

test('observer applies a mutation that arrives while a frame is scheduled', async () => {
  createDOM('<main></main>');
  const doc = document;
  const observer = installDocumentationHiding(
    doc,
    'Documentation',
    '/prefix/links/manual'
  );
  let frame = null;
  jest.spyOn(window, 'requestAnimationFrame').mockImplementation((callback) => {
    frame = callback;
    return 1;
  });
  const link = doc.createElement('a');
  link.href =
    'https://docs.redhat.com/en/documentation/red_hat_satellite/6.19/guide';
  doc.body.appendChild(link);
  await Promise.resolve();
  assert.equal(typeof frame, 'function');
  const scheduledFrame = frame;
  const button = doc.createElement('button');
  button.setAttribute('data-ouia-component-id', 'audits-documentation-button');
  doc.body.appendChild(button);
  await Promise.resolve();
  scheduledFrame();
  assert.equal(link.getAttribute('href'), '/prefix/links/manual');
  assert(button.classList.contains(hiddenClass));
  observer.disconnect();
});

test('Reports inline sentence stays complete even beside a hidden documentation button', async () => {
  createDOM(
    '<ul><li id="report"><div class="empty-state-description">If you wish to configure Puppet to forward its reports to Foreman, please follow <a href="/links/manual/3.5.4PuppetReports">setting up reporting</a> and <a href="/links/wiki/Mail_Notifications">e-mail reporting</a></div><button data-ouia-component-id="audits-documentation-button">Documentation</button></li></ul>'
  );
  const doc = document;
  hideDocumentation(doc);
  normalizeSatelliteDocumentation(doc, '/links/manual');
  assert.equal(
    doc.querySelector('.empty-state-description').textContent,
    'If you wish to configure Puppet to forward its reports to Foreman, please follow setting up reporting and e-mail reporting'
  );
  doc.querySelectorAll('.empty-state-description a').forEach((link) => {
    for (let node = link; node; node = node.parentElement) {
      assert.notEqual(window.getComputedStyle(node).display, 'none');
    }
  });
  assert.equal(
    window.getComputedStyle(doc.querySelector('button')).display,
    'none'
  );
});
