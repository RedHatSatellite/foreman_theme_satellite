import installMenuKeyboard from './documentationMenuKeyboard';

// Hide only identified documentation buttons and menu actions. Leave inline
// links and their surrounding text intact; never remove nodes owned by React.
export const hiddenClass = 'satellite-documentation-hidden';

const controlIds = [
  'doc-url-dropdown',
  'action-buttons-documentation',
  'register-host-documentation-button',
  'audits-documentation-button',
  'inventory-documentation-button',
  'upgrade-docs-button',
];

const controlIdSet = new Set(controlIds);

const controlSelector = controlIds
  .map((id) => `[data-ouia-component-id="${id}"]`)
  .join(',');

const dropdownItemSelector =
  '[data-ouia-component-id="action-buttons-dropdown"] [data-ouia-component-id]';

const httpHref = /^https?:\/\//i;

const satelliteDocsPattern =
  /\/(?:[a-z]{2}(?:-[a-z]{2})?\/documentation|documentation\/[a-z]{2}(?:-[a-z]{2})?)\/red_hat_satellite(?:\/|$)/i;

const satelliteArticles = new Set([
  '/solutions/satellite6-tasks',
  '/articles/1586183',
]);

const isDocumentationControl = (node, documentationLabel) => {
  const id = node.getAttribute('data-ouia-component-id');
  if (!id) return false;
  if (controlIdSet.has(id)) return true;
  return (
    id === `${documentationLabel}-dropdown-item` &&
    node.closest('[data-ouia-component-id="action-buttons-dropdown"]') !== null
  );
};

const syncDocumentationControl = (node, documentationLabel) => {
  if (!node || node.nodeType !== 1) return;
  if (isDocumentationControl(node, documentationLabel)) {
    node.classList.add(hiddenClass);
    return;
  }
  if (node.classList.contains(hiddenClass)) node.classList.remove(hiddenClass);
};

const hideDocumentationIn = (root, documentationLabel) => {
  if (!root || root.nodeType !== 1) return;
  syncDocumentationControl(root, documentationLabel);
  root.querySelectorAll(controlSelector).forEach((node) => {
    node.classList.add(hiddenClass);
  });
  const itemId = `${documentationLabel}-dropdown-item`;
  root.querySelectorAll(dropdownItemSelector).forEach((node) => {
    if (node.getAttribute('data-ouia-component-id') === itemId) {
      node.classList.add(hiddenClass);
    }
  });
};

export const hideDocumentation = (
  doc,
  documentationLabel = 'Documentation'
) => {
  // Recalculate so a React node reused for a functional link becomes visible.
  doc
    .querySelectorAll(`.${hiddenClass}`)
    .forEach((node) => node.classList.remove(hiddenClass));
  hideDocumentationIn(doc.documentElement || doc, documentationLabel);
};

const normalizeLink = (link, landingPath) => {
  const href = link.getAttribute('href');
  // A rewrite sets href to the landing path and the observer hears that
  // write. Matching it here makes the follow-up a no-op.
  if (!href || href === landingPath || !httpHref.test(href)) return;
  let url;
  try {
    url = new URL(href);
  } catch (error) {
    return;
  }
  const satelliteArticle =
    url.hostname === 'access.redhat.com' &&
    satelliteArticles.has(url.pathname.replace(/\/$/, ''));
  if (satelliteDocsPattern.test(url.pathname) || satelliteArticle) {
    link.setAttribute('href', landingPath);
  }
};

const normalizeIn = (root, landingPath) => {
  if (!root || root.nodeType !== 1) return;
  if (typeof root.matches === 'function' && root.matches('a[href]')) {
    normalizeLink(root, landingPath);
  }
  root.querySelectorAll('a[href]').forEach((link) => {
    normalizeLink(link, landingPath);
  });
};

// Direct Satellite documentation links bypass LinksController. Send them
// through its landing redirect too, including links in stored notifications.
export const normalizeSatelliteDocumentation = (doc, landingPath) => {
  normalizeIn(doc.documentElement || doc, landingPath);
};

export const installDocumentationHiding = (
  doc,
  documentationLabel = 'Documentation',
  landingPath
) => {
  hideDocumentation(doc, documentationLabel);
  if (landingPath) normalizeSatelliteDocumentation(doc, landingPath);

  const removeMenuKeyboard = installMenuKeyboard(doc, (node) =>
    isDocumentationControl(node, documentationLabel)
  );
  const pending = [];
  let scheduled = false;
  const flush = () => {
    scheduled = false;
    const batch = pending.splice(0);
    batch.forEach((change) => {
      if (change.type === 'childList') {
        change.added.forEach((node) => {
          hideDocumentationIn(node, documentationLabel);
          if (landingPath) normalizeIn(node, landingPath);
        });
        return;
      }
      if (change.name === 'href') {
        if (
          landingPath &&
          change.target.nodeType === 1 &&
          change.target.matches('a[href]')
        ) {
          normalizeLink(change.target, landingPath);
        }
        return;
      }
      syncDocumentationControl(change.target, documentationLabel);
    });
  };

  const observer = new doc.defaultView.MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      if (mutation.type === 'childList') {
        if (mutation.addedNodes.length === 0) return;
        pending.push({ type: 'childList', added: [...mutation.addedNodes] });
        return;
      }
      pending.push({
        type: 'attributes',
        name: mutation.attributeName,
        target: mutation.target,
      });
    });
    if (scheduled || pending.length === 0) return;
    scheduled = true;
    doc.defaultView.requestAnimationFrame(flush);
  });
  observer.observe(doc.body, {
    subtree: true,
    childList: true,
    attributes: true,
    attributeFilter: ['data-ouia-component-id', 'href'],
  });
  return {
    disconnect: () => {
      observer.disconnect();
      pending.length = 0;
      removeMenuKeyboard();
    },
  };
};
