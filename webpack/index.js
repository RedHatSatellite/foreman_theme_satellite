import React from 'react';

import componentRegistry from 'foremanReact/components/componentRegistry';
import { addGlobalFill } from 'foremanReact/components/common/Fill/GlobalFill';
import { translate as __ } from 'foremanReact/common/I18n';
import { Helmet } from 'react-helmet';

import SatelliteUpgradeHelperCard from './components/fills/UpgradePage/SatelliteUpgradeHelperCard';

// register components for erb mounting
componentRegistry.register({ name: 'Helmet', type: Helmet });

addGlobalFill(
  'upgrade-page-upgrade-docs',
  'Satellite upgrade helper card',
  <SatelliteUpgradeHelperCard key="satellite-upgrade-helper-card" />,
  1000,
);
addGlobalFill(
  'upgrade-page-footer',
  'Satellite upgrade page footer',
  {
    helpDesc: __('If you require assistance or encounter issues, reach out to Red Hat Support or explore the resources available in the Customer Portal for troubleshooting.'),
    helpLinkText: __('Contact support'),
  },
  1000,
);
