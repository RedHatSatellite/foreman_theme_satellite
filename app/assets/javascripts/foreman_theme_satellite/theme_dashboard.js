function start_gridster(){
    var baseWidth = $(".gridster").width()/12 - 30;
    var gridster = $(".gridster>ul").gridster({
        widget_margins: [15, 10],
        widget_base_dimensions: [baseWidth, 360],
        max_size_x: 12,
        min_cols: 12,
        max_cols: 12,
        autogenerate_stylesheet: false
    }).data('gridster');
    refreshCharts();
    $(".gridster>ul>li[data-hide='true']").each(function(i, widget) {
        $(widget).hide();
        gridster.remove_widget(widget);
        $(".gridster>ul").append($(widget));
    });
}
