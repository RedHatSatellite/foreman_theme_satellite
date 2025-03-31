import React from 'react';

import { Card, CardBody, CardTitle, CardFooter, Button } from '@patternfly/react-core';
import { ExternalLinkSquareAltIcon } from '@patternfly/react-icons';

import { translate as __ } from 'foremanReact/common/I18n';
import { getUpgradeURL } from 'foremanReact/common/helpers';

const SatelliteUpgradeHelperCard = () => (
  <Card ouiaId="upgrade-docs-satellite-helper" isFlat>
    <CardTitle component="h4">{__('Satellite upgrade helper')}</CardTitle>
    <CardBody>
      {__('Generate a customized upgrade plan based on your current Satellite environment.' +
      ' This tool will guide you through the upgrade process and provide additional steps to avoid known issues specific to your upgrade scenario.')}
    </CardBody>
    <CardFooter>
      <Button
        ouiaId="upgrade-helper-button"
        component="a"
        variant="link"
        icon={<ExternalLinkSquareAltIcon />}
        iconPosition="right"
        target="_blank"
        isInline
        href={getUpgradeURL('helper')}
      >
        {__('Try the Satellite upgrade helper')}
      </Button>
    </CardFooter>
  </Card>
);

export default SatelliteUpgradeHelperCard;
