import React from 'react';

import componentRegistry from 'foremanReact/components/componentRegistry';
import { addGlobalFill } from 'foremanReact/components/common/Fill/GlobalFill';
import { translate as __ } from 'foremanReact/common/I18n';
import { foremanUrl } from 'foremanReact/common/helpers';
import { Helmet } from 'react-helmet';

import { installDocumentationHiding } from './documentation/hideDocumentation';

import SatelliteUpgradeHelperCard from './components/fills/UpgradePage/SatelliteUpgradeHelperCard';

const SATELLITE_FILL_WEIGHT = 1000;

// register components for erb mounting
componentRegistry.register({ name: 'Helmet', type: Helmet });

addGlobalFill(
  'upgrade-page-upgrade-docs',
  'Satellite upgrade helper card',
  <SatelliteUpgradeHelperCard key="satellite-upgrade-helper-card" />,
  SATELLITE_FILL_WEIGHT
);
addGlobalFill(
  'upgrade-page-footer',
  'Satellite upgrade page footer',
  {
    helpDesc: __(
      'If you require assistance or encounter issues, reach out to Red Hat Support or explore the resources available in the Customer Portal for troubleshooting.'
    ),
    helpLinkText: __('Contact support'),
  },
  SATELLITE_FILL_WEIGHT
);

if (document.readyState === 'loading') {
  document.addEventListener(
    'DOMContentLoaded',
    () =>
      installDocumentationHiding(
        document,
        __('Documentation'),
        foremanUrl('/links/manual')
      ),
    { once: true }
  );
} else {
  installDocumentationHiding(
    document,
    __('Documentation'),
    foremanUrl('/links/manual')
  );
}
