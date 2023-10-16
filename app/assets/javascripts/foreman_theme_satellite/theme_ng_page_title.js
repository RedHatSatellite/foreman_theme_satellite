if (typeof(angular) !== 'undefined') {
  angular.module('Bastion.components').config([ '$provide', function($provide) {
    $provide.decorator('PageTitle', [
      '$delegate',
      function ($delegate) {
        var originalSetTitle = $delegate.setTitle;
        $delegate.setTitle = function themeSetTitle(title, locals) {
          title = 'Red Hat Satellite - ' + title;
          originalSetTitle.apply($delegate, arguments)
        }
        return $delegate;
      }
    ]);
  }]);
}
