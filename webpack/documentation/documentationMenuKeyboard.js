// PatternFly's legacy dropdown keeps references to CSS-hidden items. Handle
// navigation in affected menus before its handler attempts to focus those refs.
const navigationKeys = ['ArrowDown', 'ArrowUp', 'Home', 'End'];
const openingKeys = [...navigationKeys, 'Enter', ' '];
const dropdownSelector = '.pf-v5-c-dropdown';
const menuSelector = '.pf-v5-c-dropdown__menu';
const itemSelector = '[role="menuitem"]';

const isVisible = (node) => {
  const { defaultView } = node.ownerDocument;
  for (let ancestor = node; ancestor; ancestor = ancestor.parentElement) {
    const style = defaultView.getComputedStyle(ancestor);
    if (
      ancestor.hidden ||
      style.display === 'none' ||
      style.visibility === 'hidden'
    ) {
      return false;
    }
  }
  return true;
};

export default function installMenuKeyboard(doc, isDocumentationControl) {
  const frames = new Set();
  const navigate = (dropdown, key, current) => {
    const menu = dropdown.querySelector(menuSelector);
    if (!menu || !isVisible(menu)) return false;
    const items = [...menu.querySelectorAll(itemSelector)];
    if (!items.some(isDocumentationControl)) return false;
    const available = items.filter(
      (item) =>
        !isDocumentationControl(item) &&
        !item.hasAttribute('disabled') &&
        item.getAttribute('aria-disabled') !== 'true' &&
        isVisible(item)
    );
    const lastIndex = available.length - 1;
    const currentIndex = available.indexOf(current);
    let nextIndex = 0;
    if (key === 'End' || (key === 'ArrowUp' && currentIndex <= 0)) {
      nextIndex = lastIndex;
    } else if (key === 'ArrowUp') {
      nextIndex = currentIndex - 1;
    } else if (key === 'ArrowDown' && currentIndex >= 0) {
      nextIndex = (currentIndex + 1) % available.length;
    }
    const target =
      available[nextIndex] || dropdown.querySelector('[aria-expanded]');
    if (target) target.focus();
    return true;
  };

  const handleEvent = (event) => {
    const dropdown = event.target.closest(dropdownSelector);
    if (!dropdown) return;
    const toggle = event.target.closest('[aria-expanded]');
    const key = event.type === 'click' ? 'Enter' : event.key;
    if (event.type === 'keydown' && navigationKeys.includes(key)) {
      const current = event.target.closest(itemSelector);
      if (navigate(dropdown, key, current)) {
        event.preventDefault();
        event.stopImmediatePropagation();
        return;
      }
    }
    if (!toggle || !openingKeys.includes(key)) return;
    // Let React open the menu and PatternFly finish its initial focus first.
    // This also handles menus whose first item is hidden documentation.
    const frame = doc.defaultView.requestAnimationFrame(() => {
      frames.delete(frame);
      if (
        toggle.isConnected &&
        toggle.getAttribute('aria-expanded') === 'true'
      ) {
        navigate(dropdown, key, null);
      }
    });
    frames.add(frame);
  };

  doc.addEventListener('keydown', handleEvent, true);
  doc.addEventListener('click', handleEvent, true);
  return () => {
    doc.removeEventListener('keydown', handleEvent, true);
    doc.removeEventListener('click', handleEvent, true);
    frames.forEach((frame) => doc.defaultView.cancelAnimationFrame(frame));
  };
}
