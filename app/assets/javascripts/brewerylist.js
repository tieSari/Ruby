$(document).ready(function () {
    var BEVERIES = {};
    if ($("#brewerytable").length > 0) {
        $.getJSON('breweries.json', function (breweries) {
            BEVERIES.list = breweries;
            BEVERIES.sort_by_name;
            BEVERIES.show();
        });
    }

    BEVERIES.show = function () {
        $("#brewerytable tr:gt(0)").remove();

        var table = $("#brewerytable");

        $.each(BEVERIES.list, function (index, brewery) {
            table.append('<tr>'
            + '<td>' + brewery['name'] + '</td>'
            + '<td>' + brewery['year'] + '</td>'
            + '<td>' + brewery['beers'].length + '</td>'
            + '</tr>');
        });
    };

    BEVERIES.sort_by_name = function () {
        BEVERIES.list.sort(function (a, b) {
            return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
        });
    };

    BEVERIES.sort_by_year = function () {
        BEVERIES.list.sort(function (a, b) {
            return a.year < b.year;
        });
    };

    BEVERIES.sort_by_beers = function () {
        BEVERIES.list.sort(function (a, b) {
            return a.beers.length < b.beers.length;
        });
    };

    $(document).ready(function () {
        $("#name").click(function (e) {
            BEVERIES.sort_by_name();
            BEVERIES.show();
            e.preventDefault();
        });

        $("#year").click(function (e) {
            BEVERIES.sort_by_year();
            BEVERIES.show();
            e.preventDefault();
        });

        $("#beercount").click(function (e) {
            BEVERIES.sort_by_beers();
            BEVERIES.show();
            e.preventDefault();
        });

        $.getJSON('breweries.json', function (breweries) {
            BEVERIES.list = breweries;
            BEVERIES.sort_by_name();
            BEVERIES.show();
        });

    });

});