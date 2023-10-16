import componentRegistry from 'foremanReact/components/componentRegistry';
import { Helmet } from 'react-helmet';

// register components for erb mounting
componentRegistry.register({ name: 'Helmet', type: Helmet });
